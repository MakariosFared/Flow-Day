import 'package:drift/drift.dart';

@DataClassName('DailyPlanRow')
class DailyPlansTable extends Table {
  @override
  String get tableName => 'daily_plans';

  TextColumn get id => text()();
  TextColumn get planDate => text().unique()(); // YYYY-MM-DD
  IntColumn get availableStartMinute => integer()();
  IntColumn get availableEndMinute => integer()();
  IntColumn get plannedMinutes => integer().withDefault(const Constant(0))();
  IntColumn get completedMinutes => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
