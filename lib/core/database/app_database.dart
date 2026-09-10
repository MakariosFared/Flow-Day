import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'connection/connection.dart'
    if (dart.library.html) 'connection/connection_web.dart';
import 'tables/categories_table.dart';
import 'tables/daily_plans_table.dart';
import 'tables/daily_stats_table.dart';
import 'tables/focus_sessions_table.dart';
import 'tables/recurrence_templates_table.dart';
import 'tables/schedule_blocks_table.dart';
import 'tables/tasks_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CategoriesTable,
    RecurrenceTemplatesTable,
    TasksTable,
    DailyPlansTable,
    ScheduleBlocksTable,
    DailyStatsTable,
    FocusSessionsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? openConnection());

  factory AppDatabase.inMemory() {
    return AppDatabase(NativeDatabase.memory());
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await _seedDefaultCategories();
    },
    beforeOpen: (OpeningDetails details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      // Ensure deterministic, idempotent seeding on open
      await _seedDefaultCategories();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Future schema migration logic will be added here incrementally.
    },
  );

  /// Phase 1 fixed default categories seeded idempotently
  Future<void> _seedDefaultCategories() async {
    final defaultCategories = [
      CategoriesTableCompanion.insert(id: 'cat-work', name: 'Work', icon: '💻'),
      CategoriesTableCompanion.insert(
        id: 'cat-learning',
        name: 'Learning',
        icon: '📚',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat-health',
        name: 'Health',
        icon: '🏋️',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat-personal',
        name: 'Personal',
        icon: '🏠',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat-people',
        name: 'People',
        icon: '👥',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat-reading',
        name: 'Reading',
        icon: '📖',
      ),
    ];

    await batch((b) {
      b.insertAllOnConflictUpdate(categoriesTable, defaultCategories);
    });
  }
}
