import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bluetooth_service.dart';

final bluetoothServiceProvider = Provider<BluetoothService>((ref) {
  final service = BluetoothService();
  ref.onDispose(service.dispose);
  return service;
});
