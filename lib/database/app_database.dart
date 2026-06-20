import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables/sessions_table.dart';
import 'tables/sensor_readings_table.dart';
import 'daos/sessions_dao.dart';
import 'daos/sensor_readings_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Sessions, SensorReadings],
  daos:   [SessionsDao, SensorReadingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(sensorReadings, sensorReadings.neckPressure);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir  = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'posture_chair.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
