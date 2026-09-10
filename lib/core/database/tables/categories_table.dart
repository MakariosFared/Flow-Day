import 'package:drift/drift.dart';

@DataClassName('CategoryRow')
class CategoriesTable extends Table {
  @override
  String get tableName => 'categories';

  TextColumn get id => text()();
  TextColumn get name => text().unique()();
  TextColumn get icon => text()();

  @override
  Set<Column> get primaryKey => {id};
}
