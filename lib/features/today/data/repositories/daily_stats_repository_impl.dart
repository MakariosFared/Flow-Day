import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/schedule_block.dart';
import '../../domain/repositories/schedule_repository.dart';

class DailyStatsRepositoryImpl implements DailyStatsRepository {
  const DailyStatsRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Future<DailyStats?> getForDate(DateTime date) async {
    try {
      final dateStr = DateTimeUtils.formatDate(date);
      final query = _db.select(_db.dailyStatsTable)
        ..where((t) => t.statsDate.equals(dateStr));
      final row = await query.getSingleOrNull();
      return row != null ? _toDomain(row) : null;
    } catch (e) {
      throw DatabaseFailure('Failed to get daily stats for date: $date', e);
    }
  }

  @override
  Future<void> save(DailyStats stats) async {
    try {
      final dateStr = DateTimeUtils.formatDate(stats.date);
      final nowUtc = DateTime.now().toUtc().toIso8601String();
      final companion = DailyStatsTableCompanion(
        id: Value(stats.id),
        statsDate: Value(dateStr),
        tasksPlanned: Value(stats.tasksPlanned),
        tasksCompleted: Value(stats.tasksCompleted),
        plannedMinutes: Value(stats.plannedMinutes),
        completedMinutes: Value(stats.completedMinutes),
        overloadedMinutes: Value(stats.overloadedMinutes),
        tasksRolledOver: Value(stats.tasksRolledOver),
        createdAt: Value(nowUtc),
        updatedAt: Value(nowUtc),
      );

      await _db.into(_db.dailyStatsTable).insertOnConflictUpdate(companion);
    } catch (e) {
      throw DatabaseFailure('Failed to save daily stats ${stats.id}', e);
    }
  }

  static DailyStats _toDomain(DailyStatsRow row) {
    return DailyStats(
      id: row.id,
      date: DateTimeUtils.parseDate(row.statsDate),
      tasksPlanned: row.tasksPlanned,
      tasksCompleted: row.tasksCompleted,
      plannedMinutes: row.plannedMinutes,
      completedMinutes: row.completedMinutes,
      overloadedMinutes: row.overloadedMinutes,
      tasksRolledOver: row.tasksRolledOver,
    );
  }
}
