import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import '../../core/constants/ble_constants.dart';
import 'ble_packet.dart';

enum BleConnectionState { idle, scanning, connecting, connected, disconnected, error }

class BluetoothService {
  fbp.BluetoothDevice? _device;
  StreamSubscription<List<int>>? _notifySub;

  final _packetController = StreamController<BlePacket>.broadcast();
  final _stateController  = StreamController<BleConnectionState>.broadcast();

  Stream<BlePacket> get packets => _packetController.stream;
  Stream<BleConnectionState> get state => _stateController.stream;
  String? get connectedDeviceName => _device?.platformName;

  String? _lastError;
  String? get lastError => _lastError;

  int _reconnectAttempts = 0;

  Future<void> startScan() async {
    _emit(BleConnectionState.scanning);

    try {
      await fbp.FlutterBluePlus.startScan(
        withServices: [fbp.Guid(BleConstants.serviceUuid)],
        timeout: const Duration(seconds: BleConstants.scanTimeoutSeconds),
      );
    } catch (e) {
      _lastError = (e is PlatformException &&
              (e.message?.contains('Bluetooth must be turned on') ?? false))
          ? 'Turn on Bluetooth and try again'
          : 'Scan failed — try again';
      _emit(BleConnectionState.error);
      return;
    }

    var found    = false;
    var scanSeen = false; // guards against initial false emission on isScanning

    StreamSubscription<List<fbp.ScanResult>>? resultsSub;
    StreamSubscription<bool>? scanStateSub;

    resultsSub = fbp.FlutterBluePlus.scanResults.listen((results) async {
      if (results.isEmpty || found) return;
      found = true;
      scanStateSub?.cancel();
      await fbp.FlutterBluePlus.stopScan();
      await _connect(results.first.device);
    });

    scanStateSub = fbp.FlutterBluePlus.isScanning.listen((scanning) {
      if (scanning) { scanSeen = true; return; }
      if (scanSeen && !found) {
        resultsSub?.cancel();
        _emit(BleConnectionState.disconnected);
      }
    });
  }

  Future<void> _connect(fbp.BluetoothDevice device) async {
    _emit(BleConnectionState.connecting);
    _device = device;

    try {
      await device.connect(autoConnect: false);
      _reconnectAttempts = 0;
      _emit(BleConnectionState.connected);
      await _subscribeToCharacteristic(device);
      _listenForDisconnect(device);
    } catch (_) {
      _lastError = 'Connection failed — move closer and try again';
      _emit(BleConnectionState.error);
    }
  }

  Future<void> _subscribeToCharacteristic(fbp.BluetoothDevice device) async {
    final services = await device.discoverServices();
    for (final svc in services) {
      if (svc.uuid.str128 != BleConstants.serviceUuid) continue;
      for (final char in svc.characteristics) {
        if (char.uuid.str128 != BleConstants.characteristicUuid) continue;
        await char.setNotifyValue(true);
        _notifySub = char.lastValueStream.listen((bytes) {
          if (bytes.isEmpty) return;
          try {
            _packetController.add(BlePacket.fromBytes(bytes));
          } catch (_) {
            // Malformed packet — skip silently.
          }
        });
        return;
      }
    }
  }

  void _listenForDisconnect(fbp.BluetoothDevice device) {
    device.connectionState.listen((s) async {
      if (s == fbp.BluetoothConnectionState.disconnected) {
        _emit(BleConnectionState.disconnected);
        await _attemptReconnect();
      }
    });
  }

  Future<void> _attemptReconnect() async {
    if (_device == null) return;
    if (_reconnectAttempts >= BleConstants.maxReconnectAttempts) {
      _lastError = 'Could not reconnect — try scanning again';
      _emit(BleConnectionState.error);
      return;
    }
    _reconnectAttempts++;
    await Future.delayed(Duration(seconds: _reconnectAttempts * 2));
    await _connect(_device!);
  }

  Future<void> disconnect() async {
    await _notifySub?.cancel();
    await _device?.disconnect();
    _device = null;
    _reconnectAttempts = 0;
    _emit(BleConnectionState.idle);
  }

  void _emit(BleConnectionState s) => _stateController.add(s);

  void dispose() {
    _notifySub?.cancel();
    _packetController.close();
    _stateController.close();
  }
}
