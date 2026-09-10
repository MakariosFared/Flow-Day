import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Future<Task?> getById(String id) async {
    try {
      final query = _db.select(_db.tasksTable)..where((t) => t.id.equals(id));
      final row = await query.getSingleOrNull();
      return row != null ? _toDomain(row) : null;
    } catch (e) {
      throw DatabaseFailure('Failed to get task by id: $id', e);
    }
  }

  @override
  Future<List<Task>> getAll() async {
    try {
      final rows = await _db.select(_db.tasksTable).get();
      return rows.map(_toDomain).toList();
    } catch (e) {
      throw DatabaseFailure('Failed to get all tasks', e);
    }
  }

  @override
  Stream<List<Task>> watchAll() {
    return _db
        .select(_db.tasksTable)
        .watch()
        .map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<void> save(Task task) async {
    try {
      final companion = TasksTableCompanion(
        id: Value(task.id),
        title: Value(task.title),
        description: Value(task.description),
        categoryId: Value(task.categoryId),
        priority: Value(task.priority.rank),
        estimatedDurationMinutes: Value(task.estimatedDuration.inMinutes),
        actualDurationSeconds: Value(task.actualDuration.inSeconds),
        status: Value(task.status.name),
        dueDate: Value(
          task.dueDate != null ? DateTimeUtils.formatDate(task.dueDate!) : null,
        ),
        preferredTimeWindow: Value(task.preferredTimeWindow.name),
        energyLevel: Value(task.energyLevel?.name),
        recurrenceTemplateId: Value(task.recurrenceTemplateId),
        createdAt: Value(task.createdAt.toUtc().toIso8601String()),
        updatedAt: Value(task.updatedAt.toUtc().toIso8601String()),
        completedAt: Value(task.completedAt?.toUtc().toIso8601String()),
      );

      await _db.into(_db.tasksTable).insertOnConflictUpdate(companion);
    } catch (e) {
      throw DatabaseFailure('Failed to save task ${task.id}', e);
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await (_db.delete(_db.tasksTable)..where((t) => t.id.equals(id))).go();
    } catch (e) {
      throw DatabaseFailure('Failed to delete task $id', e);
    }
  }

  static Task _toDomain(TaskRow row) {
    return Task(
      id: row.id,
      title: row.title,
      description: row.description,
      categoryId: row.categoryId,
      priority: switch (row.priority) {
        1 => TaskPriority.low,
        3 => TaskPriority.high,
        _ => TaskPriority.medium,
      },
      estimatedDuration: Duration(minutes: row.estimatedDurationMinutes),
      actualDuration: Duration(seconds: row.actualDurationSeconds),
      status: TaskStatus.values.firstWhere(
        (s) => s.name == row.status,
        orElse: () => TaskStatus.pending,
      ),
      dueDate: row.dueDate != null
          ? DateTimeUtils.parseDate(row.dueDate!)
          : null,
      preferredTimeWindow: PreferredTimeWindow.values.firstWhere(
        (w) => w.name == row.preferredTimeWindow,
        orElse: () => PreferredTimeWindow.anytime,
      ),
      energyLevel: row.energyLevel != null
          ? EnergyLevel.values.firstWhere((e) => e.name == row.energyLevel)
          : null,
      recurrenceTemplateId: row.recurrenceTemplateId,
      createdAt: DateTime.parse(row.createdAt).toLocal(),
      updatedAt: DateTime.parse(row.updatedAt).toLocal(),
      completedAt: row.completedAt != null
          ? DateTime.parse(row.completedAt!).toLocal()
          : null,
    );
  }
}
