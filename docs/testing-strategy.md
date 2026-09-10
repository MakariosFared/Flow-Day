# Testing strategy

## Implemented Test Suites (22 tests passing)

1. **Clock Tests (`test/core/clock/clock_test.dart`)**:
   - `SystemClock` returns valid non-null system time.
   - `FakeClock` enables deterministic time travel and advancement for testing time-sensitive business logic.

2. **Domain Invariants & Lifecycle Tests (`test/features/tasks/domain/task_lifecycle_test.dart` & `test/core/planning/domain_invariants_test.dart`)**:
   - `Task` requires non-empty title, positive duration, non-negative actual duration.
   - `RecurrenceTemplate` requires days for weekly recurrence.
   - Lifecycle state machine strictly enforces valid transitions (`pending -> scheduled -> inProgress -> completed`, etc.) and rejects invalid ones.
   - `overdue` is derived from clock and scheduled end, not a lifecycle status.

3. **ScheduleBlock Invariants Tests (`test/features/today/domain/schedule_block_invariants_test.dart`)**:
   - Schedule interval requires `end.isAfter(start)`.
   - Task blocks require `taskId`; Break blocks forbid `taskId`.
   - `DailyPlan` enforces valid start/end range and non-negative minute counts.

4. **Database & Repository Integration Tests (`test/core/database/database_and_repository_test.dart`)**:
   - Runs against in-memory SQLite database (`AppDatabase.inMemory()`).
   - Phase 1 fixed categories seeded deterministically and idempotently (6 default categories).
   - `TaskRepository` full CRUD.
   - `ScheduleRepository` strictly preserves manual blocks when replacing automatic blocks during re-plan.
   - `DailyStats` independence: deleting a task does NOT delete historical `DailyStats` snapshots.
   - `FocusSessionRepository` saves and recovers active/paused focus sessions.

5. **Use Cases Tests (`test/features/tasks/domain/usecases/task_usecases_test.dart` & `test/features/today/domain/usecases/today_and_focus_usecases_test.dart`)**:
   - `CreateTask` validation and persistence.
   - `UpdateTask` updating attributes and timestamps.
   - `DeleteTask` session-based undo token and restoration.
   - `CompleteTask` state transition and `completedAt`.
   - **Focus Flow**: Verifies `PauseFocus` keeps `Task.status` as `inProgress` while accumulating `activeDuration`.
   - `RescheduleTask`: Creates manual block and updates task to `scheduled`.
   - `GetTodayPlan`: Aggregates view data, active current task, derived overdue state, and progress percentage.

## CI / Verification Commands

- `dart format --set-exit-if-changed .`
- `flutter analyze` (0 issues found)
- `flutter test` (22 tests passed)
