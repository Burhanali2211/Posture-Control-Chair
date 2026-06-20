import 'dart:convert';

/// Parsed sensor data from one BLE notification.
/// ESP32 sends: {"l": 312, "r": 298, "b": 521} or {"l": 312, "r": 298, "b": 521, "n": 180}
class BlePacket {
  final int left;
  final int right;
  final int back;
  final int neck;
  final DateTime receivedAt;

  const BlePacket({
    required this.left,
    required this.right,
    required this.back,
    this.neck = 0,
    required this.receivedAt,
  });

  factory BlePacket.fromBytes(List<int> bytes) {
    final json = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
    return BlePacket(
      left:       (json['l'] as num).toInt(),
      right:      (json['r'] as num).toInt(),
      back:       (json['b'] as num).toInt(),
      neck:       json['n'] != null ? (json['n'] as num).toInt() : 0,
      receivedAt: DateTime.now(),
    );
  }
}
