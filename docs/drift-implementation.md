# Drift implementation

`AppDatabase` is implemented in `lib/core/database/app_database.dart` with Drift-generated code in `app_database.g.dart`. Domain entities never import Drift rows or Companion types; repositories act as the anti-corruption layer.

## Schema structure

Individual table definitions reside in `lib/core/database/tables/`:
- `categories_table.dart` (`CategoriesTable`)
- `recurrence_templates_table.dart` (`RecurrenceTemplatesTable`)
- `tasks_table.dart` (`TasksTable`)
- `daily_plans_table.dart` (`DailyPlansTable`)
- `schedule_blocks_table.dart` (`ScheduleBlocksTable`)
- `daily_stats_table.dart` (`DailyStatsTable`)
- `focus_sessions_table.dart` (`FocusSessionsTable`)

Connection logic is organized in `lib/core/database/connection/connection.dart` with `NativeDatabase` for mobile/desktop platforms and `NativeDatabase.memory()` via `AppDatabase.inMemory()` for unit/integration tests.

## Idempotent Category Seeding

During `onCreate` and `beforeOpen`, `_seedDefaultCategories()` inserts or updates the 6 default Phase 1 categories (`Work`, `Learning`, `Health`, `Personal`, `People`, `Reading`) using batch `insertAllOnConflictUpdate`, preventing duplicate entries.

## Migration Policy

- Version 1 is established.
- Future versions increment `schemaVersion` and add explicit migrations in `onUpgrade`.
- Destructive recreation is disallowed for migrations.
