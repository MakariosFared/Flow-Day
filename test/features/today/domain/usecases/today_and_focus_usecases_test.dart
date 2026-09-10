import 'package:flutter_test/flutter_test.dart';
import 'package:flowday/core/clock/clock.dart';
import 'package:flowday/core/database/app_database.dart';
import 'package:flowday/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:flowday/features/tasks/domain/entities/task.dart';
import 'package:flowday/features/today/data/repositories/daily_plan_repository_impl.dart';
import 'package:flowday/features/today/data/repositories/focus_session_repository_impl.dart';
import 'package:flowday/features/today/data/repositories/schedule_repository_impl.dart';
import 'package:flowday/features/today/domain/entities/schedule_block.dart';
import 'package:flowday/features/today/domain/usecases/focus_usecases.dart';
import 'package:flowday/features/today/domain/usecases/schedule_usecases.dart';

void main() {
  late AppDatabase db;
  late TaskRepositoryImpl taskRepo;
  late ScheduleRepositoryImpl scheduleRepo;
  late DailyPlanRepositoryImpl dailyPlanRepo;
  late FocusSessionRepositoryImpl focusRepo;
  late FakeClock clock;

  late StartFocus startFocus;
  late PauseFocus pauseFocus;
  late ResumeFocus resumeFocus;
  late CompleteFocus completeFocus;
  late RescheduleTask rescheduleTask;
  late GetTodayPlan getTodayPlan;

  setUp(() {
    db = AppDatabase.inMemory();
    taskRepo = TaskRepositoryImpl(db);
    scheduleRepo = ScheduleRepositoryImpl(db);
    dailyPlanRepo = DailyPlanRepositoryImpl(db);
    focusRepo = FocusSessionRepositoryImpl(db);
    clock = FakeClock(DateTime(2026, 9, 10, 9, 0));

    startFocus = StartFocus(taskRepo, focusRepo, clock);
    pauseFocus = PauseFocus(taskRepo, focusRepo, clock);
    resumeFocus = ResumeFocus(focusRepo, clock);
    completeFocus = CompleteFocus(taskRepo, focusRepo, clock);
    rescheduleTask = RescheduleTask(taskRepo, scheduleRepo, clock);
    getTodayPlan = GetTodayPlan(taskRepo, scheduleRepo, dailyPlanRepo, clock);
  });

  tearDown(() async {
    await db.close();
  });

  group('Focus & Today Use Cases', () {
    test('Focus flow preserves Task inProgress status during Pause', () async {
      final task = Task(
        id: 'task-flow',
        title: 'Focus Testing',
        estimatedDuration: const Duration(hours: 1),
        status: TaskStatus.scheduled,
        createdAt: clock.now(),
        updatedAt: clock.now(),
      );
      await taskRepo.save(task);

      // 1. Start Focus
      final session1 = await startFocus('task-flow');
      expect(session1.state, equals(FocusSessionState.active));

      var currentTask = await taskRepo.getById('task-flow');
      expect(currentTask!.status, equals(TaskStatus.inProgress));

      // Advance clock 30 minutes
      clock.advance(const Duration(minutes: 30));

      // 2. Pause Focus
      final pausedSession = await pauseFocus('task-flow');
      expect(pausedSession.state, equals(FocusSessionState.paused));
      expect(pausedSession.activeDuration, equals(const Duration(minutes: 30)));

      // CRITICAL ARCHITECTURAL ASSERTION:
      // When focus is paused, Task status REMAINS inProgress!
      currentTask = await taskRepo.getById('task-flow');
      expect(
        currentTask!.status,
        equals(TaskStatus.inProgress),
        reason: 'Task must remain inProgress when FocusSession is paused',
      );
      expect(currentTask.actualDuration, equals(const Duration(minutes: 30)));

      // Advance clock 15 minutes while paused (should not count towards active focus)
      clock.advance(const Duration(minutes: 15));

      // 3. Resume Focus
      final resumedSession = await resumeFocus('task-flow');
      expect(resumedSession.state, equals(FocusSessionState.active));

      // Advance clock 20 minutes of active work
      clock.advance(const Duration(minutes: 20));

      // 4. Complete Focus
      final completedTask = await completeFocus('task-flow');
      expect(completedTask.status, equals(TaskStatus.completed));
      expect(completedTask.actualDuration, equals(const Duration(minutes: 50)));

      final finalSession = await focusRepo.getActiveOrPausedSession(
        'task-flow',
      );
      expect(
        finalSession,
        isNull,
      ); // completed session is no longer active or paused
    });

    test(
      'RescheduleTask creates manual block and transitions pending task to scheduled',
      () async {
        final date = DateTime(2026, 9, 10);
        final task = Task(
          id: 't-resched',
          title: 'Reschedule Me',
          estimatedDuration: const Duration(hours: 1),
          status: TaskStatus.pending,
          createdAt: clock.now(),
          updatedAt: clock.now(),
        );
        await taskRepo.save(task);

        final block = await rescheduleTask(
          taskId: 't-resched',
          date: date,
          start: DateTime(2026, 9, 10, 14, 0),
          end: DateTime(2026, 9, 10, 15, 0),
        );

        expect(block.source, equals(ScheduleBlockSource.manual));

        final updatedTask = await taskRepo.getById('t-resched');
        expect(updatedTask!.status, equals(TaskStatus.scheduled));
      },
    );

    test(
      'GetTodayPlan aggregates view data, active current task, and derived overdue state',
      () async {
        final date = DateTime(2026, 9, 10);
        clock.setTime(DateTime(2026, 9, 10, 10, 30));

        // Task 1: Currently active
        await taskRepo.save(
          Task(
            id: 't1',
            title: 'Current Task',
            estimatedDuration: const Duration(hours: 1),
            status: TaskStatus.inProgress,
            createdAt: date,
            updatedAt: date,
          ),
        );
        await scheduleRepo.saveManualBlock(
          ScheduleBlock(
            id: 'b1',
            date: date,
            start: DateTime(2026, 9, 10, 10, 0),
            end: DateTime(2026, 9, 10, 11, 0),
            type: ScheduleBlockType.task,
            source: ScheduleBlockSource.manual,
            taskId: 't1',
          ),
        );

        // Task 2: Overdue (estimated end was 10:00, now is 10:30, and status is inProgress)
        await taskRepo.save(
          Task(
            id: 't2',
            title: 'Overdue Task',
            estimatedDuration: const Duration(hours: 1),
            status: TaskStatus.inProgress,
            createdAt: date,
            updatedAt: date,
          ),
        );
        await scheduleRepo.saveManualBlock(
          ScheduleBlock(
            id: 'b2',
            date: date,
            start: DateTime(2026, 9, 10, 9, 0),
            end: DateTime(2026, 9, 10, 10, 0),
            type: ScheduleBlockType.task,
            source: ScheduleBlockSource.manual,
            taskId: 't2',
          ),
        );

        final viewData = await getTodayPlan(date);
        expect(viewData.blocks.length, equals(2));
        expect(viewData.currentTask?.id, equals('t1'));
        expect(viewData.overdueTaskIds, contains('t2'));
      },
    );
  });
}
