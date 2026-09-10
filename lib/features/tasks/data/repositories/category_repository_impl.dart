import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Future<List<Category>> getAll() async {
    try {
      final rows = await _db.select(_db.categoriesTable).get();
      return rows.map(_toDomain).toList();
    } catch (e) {
      throw DatabaseFailure('Failed to get categories', e);
    }
  }

  @override
  Stream<List<Category>> watchAll() {
    return _db
        .select(_db.categoriesTable)
        .watch()
        .map((rows) => rows.map(_toDomain).toList());
  }

  static Category _toDomain(CategoryRow row) {
    return Category(id: row.id, name: row.name, icon: row.icon);
  }
}
