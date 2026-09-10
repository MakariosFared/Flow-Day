import '../entities/task.dart';

abstract interface class TaskRepository {
  Future<Task?> getById(String id);
  Future<List<Task>> getAll();
  Stream<List<Task>> watchAll();
  Future<void> save(Task task);
  Future<void> delete(String id);
}

abstract interface class CategoryRepository {
  Future<List<Category>> getAll();
  Stream<List<Category>> watchAll();
}

abstract interface class RecurrenceRepository {
  Future<RecurrenceTemplate?> getById(String id);
  Future<void> saveTemplate(RecurrenceTemplate template);
}
