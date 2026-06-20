import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/app_database.dart';
import '../../../database/database_provider.dart';

/// All completed and active sessions, newest first.
/// autoDispose ensures a fresh fetch every time the History tab is visited.
final allSessionsProvider = FutureProvider.autoDispose<List<Session>>((ref) {
  return ref.watch(databaseProvider).sessionsDao.getAllSessions();
});

/// Good/bad reading counts for one session.
final sessionSummaryProvider =
    FutureProvider.autoDispose.family<Map<String, int>, int>((ref, sessionId) {
  return ref
      .watch(databaseProvider)
      .sensorReadingsDao
      .getPostureSummaryForSession(sessionId);
});
