import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/sessions_table.dart';

part 'sessions_dao.g.dart';

@DriftAccessor(tables: [Sessions])
class SessionsDao extends DatabaseAccessor<AppDatabase>
    with _$SessionsDaoMixin {
  SessionsDao(super.db);

  Future<int> insertSession(SessionsCompanion entry) =>
      into(sessions).insert(entry);

  Future<void> closeSession(int id, DateTime endTime, int durationSeconds) =>
      (update(sessions)..where((t) => t.id.equals(id))).write(
        SessionsCompanion(
          endTime:         Value(endTime),
          durationSeconds: Value(durationSeconds),
        ),
      );

  Future<List<Session>> getAllSessions() =>
      (select(sessions)
            ..orderBy([(t) => OrderingTerm.desc(t.startTime)]))
          .get();

  Future<Session?> getActiveSession() =>
      (select(sessions)..where((t) => t.endTime.isNull()))
          .getSingleOrNull();
}
