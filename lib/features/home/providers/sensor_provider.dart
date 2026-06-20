import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/posture_thresholds_provider.dart';
import '../../../core/utils/posture_classifier.dart';
import '../../../services/bluetooth/ble_packet.dart';
import '../../../services/bluetooth/bluetooth_service_provider.dart';

/// Raw BLE packet stream — emits every notification from the ESP32.
final sensorStreamProvider = StreamProvider<BlePacket>((ref) {
  final service = ref.watch(bluetoothServiceProvider);
  return service.packets;
});

/// Latest packet value — null while disconnected or before first packet.
final latestPacketProvider = Provider<BlePacket?>((ref) {
  return ref.watch(sensorStreamProvider).valueOrNull;
});

/// Derived posture label from the latest packet using current thresholds.
final currentPostureProvider = Provider<PostureLabel>((ref) {
  final packet     = ref.watch(latestPacketProvider);
  if (packet == null) return PostureLabel.unknown;
  final thresholds = ref.watch(postureThresholdsProvider);
  return PostureClassifier.classify(
    packet.left,
    packet.right,
    packet.back,
    neck:         packet.neck,
    backMin:      thresholds.backPressureMin,
    imbalanceMax: thresholds.sideImbalanceMax,
    neckMax:      thresholds.neckPressureMax,
  );
});
