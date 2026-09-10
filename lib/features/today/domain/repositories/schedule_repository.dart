import '../entities/schedule_block.dart';

abstract interface class ScheduleRepository {
  Future<List<ScheduleBlock>> getForDate(DateTime date);
  Stream<List<ScheduleBlock>> watchForDate(DateTime date);
  Future<void> replaceAutomaticBlocks(
    DateTime date,
    List<ScheduleBlock> blocks,
  );
  Future<void> saveManualBlock(ScheduleBlock block);
  Future<void> delete(String blockId);
}

abstract interface class DailyPlanRepository {
  Future<DailyPlan?> getForDate(DateTime date);
  Future<void> save(DailyPlan plan);
}

abstract interface class DailyStatsRepository {
  Future<DailyStats?> getForDate(DateTime date);
  Future<void> save(DailyStats stats);
}

abstract interface class FocusSessionRepository {
  Future<FocusSession?> getActiveOrPausedSession(String taskId);
  Future<FocusSession?> getLatestSession(String taskId);
  Future<void> save(FocusSession session);
}
