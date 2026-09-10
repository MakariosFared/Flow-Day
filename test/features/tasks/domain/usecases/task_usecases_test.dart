import 'package:flutter_test/flutter_test.dart';
import 'package:flowday/core/clock/clock.dart';
import 'package:flowday/core/database/app_database.dart';
import 'package:flowday/core/errors/failures.dart';
import 'package:flowday/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:flowday/features/tasks/domain/entities/task.dart';
import 'package:flowday/features/tasks/domain/usecases/task_usecases.dart';

void main() {
  late AppDatabase db;
  late TaskRepositoryImpl repo;
  late FakeClock clock;
  late CreateTask createTask;
  late UpdateTask updateTask;
  late DeleteTask deleteTask;
  late CompleteTask completeTask;

  setUp(() {
    db = AppDatabase.inMemory();
    repo = TaskRepositoryImpl(db);
    clock = FakeClock(DateTime(2026, 9, 10, 8, 0));
    createTask = CreateTask(repo, clock);
    updateTask = UpdateTask(repo, clock);
    deleteTask = DeleteTask(repo);
    completeTask = CompleteTask(repo, clock);
  });

  tearDown(() async {
    await db.close();
  });

  group('Task Use Cases', () {
    test(
      'CreateTask creates and persists a pending task with validation',
      () async {
        // Empty title throws ValidationFailure
        expect(
          () => createTask(
            id: '1',
            title: '  ',
            estimatedDuration: const Duration(minutes: 30),
          ),
          throwsA(isA<ValidationFailure>()),
        );

        // Duration <= 0 throws ValidationFailure
        expect(
          () => createTask(
            id: '2',
            title: 'Title',
            estimatedDuration: Duration.zero,
          ),
          throwsA(isA<ValidationFailure>()),
        );

        final task = await createTask(
          id: 'task-1',
          title: 'Study Dart Isolates',
          estimatedDuration: const Duration(minutes: 45),
          priority: TaskPriority.high,
        );

        expect(task.status, equals(TaskStatus.pending));
        expect(task.priority, equals(TaskPriority.high));
        expect(task.createdAt, equals(DateTime(2026, 9, 10, 8, 0)));

        final saved = await repo.getById('task-1');
        expect(saved, isNotNull);
        expect(saved!.title, equals('Study Dart Isolates'));
      },
    );

    test('UpdateTask modifies task and updates timestamp', () async {
      final task = await createTask(
        id: 'task-update',
        title: 'Initial Title',
        estimatedDuration: const Duration(hours: 1),
      );

      clock.advance(const Duration(minutes: 10));
      final updated = await updateTask(task.copyWith(title: 'Updated Title'));

      expect(updated.title, equals('Updated Title'));
      expect(updated.updatedAt, equals(DateTime(2026, 9, 10, 8, 10)));

      final saved = await repo.getById('task-update');
      expect(saved!.title, equals('Updated Title'));
    });

    test('DeleteTask supports session-based Undo', () async {
      await createTask(
        id: 'task-del',
        title: 'Task To Delete',
        estimatedDuration: const Duration(hours: 1),
      );

      final token = await deleteTask('task-del');
      expect(token, isNotNull);
      expect(token!.deletedTask.title, equals('Task To Delete'));

      // Confirm deleted
      var retrieved = await repo.getById('task-del');
      expect(retrieved, isNull);

      // Perform Undo
      await deleteTask.undo(token);
      retrieved = await repo.getById('task-del');
      expect(retrieved, isNotNull);
      expect(retrieved!.id, equals('task-del'));
    });

    test(
      'CompleteTask transitions only valid tasks and marks completedAt',
      () async {
        final task = await createTask(
          id: 'task-comp',
          title: 'Task to Complete',
          estimatedDuration: const Duration(hours: 1),
        );

        // Transitioning directly from pending to completed is invalid per spec!
        expect(() => completeTask(task.id), throwsA(isA<ValidationFailure>()));

        // Move to inProgress via repo update
        await repo.save(task.copyWith(status: TaskStatus.inProgress));

        clock.advance(const Duration(minutes: 50));
        final completed = await completeTask(task.id);

        expect(completed.status, equals(TaskStatus.completed));
        expect(completed.completedAt, equals(DateTime(2026, 9, 10, 8, 50)));
      },
    );
  });
}
