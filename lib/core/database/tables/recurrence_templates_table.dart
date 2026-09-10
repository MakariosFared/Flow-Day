import 'package:drift/drift.dart';
import 'categories_table.dart';

@DataClassName('RecurrenceTemplateRow')
class RecurrenceTemplatesTable extends Table {
  @override
  String get tableName => 'recurrence_templates';

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
  TextColumn get preferredTimeWindow =>
      text().withDefault(const Constant('anytime'))();
  TextColumn get energyLevel => text().nullable()();
  TextColumn get recurrenceType => text()(); // 'daily' | 'weekly'
  TextColumn get recurrenceDays =>
      text().withDefault(const Constant('[]'))(); // JSON encoded list of ints
  TextColumn get startDate => text()(); // YYYY-MM-DD
  TextColumn get endDate => text().nullable()(); // YYYY-MM-DD
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
