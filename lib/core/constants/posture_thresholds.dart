// Tunable thresholds for app-side posture classification.
// Sensor range: 0–1023 (12-bit analog).
abstract final class PostureThresholds {
  static const backPressureMin      = 400;
  static const sideImbalanceMax     = 150;
  // Neck pressure above this indicates forward head posture.
  static const neckPressureMax      = 500;
  static const writeIntervalSeconds = 2;
}
