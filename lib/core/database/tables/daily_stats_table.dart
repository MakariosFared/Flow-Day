import 'package:drift/drift.dart';

@DataClassName('DailyStatsRow')
class DailyStatsTable extends Table {
  @override
  String get tableName => 'daily_stats';

  TextColumn get id => text()();
  TextColumn get statsDate => text().unique()(); // YYYY-MM-DD
  IntColumn get tasksPlanned => integer().withDefault(const Constant(0))();
  IntColumn get tasksCompleted => integer().withDefault(const Constant(0))();
  IntColumn get plannedMinutes => integer().withDefault(const Constant(0))();
  IntColumn get completedMinutes => integer().withDefault(const Constant(0))();
  IntColumn get overloadedMinutes => integer().withDefault(const Constant(0))();
  IntColumn get tasksRolledOver => integer().withDefault(const Constant(0))();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
