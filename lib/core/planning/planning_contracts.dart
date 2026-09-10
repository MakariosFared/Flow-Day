import '../../features/tasks/domain/entities/task.dart';
import '../../features/today/domain/entities/schedule_block.dart';

class PlanningRequest {
  const PlanningRequest({
    required this.date,
    required this.availableStart,
    required this.availableEnd,
    required this.tasks,
    required this.existingBlocks,
    this.breakDuration = const Duration(minutes: 15),
  });

  final DateTime date;
  final DateTime availableStart;
  final DateTime availableEnd;
  final List<Task> tasks;
  final List<ScheduleBlock> existingBlocks;
  final Duration breakDuration;

  int get availableMinutes => availableEnd.difference(availableStart).inMinutes;
}

class TimeSlot {
  TimeSlot(this.start, this.end) : assert(end.isAfter(start));
  final DateTime start;
  final DateTime end;
  Duration get duration => end.difference(start);
}

class RealityCheck {
  const RealityCheck({
    required this.availableMinutes,
    required this.plannedMinutes,
    this.suggestedToMoveTaskIds = const [],
  });
  final int availableMinutes;
  final int plannedMinutes;
  final List<String> suggestedToMoveTaskIds;

  int get overloadedMinutes => plannedMinutes - availableMinutes;
  bool get isOverloaded => overloadedMinutes > 0;
}

class PlanningResult {
  const PlanningResult({
    required this.blocks,
    required this.unscheduledTaskIds,
    required this.realityCheck,
  });
  final List<ScheduleBlock> blocks;
  final List<String> unscheduledTaskIds;
  final RealityCheck realityCheck;
}

/// Abstract contract for ordering tasks according to ranking rules:
/// 1. Due today
/// 2. Priority
/// 3. Preferred time window
/// 4. Energy level curve
/// 5. Duration fit
/// 6. Creation order (tie breaker)
abstract interface class TaskRanker {
  List<Task> rank(PlanningRequest request);
}

/// Abstract contract for generating available free time slots from Available Time minus existing blocks.
abstract interface class TimeSlotGenerator {
  List<TimeSlot> generate(PlanningRequest request);
}

/// Abstract contract for verifying whether a task can be placed in a time slot without violation.
abstract interface class ConstraintChecker {
  bool canPlace({
    required Task task,
    required TimeSlot slot,
    required PlanningRequest request,
  });
}

/// Abstract contract for placing ranked candidate tasks into available continuous time slots.
abstract interface class Scheduler {
  List<ScheduleBlock> schedule({
    required List<Task> rankedTasks,
    required List<TimeSlot> availableSlots,
    required PlanningRequest request,
  });
}

/// Abstract contract for automatically inserting breaks (e.g. 15m after 90m focus).
abstract interface class BreakPlanner {
  List<ScheduleBlock> planBreaks({
    required List<ScheduleBlock> scheduledBlocks,
    required Duration breakDuration,
    required PlanningRequest request,
  });
}

/// Abstract contract for calculating overload and determining Keep vs Move suggestions.
abstract interface class RealityChecker {
  RealityCheck check({
    required int availableMinutes,
    required List<ScheduleBlock> plannedBlocks,
    required List<Task> requestedTasks,
  });
}

/// The facade/orchestrator of the planning pipeline.
abstract interface class PlanningEngine {
  PlanningResult plan(PlanningRequest request);
}
