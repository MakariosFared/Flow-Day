import 'package:drift/drift.dart';
import 'tasks_table.dart';

@DataClassName('ScheduleBlockRow')
@TableIndex(
  name: 'idx_schedule_blocks_plan_date_start',
  columns: {#planDate, #startMinute},
)
@TableIndex(
  name: 'idx_schedule_blocks_task_plan_date',
  columns: {#taskId, #planDate},
)
class ScheduleBlocksTable extends Table {
  @override
  String get tableName => 'schedule_blocks';

  TextColumn get id => text()();
  TextColumn get planDate => text()(); // YYYY-MM-DD
  IntColumn get startMinute => integer()(); // minutes after midnight
  IntColumn get endMinute => integer()(); // minutes after midnight
  TextColumn get blockType => text()(); // 'task' | 'break'
  TextColumn get source => text()(); // 'auto' | 'manual'
  TextColumn get taskId => text().nullable().references(
    TasksTable,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
