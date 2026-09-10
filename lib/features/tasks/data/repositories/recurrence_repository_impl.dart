import 'dart:convert';
import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class RecurrenceRepositoryImpl implements RecurrenceRepository {
  const RecurrenceRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Future<RecurrenceTemplate?> getById(String id) async {
    try {
      final query = _db.select(_db.recurrenceTemplatesTable)
        ..where((t) => t.id.equals(id));
      final row = await query.getSingleOrNull();
      return row != null ? _toDomain(row) : null;
    } catch (e) {
      throw DatabaseFailure('Failed to get recurrence template by id: $id', e);
    }
  }

  @override
  Future<void> saveTemplate(RecurrenceTemplate template) async {
    try {
      final companion = RecurrenceTemplatesTableCompanion(
        id: Value(template.id),
        title: Value(template.title),
        description: Value(template.description),
        categoryId: Value(template.categoryId),
        priority: Value(template.priority.rank),
        estimatedDurationMinutes: Value(template.estimatedDuration.inMinutes),
        preferredTimeWindow: Value(template.preferredTimeWindow.name),
        energyLevel: Value(template.energyLevel?.name),
        recurrenceType: Value(template.recurrenceType.name),
        recurrenceDays: Value(jsonEncode(template.recurrenceDays.toList())),
        startDate: Value(DateTimeUtils.formatDate(template.startDate)),
        endDate: Value(
          template.endDate != null
              ? DateTimeUtils.formatDate(template.endDate!)
              : null,
        ),
        createdAt: Value(template.createdAt.toUtc().toIso8601String()),
        updatedAt: Value(template.updatedAt.toUtc().toIso8601String()),
      );

      await _db
          .into(_db.recurrenceTemplatesTable)
          .insertOnConflictUpdate(companion);
    } catch (e) {
      throw DatabaseFailure(
        'Failed to save recurrence template ${template.id}',
        e,
      );
    }
  }

  static RecurrenceTemplate _toDomain(RecurrenceTemplateRow row) {
    final List<dynamic> daysList = jsonDecode(row.recurrenceDays);
    return RecurrenceTemplate(
      id: row.id,
      title: row.title,
      description: row.description,
      categoryId: row.categoryId,
      priority: switch (row.priority) {
        1 => TaskPriority.low,
        3 => TaskPriority.high,
        _ => TaskPriority.medium,
      },
      estimatedDuration: Duration(minutes: row.estimatedDurationMinutes),
      preferredTimeWindow: PreferredTimeWindow.values.firstWhere(
        (w) => w.name == row.preferredTimeWindow,
        orElse: () => PreferredTimeWindow.anytime,
      ),
      energyLevel: row.energyLevel != null
          ? EnergyLevel.values.firstWhere((e) => e.name == row.energyLevel)
          : null,
      recurrenceType: RecurrenceType.values.firstWhere(
        (t) => t.name == row.recurrenceType,
      ),
      recurrenceDays: daysList.cast<int>().toSet(),
      startDate: DateTimeUtils.parseDate(row.startDate),
      endDate: row.endDate != null
          ? DateTimeUtils.parseDate(row.endDate!)
          : null,
      createdAt: DateTime.parse(row.createdAt).toLocal(),
      updatedAt: DateTime.parse(row.updatedAt).toLocal(),
    );
  }
}
