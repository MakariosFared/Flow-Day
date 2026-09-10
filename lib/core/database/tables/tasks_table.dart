import 'package:drift/drift.dart';
import 'categories_table.dart';
import 'recurrence_templates_table.dart';

@DataClassName('TaskRow')
@TableIndex(name: 'idx_tasks_status', columns: {#status})
@TableIndex(name: 'idx_tasks_due_date', columns: {#dueDate})
@TableIndex(name: 'idx_tasks_category_id', columns: {#categoryId})
class TasksTable extends Table {
  @override
  String get tableName => 'tasks';

  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get categoryId => text().nullable().references(
    CategoriesTable,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get priority => integer().withDefault(const Constant(2))();
  IntColumn get estimatedDurationMinutes => integer()();
  IntColumn get actualDurationSeconds =>
      integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get dueDate => text().nullable()(); // YYYY-MM-DD
  TextColumn get preferredTimeWindow =>
      text().withDefault(const Constant('anytime'))();
  TextColumn get energyLevel => text().nullable()();
  TextColumn get recurrenceTemplateId => text().nullable().references(
    RecurrenceTemplatesTable,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get completedAt => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
