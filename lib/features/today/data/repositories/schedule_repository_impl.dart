import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/schedule_block.dart';
import '../../domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  const ScheduleRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Future<List<ScheduleBlock>> getForDate(DateTime date) async {
    try {
      final dateStr = DateTimeUtils.formatDate(date);
      final query = _db.select(_db.scheduleBlocksTable)
        ..where((t) => t.planDate.equals(dateStr))
        ..orderBy([(t) => OrderingTerm.asc(t.startMinute)]);
      final rows = await query.get();
      return rows.map((r) => _toDomain(r, date)).toList();
    } catch (e) {
      throw DatabaseFailure('Failed to get schedule blocks for date: $date', e);
    }
  }

  @override
  Stream<List<ScheduleBlock>> watchForDate(DateTime date) {
    final dateStr = DateTimeUtils.formatDate(date);
    final query = _db.select(_db.scheduleBlocksTable)
      ..where((t) => t.planDate.equals(dateStr))
      ..orderBy([(t) => OrderingTerm.asc(t.startMinute)]);
    return query.watch().map(
      (rows) => rows.map((r) => _toDomain(r, date)).toList(),
    );
  }

  @override
  Future<void> replaceAutomaticBlocks(
    DateTime date,
    List<ScheduleBlock> blocks,
  ) async {
    try {
      final dateStr = DateTimeUtils.formatDate(date);

      await _db.transaction(() async {
        // Critical Architectural Rule:
        // Automatically generated blocks are replaced.
        // Manually scheduled blocks are strictly preserved.
        await (_db.delete(_db.scheduleBlocksTable)..where(
              (t) =>
                  t.planDate.equals(dateStr) &
                  t.source.equals(ScheduleBlockSource.automatic.name),
            ))
            .go();

        // Insert new automatic blocks
        final companions = blocks.map((b) {
          final nowUtc = DateTime.now().toUtc().toIso8601String();
          return ScheduleBlocksTableCompanion(
            id: Value(b.id),
            planDate: Value(dateStr),
            startMinute: Value(DateTimeUtils.timeToMinutes(b.start)),
            endMinute: Value(DateTimeUtils.timeToMinutes(b.end)),
            blockType: Value(
              b.type == ScheduleBlockType.task ? 'task' : 'break',
            ),
            source: Value(ScheduleBlockSource.automatic.name),
            taskId: Value(b.taskId),
            createdAt: Value(nowUtc),
            updatedAt: Value(nowUtc),
          );
        }).toList();

        await _db.batch((b) {
          b.insertAllOnConflictUpdate(_db.scheduleBlocksTable, companions);
        });
      });
    } catch (e) {
      throw DatabaseFailure(
        'Failed to replace automatic schedule blocks for date: $date',
        e,
      );
    }
  }

  @override
  Future<void> saveManualBlock(ScheduleBlock block) async {
    try {
      final dateStr = DateTimeUtils.formatDate(block.date);
      final nowUtc = DateTime.now().toUtc().toIso8601String();
      final companion = ScheduleBlocksTableCompanion(
        id: Value(block.id),
        planDate: Value(dateStr),
        startMinute: Value(DateTimeUtils.timeToMinutes(block.start)),
        endMinute: Value(DateTimeUtils.timeToMinutes(block.end)),
        blockType: Value(
          block.type == ScheduleBlockType.task ? 'task' : 'break',
        ),
        source: Value(ScheduleBlockSource.manual.name),
        taskId: Value(block.taskId),
        createdAt: Value(nowUtc),
        updatedAt: Value(nowUtc),
      );

      await _db.into(_db.scheduleBlocksTable).insertOnConflictUpdate(companion);
    } catch (e) {
      throw DatabaseFailure(
        'Failed to save manual schedule block ${block.id}',
        e,
      );
    }
  }

  @override
  Future<void> delete(String blockId) async {
    try {
      await (_db.delete(
        _db.scheduleBlocksTable,
      )..where((t) => t.id.equals(blockId))).go();
    } catch (e) {
      throw DatabaseFailure('Failed to delete schedule block $blockId', e);
    }
  }

  static ScheduleBlock _toDomain(ScheduleBlockRow row, DateTime fallbackDate) {
    final blockDate = DateTimeUtils.parseDate(row.planDate);
    final start = DateTimeUtils.minutesToDateTime(blockDate, row.startMinute);
    final end = DateTimeUtils.minutesToDateTime(blockDate, row.endMinute);

    return ScheduleBlock(
      id: row.id,
      date: blockDate,
      start: start,
      end: end,
      type: row.blockType == 'task'
          ? ScheduleBlockType.task
          : ScheduleBlockType.breakBlock,
      source: row.source == 'manual'
          ? ScheduleBlockSource.manual
          : ScheduleBlockSource.automatic,
      taskId: row.taskId,
    );
  }
}
