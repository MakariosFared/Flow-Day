import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/schedule_block.dart';
import '../../domain/repositories/schedule_repository.dart';

class FocusSessionRepositoryImpl implements FocusSessionRepository {
  const FocusSessionRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Future<FocusSession?> getActiveOrPausedSession(String taskId) async {
    try {
      final query = _db.select(_db.focusSessionsTable)
        ..where(
          (t) =>
              t.taskId.equals(taskId) &
              (t.state.equals(FocusSessionState.active.name) |
                  t.state.equals(FocusSessionState.paused.name)),
        )
        ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]);
      final row = await query.getSingleOrNull();
      return row != null ? _toDomain(row) : null;
    } catch (e) {
      throw DatabaseFailure(
        'Failed to get active/paused focus session for task: $taskId',
        e,
      );
    }
  }

  @override
  Future<FocusSession?> getLatestSession(String taskId) async {
    try {
      final query = _db.select(_db.focusSessionsTable)
        ..where((t) => t.taskId.equals(taskId))
        ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
        ..limit(1);
      final row = await query.getSingleOrNull();
      return row != null ? _toDomain(row) : null;
    } catch (e) {
      throw DatabaseFailure(
        'Failed to get latest focus session for task: $taskId',
        e,
      );
    }
  }

  @override
  Future<void> save(FocusSession session) async {
    try {
      final nowUtc = DateTime.now().toUtc().toIso8601String();
      final companion = FocusSessionsTableCompanion(
        id: Value(session.id),
        taskId: Value(session.taskId),
        state: Value(session.state.name),
        startedAt: Value(session.startedAt.toUtc().toIso8601String()),
        pausedAt: Value(session.pausedAt?.toUtc().toIso8601String()),
        endedAt: Value(session.endedAt?.toUtc().toIso8601String()),
        activeDurationSeconds: Value(session.activeDuration.inSeconds),
        createdAt: Value(session.startedAt.toUtc().toIso8601String()),
        updatedAt: Value(nowUtc),
      );

      await _db.into(_db.focusSessionsTable).insertOnConflictUpdate(companion);
    } catch (e) {
      throw DatabaseFailure('Failed to save focus session ${session.id}', e);
    }
  }

  static FocusSession _toDomain(FocusSessionRow row) {
    return FocusSession(
      id: row.id,
      taskId: row.taskId,
      state: FocusSessionState.values.firstWhere(
        (s) => s.name == row.state,
        orElse: () => FocusSessionState.abandoned,
      ),
      startedAt: DateTime.parse(row.startedAt).toLocal(),
      activeDuration: Duration(seconds: row.activeDurationSeconds),
      pausedAt: row.pausedAt != null
          ? DateTime.parse(row.pausedAt!).toLocal()
          : null,
      endedAt: row.endedAt != null
          ? DateTime.parse(row.endedAt!).toLocal()
          : null,
    );
  }
}
