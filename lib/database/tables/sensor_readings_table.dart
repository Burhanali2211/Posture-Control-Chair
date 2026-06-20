import 'package:drift/drift.dart';
import 'sessions_table.dart';

class SensorReadings extends Table {
  IntColumn      get id             => integer().autoIncrement()();
  IntColumn      get sessionId      => integer().references(Sessions, #id)();
  DateTimeColumn get timestamp      => dateTime()();
  IntColumn      get leftPressure   => integer()();
  IntColumn      get rightPressure  => integer()();
  IntColumn      get backPressure   => integer()();
  IntColumn      get neckPressure   => integer().withDefault(const Constant(0))();
  TextColumn     get postureLabel   => text()();
}
