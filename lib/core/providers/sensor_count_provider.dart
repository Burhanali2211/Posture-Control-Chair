import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SensorCountNotifier extends StateNotifier<int> {
  static const _key = 'sensor_count';

  SensorCountNotifier() : super(4) {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) state = prefs.getInt(_key) ?? 4;
  }

  Future<void> setCount(int count) async {
    state = count;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, count);
  }
}

final sensorCountProvider =
    StateNotifierProvider<SensorCountNotifier, int>((_) => SensorCountNotifier());
