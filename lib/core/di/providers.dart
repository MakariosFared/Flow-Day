import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/tasks/data/repositories/category_repository_impl.dart';
import '../../features/tasks/data/repositories/recurrence_repository_impl.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';
import '../../features/tasks/domain/usecases/task_usecases.dart';
import '../../features/today/data/repositories/daily_plan_repository_impl.dart';
import '../../features/today/data/repositories/daily_stats_repository_impl.dart';
import '../../features/today/data/repositories/focus_session_repository_impl.dart';
import '../../features/today/data/repositories/schedule_repository_impl.dart';
import '../../features/today/domain/repositories/schedule_repository.dart';
import '../../features/today/domain/usecases/focus_usecases.dart';
import '../../features/today/domain/usecases/generate_daily_plan.dart';
import '../../features/today/domain/usecases/schedule_usecases.dart';
import '../clock/clock.dart';
import '../database/app_database.dart';
import '../planning/planning_contracts.dart';

// ==========================================
// Core Infrastructure Providers
// ==========================================

final clockProvider = Provider<Clock>((ref) => const SystemClock());

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() {
    db.close();
  });
  return db;
});

// ==========================================
// Repository Providers
// ==========================================

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TaskRepositoryImpl(db);
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return CategoryRepositoryImpl(db);
});

final recurrenceRepositoryProvider = Provider<RecurrenceRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return RecurrenceRepositoryImpl(db);
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ScheduleRepositoryImpl(db);
});

final dailyPlanRepositoryProvider = Provider<DailyPlanRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DailyPlanRepositoryImpl(db);
});

final dailyStatsRepositoryProvider = Provider<DailyStatsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DailyStatsRepositoryImpl(db);
});

final focusSessionRepositoryProvider = Provider<FocusSessionRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return FocusSessionRepositoryImpl(db);
});

// ==========================================
// Planning Engine Provider (Placeholder for Sprint 5)
// ==========================================

final planningEngineProvider = Provider<PlanningEngine>((ref) {
  throw UnimplementedError(
    'PlanningEngine implementation will be provided in Sprint 5',
  );
});

// ==========================================
// Tasks Use Case Providers
// ==========================================

final createTaskProvider = Provider<CreateTask>((ref) {
  return CreateTask(
    ref.watch(taskRepositoryProvider),
    ref.watch(clockProvider),
  );
});

final updateTaskProvider = Provider<UpdateTask>((ref) {
  return UpdateTask(
    ref.watch(taskRepositoryProvider),
    ref.watch(clockProvider),
  );
});

final deleteTaskProvider = Provider<DeleteTask>((ref) {
  return DeleteTask(ref.watch(taskRepositoryProvider));
});

final completeTaskProvider = Provider<CompleteTask>((ref) {
  return CompleteTask(
    ref.watch(taskRepositoryProvider),
    ref.watch(clockProvider),
  );
});

final getTasksProvider = Provider<GetTasks>((ref) {
  return GetTasks(ref.watch(taskRepositoryProvider));
});

final getTaskByIdProvider = Provider<GetTaskById>((ref) {
  return GetTaskById(ref.watch(taskRepositoryProvider));
});

// ==========================================
// Today & Focus Use Case Providers
// ==========================================

final startFocusProvider = Provider<StartFocus>((ref) {
  return StartFocus(
    ref.watch(taskRepositoryProvider),
    ref.watch(focusSessionRepositoryProvider),
    ref.watch(clockProvider),
  );
});

final pauseFocusProvider = Provider<PauseFocus>((ref) {
  return PauseFocus(
    ref.watch(taskRepositoryProvider),
    ref.watch(focusSessionRepositoryProvider),
    ref.watch(clockProvider),
  );
});

final resumeFocusProvider = Provider<ResumeFocus>((ref) {
  return ResumeFocus(
    ref.watch(focusSessionRepositoryProvider),
    ref.watch(clockProvider),
  );
});

final completeFocusProvider = Provider<CompleteFocus>((ref) {
  return CompleteFocus(
    ref.watch(taskRepositoryProvider),
    ref.watch(focusSessionRepositoryProvider),
    ref.watch(clockProvider),
  );
});

final rescheduleTaskProvider = Provider<RescheduleTask>((ref) {
  return RescheduleTask(
    ref.watch(taskRepositoryProvider),
    ref.watch(scheduleRepositoryProvider),
    ref.watch(clockProvider),
  );
});

final getTodayPlanProvider = Provider<GetTodayPlan>((ref) {
  return GetTodayPlan(
    ref.watch(taskRepositoryProvider),
    ref.watch(scheduleRepositoryProvider),
    ref.watch(dailyPlanRepositoryProvider),
    ref.watch(clockProvider),
  );
});

final generateDailyPlanProvider = Provider<GenerateDailyPlan>((ref) {
  return GenerateDailyPlan(
    ref.watch(planningEngineProvider),
    ref.watch(scheduleRepositoryProvider),
  );
});
