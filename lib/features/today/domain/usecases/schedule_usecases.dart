import 'package:uuid/uuid.dart';

import '../../../../core/clock/clock.dart';
import '../../../../core/errors/failures.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/domain/repositories/task_repository.dart';
import '../entities/schedule_block.dart';
import '../repositories/schedule_repository.dart';

class RescheduleTask {
  const RescheduleTask(this._taskRepo, this._scheduleRepo, this._clock);
  final TaskRepository _taskRepo;
  final ScheduleRepository _scheduleRepo;
  final Clock _clock;

  Future<ScheduleBlock> call({
    required String taskId,
    required DateTime date,
    required DateTime start,
    required DateTime end,
  }) async {
    final task = await _taskRepo.getById(taskId);
    if (task == null) {
      throw NotFoundFailure('Task not found: $taskId');
    }
    if (end.isBefore(start) || end == start) {
      throw const ValidationFailure('End time must be after start time');
    }

    // Critical Architectural Decision:
    // Manual scheduling decision takes precedence.
    final block = ScheduleBlock(
      id: const Uuid().v4(),
      date: date,
      start: start,
      end: end,
      type: ScheduleBlockType.task,
      source: ScheduleBlockSource.manual,
      taskId: taskId,
    );

    await _scheduleRepo.saveManualBlock(block);

    // If task was pending, update status to scheduled
    if (task.status == TaskStatus.pending) {
      await _taskRepo.save(
        task.copyWith(status: TaskStatus.scheduled, updatedAt: _clock.now()),
      );
    }

    return block;
  }
}

class TodayPlanViewData {
  const TodayPlanViewData({
    required this.date,
    required this.dailyPlan,
    required this.blocks,
    required this.tasksById,
    required this.currentTask,
    required this.overdueTaskIds,
    required this.completedTasksCount,
    required this.totalTasksCount,
  });

  final DateTime date;
  final DailyPlan? dailyPlan;
  final List<ScheduleBlock> blocks;
  final Map<String, Task> tasksById;
  final Task? currentTask;
  final Set<String> overdueTaskIds;
  final int completedTasksCount;
  final int totalTasksCount;

  double get progressPercentage => totalTasksCount == 0
      ? 0.0
      : (completedTasksCount / totalTasksCount).clamp(0.0, 1.0);
}

class GetTodayPlan {
  const GetTodayPlan(
    this._taskRepo,
    this._scheduleRepo,
    this._dailyPlanRepo,
    this._clock,
  );

  final TaskRepository _taskRepo;
  final ScheduleRepository _scheduleRepo;
  final DailyPlanRepository _dailyPlanRepo;
  final Clock _clock;

  Future<TodayPlanViewData> call(DateTime date) async {
    final now = _clock.now();
    final plan = await _dailyPlanRepo.getForDate(date);
    final blocks = await _scheduleRepo.getForDate(date);
    final allTasks = await _taskRepo.getAll();

    final tasksById = <String, Task>{};
    for (final task in allTasks) {
      tasksById[task.id] = task;
    }

    Task? currentTask;
    final overdueTaskIds = <String>{};

    for (final block in blocks) {
      if (block.type == ScheduleBlockType.task && block.taskId != null) {
        final task = tasksById[block.taskId];
        if (task != null) {
          // Check if active right now
          if (now.isAfter(block.start) && now.isBefore(block.end)) {
            currentTask = task;
          }
          // Check derived overdue state
          if (task.isOverdue(now: now, scheduledEnd: block.end)) {
            overdueTaskIds.add(task.id);
          }
        }
      }
    }

    final taskBlocks = blocks
        .where((b) => b.type == ScheduleBlockType.task)
        .toList();
    final completedCount = taskBlocks
        .where((b) => tasksById[b.taskId]?.status == TaskStatus.completed)
        .length;

    return TodayPlanViewData(
      date: date,
      dailyPlan: plan,
      blocks: blocks,
      tasksById: tasksById,
      currentTask: currentTask,
      overdueTaskIds: overdueTaskIds,
      completedTasksCount: completedCount,
      totalTasksCount: taskBlocks.length,
    );
  }
}
