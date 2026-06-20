import 'package:drift/drift.dart';

class Sessions extends Table {
  IntColumn    get id              => integer().autoIncrement()();
  DateTimeColumn get startTime    => dateTime()();
  DateTimeColumn get endTime      => dateTime().nullable()();
  IntColumn    get durationSeconds => integer().withDefault(const Constant(0))();
}
