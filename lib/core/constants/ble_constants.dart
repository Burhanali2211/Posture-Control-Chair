// Placeholder UUIDs — swap with real ESP32 firmware values when ready.
abstract final class BleConstants {
  static const serviceUuid        = '4fafc201-1fb5-459e-8fcc-c5c9c331914b';
  static const characteristicUuid = 'beb5483e-36e1-4688-b7f5-ea07361b26a8';
  static const deviceNamePrefix   = 'PostureChair';
  static const scanTimeoutSeconds = 10;
  static const maxReconnectAttempts = 3;
}
