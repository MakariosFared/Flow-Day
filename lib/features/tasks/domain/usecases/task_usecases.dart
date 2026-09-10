import '../../../../core/clock/clock.dart';
import '../../../../core/errors/failures.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class CreateTask {
  const CreateTask(this._repository, this._clock);
  final TaskRepository _repository;
  final Clock _clock;

  Future<Task> call({
    required String id,
    required String title,
    required Duration estimatedDuration,
    String? description,
    String? categoryId,
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueDate,
    PreferredTimeWindow preferredTimeWindow = PreferredTimeWindow.anytime,
    EnergyLevel? energyLevel,
    String? recurrenceTemplateId,
  }) async {
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      throw const ValidationFailure('Task title cannot be empty');
    }
    if (estimatedDuration <= Duration.zero) {
      throw const ValidationFailure('Task estimated duration must be positive');
    }

    final now = _clock.now();
    final task = Task(
      id: id,
      title: trimmedTitle,
      description: description,
      categoryId: categoryId,
      priority: priority,
      estimatedDuration: estimatedDuration,
      status: TaskStatus.pending,
      dueDate: dueDate,
      preferredTimeWindow: preferredTimeWindow,
      energyLevel: energyLevel,
      recurrenceTemplateId: recurrenceTemplateId,
      createdAt: now,
      updatedAt: now,
    );

    await _repository.save(task);
    return task;
  }
}

class UpdateTask {
  const UpdateTask(this._repository, this._clock);
  final TaskRepository _repository;
  final Clock _clock;

  Future<Task> call(Task task) async {
    if (task.title.trim().isEmpty) {
      throw const ValidationFailure('Task title cannot be empty');
    }
    if (task.estimatedDuration <= Duration.zero) {
      throw const ValidationFailure('Task estimated duration must be positive');
    }

    final updated = task.copyWith(
      title: task.title.trim(),
      updatedAt: _clock.now(),
    );
    await _repository.save(updated);
    return updated;
  }
}

/// Session-based undoable deletion token.
class TaskUndoToken {
  const TaskUndoToken({required this.deletedTask});
  final Task deletedTask;
}

class DeleteTask {
  const DeleteTask(this._repository);
  final TaskRepository _repository;

  Future<TaskUndoToken?> call(String taskId) async {
    final existing = await _repository.getById(taskId);
    if (existing == null) {
      return null;
    }
    await _repository.delete(taskId);
    return TaskUndoToken(deletedTask: existing);
  }

  Future<void> undo(TaskUndoToken token) async {
    await _repository.save(token.deletedTask);
  }
}

class CompleteTask {
  const CompleteTask(this._repository, this._clock);
  final TaskRepository _repository;
  final Clock _clock;

  Future<Task> call(String taskId) async {
    final task = await _repository.getById(taskId);
    if (task == null) {
      throw NotFoundFailure('Task not found: $taskId');
    }
    if (!task.canTransitionTo(TaskStatus.completed)) {
      throw ValidationFailure(
        'Invalid state transition: Cannot transition task from ${task.status.name} to completed',
      );
    }

    final now = _clock.now();
    final completedTask = task.copyWith(
      status: TaskStatus.completed,
      completedAt: now,
      updatedAt: now,
    );
    await _repository.save(completedTask);
    return completedTask;
  }
}

class GetTasks {
  const GetTasks(this._repository);
  final TaskRepository _repository;

  Future<List<Task>> call() => _repository.getAll();
  Stream<List<Task>> watch() => _repository.watchAll();
}

class GetTaskById {
  const GetTaskById(this._repository);
  final TaskRepository _repository;

  Future<Task?> call(String id) => _repository.getById(id);
}
