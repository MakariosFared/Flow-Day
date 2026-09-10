import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowday/core/clock/clock.dart';
import 'package:flowday/core/database/app_database.dart';
import 'package:flowday/core/di/providers.dart';
import 'package:flowday/features/tasks/domain/entities/task.dart';
import 'package:flowday/features/tasks/presentation/controllers/tasks_controller.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;
  late FakeClock clock;

  setUp(() {
    db = AppDatabase.inMemory();
    clock = FakeClock(DateTime(2026, 9, 10, 9, 0));
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        clockProvider.overrideWithValue(clock),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  group('TasksController & FilteredTasksProvider', () {
    test('createTask saves task and emits it via stream', () async {
      final controller = container.read(tasksControllerProvider);

      final task = await controller.createTask(
        title: 'Learn Riverpod',
        estimatedDuration: const Duration(hours: 1),
        priority: TaskPriority.high,
      );

      expect(task.title, equals('Learn Riverpod'));
      expect(task.priority, equals(TaskPriority.high));
      expect(task.status, equals(TaskStatus.pending));

      final repo = container.read(taskRepositoryProvider);
      final tasks = await repo.getAll();
      expect(tasks.length, equals(1));
      expect(tasks.first.id, equals(task.id));
    });

    test(
      'filteredTasksProvider filters and sorts tasks by priority and status',
      () async {
        final controller = container.read(tasksControllerProvider);
        final repo = container.read(taskRepositoryProvider);

        // Create Low, Medium, High tasks
        final low = await controller.createTask(
          title: 'Low Priority Task',
          estimatedDuration: const Duration(minutes: 30),
          priority: TaskPriority.low,
        );
        final high = await controller.createTask(
          title: 'High Priority Task',
          estimatedDuration: const Duration(hours: 1),
          priority: TaskPriority.high,
        );
        final med = await controller.createTask(
          title: 'Med Priority Task',
          estimatedDuration: const Duration(minutes: 45),
          priority: TaskPriority.medium,
        );

        // Filter: all (Default)
        await container.read(tasksStreamProvider.future);
        var list = container.read(filteredTasksProvider).value!;
        expect(
          list.map((t) => t.id).toList(),
          equals([high.id, med.id, low.id]),
        );

        // Complete the medium task: move to scheduled first per lifecycle rules, then start focus & complete
        await repo.save(med.copyWith(status: TaskStatus.scheduled));
        await controller.startFocus(med.id);
        await controller.completeTask(med.id);

        // Refresh stream listener
        final updatedList = await repo.getAll();
        expect(
          updatedList.firstWhere((t) => t.id == med.id).status,
          equals(TaskStatus.completed),
        );

        // Filter: active
        container.read(taskFilterProvider.notifier).state = TaskFilter.active;
        // Trigger stream update
        container.invalidate(tasksStreamProvider);
        await container.read(tasksStreamProvider.future);
        list = container.read(filteredTasksProvider).value!;
        expect(list.length, equals(2));
        expect(list.map((t) => t.id), containsAll([high.id, low.id]));

        // Filter: completed
        container.read(taskFilterProvider.notifier).state =
            TaskFilter.completed;
        list = container.read(filteredTasksProvider).value!;
        expect(list.length, equals(1));
        expect(list.first.id, equals(med.id));
      },
    );

    test('deleteTask and undoDelete restore task smoothly', () async {
      final controller = container.read(tasksControllerProvider);
      final repo = container.read(taskRepositoryProvider);

      final task = await controller.createTask(
        title: 'Temporary Task',
        estimatedDuration: const Duration(minutes: 15),
      );

      var tasks = await repo.getAll();
      expect(tasks.length, equals(1));

      final token = await controller.deleteTask(task.id);
      expect(token, isNotNull);

      tasks = await repo.getAll();
      expect(tasks.isEmpty, isTrue);

      // Undo deletion
      await controller.undoDelete(token!);
      tasks = await repo.getAll();
      expect(tasks.length, equals(1));
      expect(tasks.first.id, equals(task.id));
    });
  });
}
