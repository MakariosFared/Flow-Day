import 'package:flutter_test/flutter_test.dart';
import 'package:flowday/core/database/app_database.dart';
import 'package:flowday/features/tasks/data/repositories/category_repository_impl.dart';
import 'package:flowday/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:flowday/features/tasks/domain/entities/task.dart';
import 'package:flowday/features/today/data/repositories/daily_stats_repository_impl.dart';
import 'package:flowday/features/today/data/repositories/focus_session_repository_impl.dart';
import 'package:flowday/features/today/data/repositories/schedule_repository_impl.dart';
import 'package:flowday/features/today/domain/entities/schedule_block.dart';

void main() {
  late AppDatabase db;
  late CategoryRepositoryImpl categoryRepo;
  late TaskRepositoryImpl taskRepo;
  late ScheduleRepositoryImpl scheduleRepo;
  late DailyStatsRepositoryImpl dailyStatsRepo;
  late FocusSessionRepositoryImpl focusRepo;

  setUp(() {
    db = AppDatabase.inMemory();
    categoryRepo = CategoryRepositoryImpl(db);
    taskRepo = TaskRepositoryImpl(db);
    scheduleRepo = ScheduleRepositoryImpl(db);
    dailyStatsRepo = DailyStatsRepositoryImpl(db);
    focusRepo = FocusSessionRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Database & Repositories Integration', () {
    test('Phase 1 fixed categories are seeded idempotently', () async {
      final categories = await categoryRepo.getAll();
      expect(categories.length, equals(6));
      expect(
        categories.map((c) => c.name),
        containsAll([
          'Work',
          'Learning',
          'Health',
          'Personal',
          'People',
          'Reading',
        ]),
      );
    });

    test('TaskRepository performs full CRUD correctly', () async {
      final now = DateTime(2026, 9, 10, 9, 0);
      final task = Task(
        id: 'task-123',
        title: 'Build Drift Integration',
        estimatedDuration: const Duration(hours: 1, minutes: 30),
        status: TaskStatus.pending,
        priority: TaskPriority.high,
        createdAt: now,
        updatedAt: now,
      );

      // Save
      await taskRepo.save(task);

      // Get
      final retrieved = await taskRepo.getById('task-123');
      expect(retrieved, isNotNull);
      expect(retrieved!.title, equals('Build Drift Integration'));
      expect(retrieved.priority, equals(TaskPriority.high));
      expect(
        retrieved.estimatedDuration,
        equals(const Duration(hours: 1, minutes: 30)),
      );

      // Delete
      await taskRepo.delete('task-123');
      final afterDelete = await taskRepo.getById('task-123');
      expect(afterDelete, isNull);
    });

    test(
      'ScheduleRepository strictly preserves manual blocks when replacing automatic blocks',
      () async {
        final date = DateTime(2026, 9, 10);
        final taskNow = DateTime(2026, 9, 10, 9, 0);
        await taskRepo.save(
          Task(
            id: 't-manual',
            title: 'Important Meeting',
            estimatedDuration: const Duration(hours: 1),
            status: TaskStatus.scheduled,
            createdAt: taskNow,
            updatedAt: taskNow,
          ),
        );
        await taskRepo.save(
          Task(
            id: 't-auto-old',
            title: 'Old Auto Task',
            estimatedDuration: const Duration(hours: 1),
            status: TaskStatus.scheduled,
            createdAt: taskNow,
            updatedAt: taskNow,
          ),
        );
        await taskRepo.save(
          Task(
            id: 't-auto-new',
            title: 'New Auto Task',
            estimatedDuration: const Duration(hours: 1),
            status: TaskStatus.scheduled,
            createdAt: taskNow,
            updatedAt: taskNow,
          ),
        );

        // Save manual block
        final manualBlock = ScheduleBlock(
          id: 'block-manual',
          date: date,
          start: DateTime(2026, 9, 10, 10, 0),
          end: DateTime(2026, 9, 10, 11, 0),
          type: ScheduleBlockType.task,
          source: ScheduleBlockSource.manual,
          taskId: 't-manual',
        );
        await scheduleRepo.saveManualBlock(manualBlock);

        // Save initial auto block
        final oldAutoBlock = ScheduleBlock(
          id: 'block-auto-1',
          date: date,
          start: DateTime(2026, 9, 10, 11, 0),
          end: DateTime(2026, 9, 10, 12, 0),
          type: ScheduleBlockType.task,
          source: ScheduleBlockSource.automatic,
          taskId: 't-auto-old',
        );
        await scheduleRepo.replaceAutomaticBlocks(date, [oldAutoBlock]);

        var blocks = await scheduleRepo.getForDate(date);
        expect(blocks.length, equals(2));

        // Re-plan: replace automatic blocks with a new block
        final newAutoBlock = ScheduleBlock(
          id: 'block-auto-2',
          date: date,
          start: DateTime(2026, 9, 10, 14, 0),
          end: DateTime(2026, 9, 10, 15, 0),
          type: ScheduleBlockType.task,
          source: ScheduleBlockSource.automatic,
          taskId: 't-auto-new',
        );
        await scheduleRepo.replaceAutomaticBlocks(date, [newAutoBlock]);

        // Verify: manual block is PRESERVED, old auto block is REPLACED by new auto block
        blocks = await scheduleRepo.getForDate(date);
        expect(blocks.length, equals(2));
        expect(
          blocks.any((b) => b.id == 'block-manual'),
          isTrue,
          reason: 'Manual block must be preserved',
        );
        expect(
          blocks.any((b) => b.id == 'block-auto-1'),
          isFalse,
          reason: 'Old auto block must be removed',
        );
        expect(
          blocks.any((b) => b.id == 'block-auto-2'),
          isTrue,
          reason: 'New auto block must be inserted',
        );
      },
    );

    test(
      'Deleting a task does NOT destroy historical DailyStats snapshots',
      () async {
        final date = DateTime(2026, 9, 10);
        final now = DateTime(2026, 9, 10, 9, 0);

        // Create task
        final task = Task(
          id: 'task-historical',
          title: 'Task to be deleted later',
          estimatedDuration: const Duration(hours: 1),
          status: TaskStatus.completed,
          createdAt: now,
          updatedAt: now,
        );
        await taskRepo.save(task);

        // Record daily stats snapshot
        final stats = DailyStats(
          id: 'stats-2026-09-10',
          date: date,
          tasksPlanned: 5,
          tasksCompleted: 4,
          plannedMinutes: 300,
          completedMinutes: 240,
          overloadedMinutes: 0,
          tasksRolledOver: 0,
        );
        await dailyStatsRepo.save(stats);

        // Delete the task
        await taskRepo.delete('task-historical');

        // Verify daily stats is still fully intact!
        final retrievedStats = await dailyStatsRepo.getForDate(date);
        expect(retrievedStats, isNotNull);
        expect(retrievedStats!.tasksPlanned, equals(5));
        expect(retrievedStats.tasksCompleted, equals(4));
        expect(retrievedStats.completedMinutes, equals(240));
      },
    );

    test(
      'FocusSessionRepository saves and recovers active/paused sessions',
      () async {
        final now = DateTime(2026, 9, 10, 10, 0);
        await taskRepo.save(
          Task(
            id: 'task-focus',
            title: 'Deep Focus Work',
            estimatedDuration: const Duration(hours: 2),
            status: TaskStatus.inProgress,
            createdAt: now,
            updatedAt: now,
          ),
        );

        final session = FocusSession(
          id: 'focus-1',
          taskId: 'task-focus',
          state: FocusSessionState.paused,
          startedAt: now,
          pausedAt: now.add(const Duration(minutes: 40)),
          activeDuration: const Duration(minutes: 40),
        );

        await focusRepo.save(session);

        final recovered = await focusRepo.getActiveOrPausedSession(
          'task-focus',
        );
        expect(recovered, isNotNull);
        expect(recovered!.state, equals(FocusSessionState.paused));
        expect(recovered.activeDuration, equals(const Duration(minutes: 40)));
      },
    );
  });
}
