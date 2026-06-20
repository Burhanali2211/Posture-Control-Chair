import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/sessions_table.dart';
import '../tables/sensor_readings_table.dart';

part 'sensor_readings_dao.g.dart';

@DriftAccessor(tables: [Sessions, SensorReadings])
class SensorReadingsDao extends DatabaseAccessor<AppDatabase>
    with _$SensorReadingsDaoMixin {
  SensorReadingsDao(super.db);

  Future<void> insertBatch(List<SensorReadingsCompanion> entries) =>
      batch((b) => b.insertAll(sensorReadings, entries));

  Future<List<SensorReading>> getReadingsForSession(int sessionId) =>
      (select(sensorReadings)
            ..where((t) => t.sessionId.equals(sessionId))
            ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
          .get();

  Future<List<SensorReading>> getReadingsBetween(
    DateTime from,
    DateTime to,
  ) =>
      (select(sensorReadings)
            ..where(
              (t) =>
                  t.timestamp.isBiggerOrEqualValue(from) &
                  t.timestamp.isSmallerOrEqualValue(to),
            ))
          .get();

  // Count good/bad readings for a session — used by analytics.
  Future<Map<String, int>> getPostureSummaryForSession(int sessionId) async {
    final rows = await (select(sensorReadings)
          ..where((t) => t.sessionId.equals(sessionId)))
        .get();
    final good = rows.where((r) => r.postureLabel == 'good').length;
    final bad  = rows.where((r) => r.postureLabel == 'bad').length;
    return {'good': good, 'bad': bad};
  }
}
