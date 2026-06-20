import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/database_provider.dart';

class DailyDuration {
  final DateTime date;
  final double minutes;
  const DailyDuration({required this.date, required this.minutes});
}

/// Sessions grouped by day for the last 7 days, oldest → newest.
final weeklyDurationProvider =
    FutureProvider.autoDispose<List<DailyDuration>>((ref) async {
  final db = ref.watch(databaseProvider);
  final sessions = await db.sessionsDao.getAllSessions();

  final now   = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final byDate = <DateTime, double>{};
  for (var i = 6; i >= 0; i--) {
    byDate[today.subtract(Duration(days: i))] = 0;
  }

  for (final session in sessions) {
    final d = DateTime(
      session.startTime.year,
      session.startTime.month,
      session.startTime.day,
    );
    if (byDate.containsKey(d)) {
      byDate[d] = (byDate[d] ?? 0) + session.durationSeconds / 60;
    }
  }

  return byDate.entries
      .map((e) => DailyDuration(date: e.key, minutes: e.value))
      .toList();
});

/// Aggregate good/bad reading counts across the last 7 days.
final overallPostureSummaryProvider =
    FutureProvider.autoDispose<Map<String, int>>((ref) async {
  final db      = ref.watch(databaseProvider);
  final now     = DateTime.now();
  final weekAgo = now.subtract(const Duration(days: 7));
  final rows    = await db.sensorReadingsDao.getReadingsBetween(weekAgo, now);

  var good = 0, bad = 0;
  for (final r in rows) {
    if (r.postureLabel == 'good') {
      good++;
    } else if (r.postureLabel == 'bad') {
      bad++;
    }
  }
  return {'good': good, 'bad': bad};
});
