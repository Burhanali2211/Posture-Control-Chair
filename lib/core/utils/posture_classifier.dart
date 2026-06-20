import '../constants/posture_thresholds.dart';

enum PostureLabel { good, bad, unknown }

abstract final class PostureClassifier {
  static PostureLabel classify(
    int left,
    int right,
    int back, {
    int neck         = 0,
    int backMin      = PostureThresholds.backPressureMin,
    int imbalanceMax = PostureThresholds.sideImbalanceMax,
    int neckMax      = PostureThresholds.neckPressureMax,
  }) {
    final backOk    = back > backMin;
    final balanceOk = (left - right).abs() < imbalanceMax;
    // neck == 0 means sensor absent; skip neck check.
    final neckOk    = neck == 0 || neck < neckMax;
    return (backOk && balanceOk && neckOk) ? PostureLabel.good : PostureLabel.bad;
  }

  static String toLabel(PostureLabel label) => switch (label) {
        PostureLabel.good    => 'good',
        PostureLabel.bad     => 'bad',
        PostureLabel.unknown => 'unknown',
      };

  static PostureLabel fromLabel(String label) => switch (label) {
        'good'    => PostureLabel.good,
        'bad'     => PostureLabel.bad,
        _         => PostureLabel.unknown,
      };
}
