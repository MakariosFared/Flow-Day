import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/di/providers.dart';
import '../../../today/domain/entities/schedule_block.dart';
import '../../../today/domain/usecases/focus_usecases.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/task_usecases.dart';

enum TaskFilter { all, active, completed }

final taskFilterProvider = StateProvider<TaskFilter>((ref) => TaskFilter.all);

final tasksStreamProvider = StreamProvider<List<Task>>((ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return repo.watchAll();
});

final categoriesStreamProvider = StreamProvider<List<Category>>((ref) {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.watchAll();
});

final taskByIdProvider = StreamProvider.family<Task?, String>((ref, id) {
  final repo = ref.watch(taskRepositoryProvider);
  return repo.watchAll().map(
    (tasks) => tasks.where((t) => t.id == id).firstOrNull,
  );
});

final filteredTasksProvider = Provider<AsyncValue<List<Task>>>((ref) {
  final tasksAsync = ref.watch(tasksStreamProvider);
  final filter = ref.watch(taskFilterProvider);

  return tasksAsync.whenData((tasks) {
    var filtered = switch (filter) {
      TaskFilter.all => tasks.where((t) => t.status != TaskStatus.cancelled),
      TaskFilter.active => tasks.where(
        (t) =>
            t.status == TaskStatus.pending ||
            t.status == TaskStatus.scheduled ||
            t.status == TaskStatus.inProgress,
      ),
      TaskFilter.completed => tasks.where(
        (t) => t.status == TaskStatus.completed,
      ),
    }.toList();

    // Natural sort: Priority descending (High -> Medium -> Low), then creation date
    filtered.sort((a, b) {
      if (a.status == TaskStatus.completed &&
          b.status != TaskStatus.completed) {
        return 1;
      }
      if (a.status != TaskStatus.completed &&
          b.status == TaskStatus.completed) {
        return -1;
      }
      final priorityComparison = b.priority.rank.compareTo(a.priority.rank);
      if (priorityComparison != 0) return priorityComparison;
      return b.createdAt.compareTo(a.createdAt);
    });

    return filtered;
  });
});

class TasksController {
  const TasksController({
    CreateTask? createTaskUseCase,
    UpdateTask? updateTaskUseCase,
    CompleteTask? completeTaskUseCase,
    DeleteTask? deleteTaskUseCase,
    StartFocus? startFocusUseCase,
  }) : _createTaskUseCase = createTaskUseCase,
       _updateTaskUseCase = updateTaskUseCase,
       _completeTaskUseCase = completeTaskUseCase,
       _deleteTaskUseCase = deleteTaskUseCase,
       _startFocusUseCase = startFocusUseCase;

  final CreateTask? _createTaskUseCase;
  final UpdateTask? _updateTaskUseCase;
  final CompleteTask? _completeTaskUseCase;
  final DeleteTask? _deleteTaskUseCase;
  final StartFocus? _startFocusUseCase;

  Future<Task> createTask({
    required String title,
    required Duration estimatedDuration,
    String? description,
    String? categoryId,
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueDate,
    PreferredTimeWindow preferredTimeWindow = PreferredTimeWindow.anytime,
    EnergyLevel? energyLevel,
  }) async {
    final id = const Uuid().v4();
    return _createTaskUseCase!(
      id: id,
      title: title,
      estimatedDuration: estimatedDuration,
      description: description,
      categoryId: categoryId,
      priority: priority,
      dueDate: dueDate,
      preferredTimeWindow: preferredTimeWindow,
      energyLevel: energyLevel,
    );
  }

  Future<Task> updateTask(Task task) async {
    return _updateTaskUseCase!(task);
  }

  Future<Task> completeTask(String taskId) async {
    return _completeTaskUseCase!(taskId);
  }

  Future<TaskUndoToken?> deleteTask(String taskId) async {
    return _deleteTaskUseCase!(taskId);
  }

  Future<void> undoDelete(TaskUndoToken token) async {
    await _deleteTaskUseCase!.undo(token);
  }

  Future<FocusSession> startFocus(String taskId) async {
    return _startFocusUseCase!(taskId);
  }
}

final tasksControllerProvider = Provider<TasksController>((ref) {
  return TasksController(
    createTaskUseCase: ref.watch(createTaskProvider),
    updateTaskUseCase: ref.watch(updateTaskProvider),
    completeTaskUseCase: ref.watch(completeTaskProvider),
    deleteTaskUseCase: ref.watch(deleteTaskProvider),
    startFocusUseCase: ref.watch(startFocusProvider),
  );
});
