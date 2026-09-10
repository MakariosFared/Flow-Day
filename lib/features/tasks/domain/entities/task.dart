enum TaskStatus { pending, scheduled, inProgress, completed, cancelled }

enum TaskPriority {
  low(1),
  medium(2),
  high(3);

  const TaskPriority(this.rank);
  final int rank;
}

enum EnergyLevel { low, medium, high }

enum PreferredTimeWindow { anytime, morning, afternoon, evening }

/// A user intention: what needs to be accomplished, independent of its schedule.
class Task {
  Task({
    required this.id,
    required this.title,
    required this.estimatedDuration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.categoryId,
    this.priority = TaskPriority.medium,
    this.actualDuration = Duration.zero,
    this.dueDate,
    this.preferredTimeWindow = PreferredTimeWindow.anytime,
    this.energyLevel,
    this.recurrenceTemplateId,
    this.completedAt,
  }) : assert(title.trim().isNotEmpty, 'Task title cannot be empty'),
       assert(
         !estimatedDuration.isNegative && estimatedDuration > Duration.zero,
         'estimatedDuration must be positive',
       ),
       assert(!actualDuration.isNegative, 'actualDuration cannot be negative');

  final String id;
  final String title;
  final String? description;
  final String? categoryId;
  final TaskPriority priority;
  final Duration estimatedDuration;
  final Duration actualDuration;
  final TaskStatus status;
  final DateTime? dueDate;
  final PreferredTimeWindow preferredTimeWindow;
  final EnergyLevel? energyLevel;
  final String? recurrenceTemplateId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;

  /// Validates whether a lifecycle state transition is allowed per product spec.
  bool canTransitionTo(TaskStatus newStatus) {
    if (status == newStatus) return true;
    return switch (status) {
      TaskStatus.pending =>
        newStatus == TaskStatus.scheduled || newStatus == TaskStatus.cancelled,
      TaskStatus.scheduled =>
        newStatus == TaskStatus.pending ||
            newStatus == TaskStatus.inProgress ||
            newStatus == TaskStatus.cancelled,
      TaskStatus.inProgress => newStatus == TaskStatus.completed,
      TaskStatus.completed => false,
      TaskStatus.cancelled => false,
    };
  }

  /// UI-only temporal state; deliberately not stored as [TaskStatus].
  bool isOverdue({required DateTime now, DateTime? scheduledEnd}) =>
      status == TaskStatus.inProgress &&
      scheduledEnd != null &&
      now.isAfter(scheduledEnd);

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? categoryId,
    TaskPriority? priority,
    Duration? estimatedDuration,
    Duration? actualDuration,
    TaskStatus? status,
    DateTime? dueDate,
    PreferredTimeWindow? preferredTimeWindow,
    EnergyLevel? energyLevel,
    String? recurrenceTemplateId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      priority: priority ?? this.priority,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      actualDuration: actualDuration ?? this.actualDuration,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      preferredTimeWindow: preferredTimeWindow ?? this.preferredTimeWindow,
      energyLevel: energyLevel ?? this.energyLevel,
      recurrenceTemplateId: recurrenceTemplateId ?? this.recurrenceTemplateId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

class Category {
  const Category({required this.id, required this.name, required this.icon});
  final String id;
  final String name;
  final String icon;

  static const List<Category> phase1Defaults = [
    Category(id: 'cat-work', name: 'Work', icon: '💻'),
    Category(id: 'cat-learning', name: 'Learning', icon: '📚'),
    Category(id: 'cat-health', name: 'Health', icon: '🏋️'),
    Category(id: 'cat-personal', name: 'Personal', icon: '🏠'),
    Category(id: 'cat-people', name: 'People', icon: '👥'),
    Category(id: 'cat-reading', name: 'Reading', icon: '📖'),
  ];
}

enum RecurrenceType { daily, weekly }

class RecurrenceTemplate {
  RecurrenceTemplate({
    required this.id,
    required this.title,
    required this.estimatedDuration,
    required this.recurrenceType,
    required this.startDate,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.categoryId,
    this.priority = TaskPriority.medium,
    this.preferredTimeWindow = PreferredTimeWindow.anytime,
    this.energyLevel,
    this.recurrenceDays = const <int>{},
    this.endDate,
  }) : assert(
         recurrenceType == RecurrenceType.daily || recurrenceDays.isNotEmpty,
         'Weekly recurrence must specify recurrenceDays',
       );

  final String id;
  final String title;
  final String? description;
  final String? categoryId;
  final TaskPriority priority;
  final Duration estimatedDuration;
  final PreferredTimeWindow preferredTimeWindow;
  final EnergyLevel? energyLevel;
  final RecurrenceType recurrenceType;
  final Set<int> recurrenceDays;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  RecurrenceTemplate copyWith({
    String? id,
    String? title,
    String? description,
    String? categoryId,
    TaskPriority? priority,
    Duration? estimatedDuration,
    PreferredTimeWindow? preferredTimeWindow,
    EnergyLevel? energyLevel,
    RecurrenceType? recurrenceType,
    Set<int>? recurrenceDays,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RecurrenceTemplate(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      priority: priority ?? this.priority,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      preferredTimeWindow: preferredTimeWindow ?? this.preferredTimeWindow,
      energyLevel: energyLevel ?? this.energyLevel,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      recurrenceDays: recurrenceDays ?? this.recurrenceDays,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
