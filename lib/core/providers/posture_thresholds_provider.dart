import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/posture_thresholds.dart';

class PostureThresholdsState {
  final int backPressureMin;
  final int sideImbalanceMax;
  final int neckPressureMax;

  const PostureThresholdsState({
    this.backPressureMin  = PostureThresholds.backPressureMin,
    this.sideImbalanceMax = PostureThresholds.sideImbalanceMax,
    this.neckPressureMax  = PostureThresholds.neckPressureMax,
  });

  PostureThresholdsState copyWith({
    int? backPressureMin,
    int? sideImbalanceMax,
    int? neckPressureMax,
  }) =>
      PostureThresholdsState(
        backPressureMin:  backPressureMin  ?? this.backPressureMin,
        sideImbalanceMax: sideImbalanceMax ?? this.sideImbalanceMax,
        neckPressureMax:  neckPressureMax  ?? this.neckPressureMax,
      );
}

class PostureThresholdsNotifier
    extends StateNotifier<PostureThresholdsState> {
  PostureThresholdsNotifier() : super(const PostureThresholdsState()) {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    state = PostureThresholdsState(
      backPressureMin:  prefs.getInt('thresh_back')    ?? PostureThresholds.backPressureMin,
      sideImbalanceMax: prefs.getInt('thresh_balance') ?? PostureThresholds.sideImbalanceMax,
      neckPressureMax:  prefs.getInt('thresh_neck')    ?? PostureThresholds.neckPressureMax,
    );
  }

  Future<void> setBackPressureMin(int v) async {
    state = state.copyWith(backPressureMin: v);
    (await SharedPreferences.getInstance()).setInt('thresh_back', v);
  }

  Future<void> setSideImbalanceMax(int v) async {
    state = state.copyWith(sideImbalanceMax: v);
    (await SharedPreferences.getInstance()).setInt('thresh_balance', v);
  }

  Future<void> setNeckPressureMax(int v) async {
    state = state.copyWith(neckPressureMax: v);
    (await SharedPreferences.getInstance()).setInt('thresh_neck', v);
  }
}

final postureThresholdsProvider =
    StateNotifierProvider<PostureThresholdsNotifier, PostureThresholdsState>(
  (_) => PostureThresholdsNotifier(),
);
