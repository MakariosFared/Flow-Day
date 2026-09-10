import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/schedule_block.dart';
import '../../domain/repositories/schedule_repository.dart';

class DailyPlanRepositoryImpl implements DailyPlanRepository {
  const DailyPlanRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Future<DailyPlan?> getForDate(DateTime date) async {
    try {
      final dateStr = DateTimeUtils.formatDate(date);
      final query = _db.select(_db.dailyPlansTable)
        ..where((t) => t.planDate.equals(dateStr));
      final row = await query.getSingleOrNull();
      return row != null ? _toDomain(row) : null;
    } catch (e) {
      throw DatabaseFailure('Failed to get daily plan for date: $date', e);
    }
  }

  @override
  Future<void> save(DailyPlan plan) async {
    try {
      final dateStr = DateTimeUtils.formatDate(plan.date);
      final companion = DailyPlansTableCompanion(
        id: Value(plan.id),
        planDate: Value(dateStr),
        availableStartMinute: Value(
          DateTimeUtils.timeToMinutes(plan.availableStart),
        ),
        availableEndMinute: Value(
          DateTimeUtils.timeToMinutes(plan.availableEnd),
        ),
        plannedMinutes: Value(plan.plannedMinutes),
        completedMinutes: Value(plan.completedMinutes),
      );

      await _db.into(_db.dailyPlansTable).insertOnConflictUpdate(companion);
    } catch (e) {
      throw DatabaseFailure('Failed to save daily plan ${plan.id}', e);
    }
  }

  static DailyPlan _toDomain(DailyPlanRow row) {
    final date = DateTimeUtils.parseDate(row.planDate);
    return DailyPlan(
      id: row.id,
      date: date,
      availableStart: DateTimeUtils.minutesToDateTime(
        date,
        row.availableStartMinute,
      ),
      availableEnd: DateTimeUtils.minutesToDateTime(
        date,
        row.availableEndMinute,
      ),
      plannedMinutes: row.plannedMinutes,
      completedMinutes: row.completedMinutes,
    );
  }
}
