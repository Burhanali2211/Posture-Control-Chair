import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/bluetooth/bluetooth_service.dart';
import '../../../services/bluetooth/bluetooth_service_provider.dart';

class BleState {
  final BleConnectionState connectionState;
  final String? deviceName;
  final String? errorMessage;

  const BleState({
    required this.connectionState,
    this.deviceName,
    this.errorMessage,
  });

  BleState copyWith({
    BleConnectionState? connectionState,
    String? deviceName,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) =>
      BleState(
        connectionState: connectionState ?? this.connectionState,
        deviceName:      deviceName      ?? this.deviceName,
        errorMessage:    clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      );

  bool get isConnected    => connectionState == BleConnectionState.connected;
  bool get isScanning     => connectionState == BleConnectionState.scanning;
  bool get isConnecting   => connectionState == BleConnectionState.connecting;
  bool get hasError       => connectionState == BleConnectionState.error;
  bool get isDisconnected =>
      connectionState == BleConnectionState.disconnected ||
      connectionState == BleConnectionState.idle;
}

class BluetoothNotifier extends StateNotifier<BleState> {
  final BluetoothService _service;
  StreamSubscription<BleConnectionState>? _sub;

  BluetoothNotifier(this._service)
      : super(const BleState(connectionState: BleConnectionState.idle)) {
    _sub = _service.state.listen((s) {
      state = state.copyWith(
        connectionState:   s,
        deviceName:        s == BleConnectionState.connected
            ? _service.connectedDeviceName
            : state.deviceName,
        errorMessage:      s == BleConnectionState.error ? _service.lastError : null,
        clearErrorMessage: s != BleConnectionState.error,
      );
    });
  }

  Future<void> scan() => _service.startScan();
  Future<void> disconnect() => _service.disconnect();

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

final bluetoothProvider =
    StateNotifierProvider<BluetoothNotifier, BleState>((ref) {
  final service = ref.watch(bluetoothServiceProvider);
  return BluetoothNotifier(service);
});
