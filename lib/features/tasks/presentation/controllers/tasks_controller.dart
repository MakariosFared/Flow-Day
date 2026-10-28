import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/task.dart';

enum TaskFilter {
  all('الكل'),
  active('النشطة'),
  inbox('صندوق الوارد'),
  upcoming('المجدولة'),
  completed('المكتملة');

  const TaskFilter(this.labelAr);
  final String labelAr;
}

final taskFilterProvider = StateProvider<TaskFilter>((ref) => TaskFilter.all);
final taskSearchQueryProvider = StateProvider<String>((ref) => '');

final categoriesProvider = Provider<List<Category>>((ref) {
  return Category.defaultCategories;
});

final categoriesStreamProvider = Provider<AsyncValue<List<Category>>>((ref) {
  return AsyncValue.data(ref.watch(categoriesProvider));
});

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super(_initialMockTasks);

  static final List<Task> _initialMockTasks = [
    Task(
      id: 'task-1',
      title: 'مراجعة وتحديث Design Tokens والواجهات',
      description: 'توحيد تدرجات Sage والألوان التكيفية للوضع الداكن والفاتح مع التباين العالي.',
      categoryId: 'cat-work',
      priority: TaskPriority.high,
      estimatedDuration: const Duration(minutes: 45),
      actualDuration: const Duration(minutes: 45),
      status: TaskStatus.completed,
      preferredTimeWindow: PreferredTimeWindow.morning,
      energyLevel: EnergyLevel.high,
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      completedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Task(
      id: 'task-2',
      title: 'إعادة هيكلة كود التنقل والصفحات التفاعلية',
      description: 'تحسين تجربة الانتقال بين الشاشات وإصلاح مشاكل التوافق والمحاذاة RTL.',
      categoryId: 'cat-work',
      priority: TaskPriority.high,
      estimatedDuration: const Duration(minutes: 45),
      actualDuration: const Duration(minutes: 25),
      status: TaskStatus.inProgress,
      preferredTimeWindow: PreferredTimeWindow.morning,
      energyLevel: EnergyLevel.high,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Task(
      id: 'task-3',
      title: 'قراءة فصل في أنماط تصميم Flutter الحديثة',
      description: 'مراجعة أفضل الممارسات في بناء واجهات المستخدم بدون تعقيدات زائدة.',
      categoryId: 'cat-learning',
      priority: TaskPriority.medium,
      estimatedDuration: const Duration(minutes: 30),
      actualDuration: Duration.zero,
      status: TaskStatus.pending,
      preferredTimeWindow: PreferredTimeWindow.afternoon,
      energyLevel: EnergyLevel.medium,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Task(
      id: 'task-4',
      title: 'جلسة تفريغ ذهني وتنظيم خطة الأسبوع الهادئة',
      description: 'ترتيب الأولويات الشخصية والمهنية بمرونة ودون أي ضغط نفسي.',
      categoryId: 'cat-personal',
      priority: TaskPriority.medium,
      estimatedDuration: const Duration(minutes: 30),
      actualDuration: Duration.zero,
      status: TaskStatus.pending,
      preferredTimeWindow: PreferredTimeWindow.afternoon,
      energyLevel: EnergyLevel.low,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Task(
      id: 'task-5',
      title: 'تمرين رياضي ومشي خفيف لاستعادة النشاط',
      description: 'مشي لمدة 30 دقيقة في الهواء الطلق مع تمارين إطالة هادئة.',
      categoryId: 'cat-health',
      priority: TaskPriority.low,
      estimatedDuration: const Duration(minutes: 30),
      actualDuration: const Duration(minutes: 30),
      status: TaskStatus.completed,
      preferredTimeWindow: PreferredTimeWindow.afternoon,
      energyLevel: EnergyLevel.medium,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      completedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Task(
      id: 'task-6',
      title: 'إعداد مقترح ورشة عمل تجربة المستخدم الهادئة',
      description: 'كتابة النقاط الرئيسية لتصميم تطبيقات تركز على هدوء وإنتاجية المستخدم.',
      categoryId: 'cat-work',
      priority: TaskPriority.high,
      estimatedDuration: const Duration(minutes: 60),
      actualDuration: Duration.zero,
      status: TaskStatus.scheduled,
      preferredTimeWindow: PreferredTimeWindow.evening,
      energyLevel: EnergyLevel.high,
      createdAt: DateTime.now().subtract(const Duration(minutes: 40)),
    ),
  ];

  void toggleTaskComplete(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          task.copyWith(
            status: task.status == TaskStatus.completed
                ? TaskStatus.pending
                : TaskStatus.completed,
            completedAt: task.status == TaskStatus.completed
                ? null
                : DateTime.now(),
          )
        else
          task,
    ];
  }

  void completeTask(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          task.copyWith(
            status: TaskStatus.completed,
            completedAt: DateTime.now(),
          )
        else
          task,
    ];
  }

  void startFocus(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          task.copyWith(status: TaskStatus.inProgress)
        else
          task,
    ];
  }

  void addLoggedFocusTime(String id, Duration duration) {
    state = [
      for (final task in state)
        if (task.id == id)
          task.copyWith(
            actualDuration: task.actualDuration + duration,
            status: TaskStatus.completed,
            completedAt: DateTime.now(),
          )
        else
          task,
    ];
  }

  void createTask({
    required String title,
    required Duration estimatedDuration,
    String? description,
    String? categoryId,
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueDate,
    PreferredTimeWindow preferredTimeWindow = PreferredTimeWindow.anytime,
    EnergyLevel? energyLevel,
  }) {
    final newTask = Task(
      id: const Uuid().v4(),
      title: title,
      estimatedDuration: estimatedDuration,
      description: description,
      categoryId: categoryId,
      priority: priority,
      dueDate: dueDate,
      preferredTimeWindow: preferredTimeWindow,
      energyLevel: energyLevel,
      status: TaskStatus.pending,
      createdAt: DateTime.now(),
    );
    state = [newTask, ...state];
  }

  void updateTask(Task updated) {
    state = [
      for (final task in state)
        if (task.id == updated.id) updated else task,
    ];
  }

  void deleteTask(String id) {
    state = state.where((t) => t.id != id).toList();
  }
}

final tasksNotifierProvider =
    StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});

// Backward compatibility stream provider
final tasksStreamProvider = Provider<AsyncValue<List<Task>>>((ref) {
  final tasks = ref.watch(tasksNotifierProvider);
  return AsyncValue.data(tasks);
});

final taskByIdProvider = Provider.family<AsyncValue<Task?>, String>((ref, id) {
  final tasks = ref.watch(tasksNotifierProvider);
  final task = tasks.where((t) => t.id == id).firstOrNull;
  return AsyncValue.data(task);
});

final filteredTasksProvider = Provider<AsyncValue<List<Task>>>((ref) {
  final allTasks = ref.watch(tasksNotifierProvider);
  final filter = ref.watch(taskFilterProvider);
  final query = ref.watch(taskSearchQueryProvider).trim().toLowerCase();

  var filtered = switch (filter) {
    TaskFilter.all => allTasks.where((t) => t.status != TaskStatus.cancelled).toList(),
    TaskFilter.active => allTasks.where((t) =>
        t.status == TaskStatus.pending ||
        t.status == TaskStatus.scheduled ||
        t.status == TaskStatus.inProgress).toList(),
    TaskFilter.inbox => allTasks.where((t) => t.status == TaskStatus.pending).toList(),
    TaskFilter.upcoming => allTasks.where((t) =>
        t.status == TaskStatus.scheduled ||
        t.status == TaskStatus.inProgress).toList(),
    TaskFilter.completed => allTasks.where((t) => t.status == TaskStatus.completed).toList(),
  };

  if (query.isNotEmpty) {
    filtered = filtered.where((t) {
      final titleMatch = t.title.toLowerCase().contains(query);
      final descMatch = t.description?.toLowerCase().contains(query) ?? false;
      return titleMatch || descMatch;
    }).toList();
  }

  filtered.sort((a, b) {
    if (a.status == TaskStatus.completed && b.status != TaskStatus.completed) return 1;
    if (a.status != TaskStatus.completed && b.status == TaskStatus.completed) return -1;
    final priorityComparison = b.priority.rank.compareTo(a.priority.rank);
    if (priorityComparison != 0) return priorityComparison;
    return b.createdAt.compareTo(a.createdAt);
  });

  return AsyncValue.data(filtered);
});

// UI controller interface
class TasksController {
  const TasksController(this._ref);
  final Ref _ref;

  Future<void> createTask({
    required String title,
    required Duration estimatedDuration,
    String? description,
    String? categoryId,
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueDate,
    PreferredTimeWindow preferredTimeWindow = PreferredTimeWindow.anytime,
    EnergyLevel? energyLevel,
  }) async {
    _ref.read(tasksNotifierProvider.notifier).createTask(
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

  Future<void> updateTask(Task task) async {
    _ref.read(tasksNotifierProvider.notifier).updateTask(task);
  }

  Future<void> completeTask(String id) async {
    _ref.read(tasksNotifierProvider.notifier).completeTask(id);
  }

  Future<void> toggleComplete(String id) async {
    _ref.read(tasksNotifierProvider.notifier).toggleTaskComplete(id);
  }

  Future<void> deleteTask(String id) async {
    _ref.read(tasksNotifierProvider.notifier).deleteTask(id);
  }

  Future<void> startFocus(String id) async {
    _ref.read(tasksNotifierProvider.notifier).startFocus(id);
  }

  Future<void> finishFocus(String id, Duration loggedDuration) async {
    _ref.read(tasksNotifierProvider.notifier).addLoggedFocusTime(id, loggedDuration);
  }
}

final tasksControllerProvider = Provider<TasksController>((ref) {
  return TasksController(ref);
});
