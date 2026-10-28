enum ScheduleBlockType { task, breakBlock }

class ScheduleBlock {
  const ScheduleBlock({
    required this.id,
    required this.date,
    required this.start,
    required this.end,
    required this.type,
    this.taskId,
    this.customTitle,
    this.isCompleted = false,
  });

  final String id;
  final DateTime date;
  final DateTime start;
  final DateTime end;
  final ScheduleBlockType type;
  final String? taskId;
  final String? customTitle;
  final bool isCompleted;

  Duration get duration => end.difference(start);

  ScheduleBlock copyWith({
    String? id,
    DateTime? date,
    DateTime? start,
    DateTime? end,
    ScheduleBlockType? type,
    String? taskId,
    String? customTitle,
    bool? isCompleted,
  }) {
    return ScheduleBlock(
      id: id ?? this.id,
      date: date ?? this.date,
      start: start ?? this.start,
      end: end ?? this.end,
      type: type ?? this.type,
      taskId: taskId ?? this.taskId,
      customTitle: customTitle ?? this.customTitle,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
