enum ScheduleBlockType { task, breakBlock }

enum ScheduleBlockSource { automatic, manual }

/// A concrete allocation of time. Break blocks never reference a task.
class ScheduleBlock {
  ScheduleBlock({
    required this.id,
    required this.date,
    required this.start,
    required this.end,
    required this.type,
    required this.source,
    this.taskId,
  }) : assert(end.isAfter(start), 'End time must be after start time'),
       assert(
         (type == ScheduleBlockType.task && taskId != null) ||
             (type == ScheduleBlockType.breakBlock && taskId == null),
         'Task blocks must reference a task; Break blocks must not.',
       );

  final String id;
  final DateTime date;
  final DateTime start;
  final DateTime end;
  final ScheduleBlockType type;
  final ScheduleBlockSource source;
  final String? taskId;

  Duration get duration => end.difference(start);

  ScheduleBlock copyWith({
    String? id,
    DateTime? date,
    DateTime? start,
    DateTime? end,
    ScheduleBlockType? type,
    ScheduleBlockSource? source,
    String? taskId,
  }) {
    return ScheduleBlock(
      id: id ?? this.id,
      date: date ?? this.date,
      start: start ?? this.start,
      end: end ?? this.end,
      type: type ?? this.type,
      source: source ?? this.source,
      taskId: taskId ?? this.taskId,
    );
  }
}

class DailyPlan {
  DailyPlan({
    required this.id,
    required this.date,
    required this.availableStart,
    required this.availableEnd,
    required this.plannedMinutes,
    required this.completedMinutes,
  }) : assert(
         availableEnd.isAfter(availableStart),
         'availableEnd must be after availableStart',
       ),
       assert(plannedMinutes >= 0, 'plannedMinutes cannot be negative'),
       assert(completedMinutes >= 0, 'completedMinutes cannot be negative');

  final String id;
  final DateTime date;
  final DateTime availableStart;
  final DateTime availableEnd;
  final int plannedMinutes;
  final int completedMinutes;

  int get availableMinutes => availableEnd.difference(availableStart).inMinutes;

  DailyPlan copyWith({
    String? id,
    DateTime? date,
    DateTime? availableStart,
    DateTime? availableEnd,
    int? plannedMinutes,
    int? completedMinutes,
  }) {
    return DailyPlan(
      id: id ?? this.id,
      date: date ?? this.date,
      availableStart: availableStart ?? this.availableStart,
      availableEnd: availableEnd ?? this.availableEnd,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      completedMinutes: completedMinutes ?? this.completedMinutes,
    );
  }
}

/// Durable aggregate daily statistics.
/// NOTE: In accordance with architectural decisions, DailyStats is independent
/// of active tasks; deleting a task does not delete historical DailyStats snapshots.
class DailyStats {
  const DailyStats({
    required this.id,
    required this.date,
    required this.tasksPlanned,
    required this.tasksCompleted,
    required this.plannedMinutes,
    required this.completedMinutes,
    required this.overloadedMinutes,
    required this.tasksRolledOver,
  });

  final String id;
  final DateTime date;
  final int tasksPlanned;
  final int tasksCompleted;
  final int plannedMinutes;
  final int completedMinutes;
  final int overloadedMinutes;
  final int tasksRolledOver;

  DailyStats copyWith({
    String? id,
    DateTime? date,
    int? tasksPlanned,
    int? tasksCompleted,
    int? plannedMinutes,
    int? completedMinutes,
    int? overloadedMinutes,
    int? tasksRolledOver,
  }) {
    return DailyStats(
      id: id ?? this.id,
      date: date ?? this.date,
      tasksPlanned: tasksPlanned ?? this.tasksPlanned,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      completedMinutes: completedMinutes ?? this.completedMinutes,
      overloadedMinutes: overloadedMinutes ?? this.overloadedMinutes,
      tasksRolledOver: tasksRolledOver ?? this.tasksRolledOver,
    );
  }
}

enum FocusSessionState { active, paused, completed, abandoned }

/// Persisted execution timing for a Task.
/// Resilient to application restarts.
class FocusSession {
  FocusSession({
    required this.id,
    required this.taskId,
    required this.state,
    required this.startedAt,
    required this.activeDuration,
    this.pausedAt,
    this.endedAt,
  }) : assert(!activeDuration.isNegative, 'activeDuration cannot be negative');

  final String id;
  final String taskId;
  final FocusSessionState state;
  final DateTime startedAt;
  final DateTime? pausedAt;
  final DateTime? endedAt;
  final Duration activeDuration;

  FocusSession copyWith({
    String? id,
    String? taskId,
    FocusSessionState? state,
    DateTime? startedAt,
    Duration? activeDuration,
    DateTime? pausedAt,
    DateTime? endedAt,
  }) {
    return FocusSession(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      state: state ?? this.state,
      startedAt: startedAt ?? this.startedAt,
      activeDuration: activeDuration ?? this.activeDuration,
      pausedAt: pausedAt ?? this.pausedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }
}
