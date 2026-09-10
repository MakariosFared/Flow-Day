import 'package:drift/drift.dart';
import 'tasks_table.dart';

@DataClassName('FocusSessionRow')
@TableIndex(name: 'idx_focus_sessions_task_id', columns: {#taskId})
@TableIndex(name: 'idx_focus_sessions_state', columns: {#state})
class FocusSessionsTable extends Table {
  @override
  String get tableName => 'focus_sessions';

  TextColumn get id => text()();
  TextColumn get taskId =>
      text().references(TasksTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get state =>
      text()(); // 'active' | 'paused' | 'completed' | 'abandoned'
  TextColumn get startedAt => text()();
  TextColumn get pausedAt => text().nullable()();
  TextColumn get endedAt => text().nullable()();
  IntColumn get activeDurationSeconds =>
      integer().withDefault(const Constant(0))();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
