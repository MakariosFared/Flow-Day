# Repositories and use cases

## Implemented Repositories

| Interface | Implementation | Location |
|---|---|---|
| `TaskRepository` | `TaskRepositoryImpl` | `features/tasks/data/repositories/` |
| `CategoryRepository` | `CategoryRepositoryImpl` | `features/tasks/data/repositories/` |
| `RecurrenceRepository` | `RecurrenceRepositoryImpl` | `features/tasks/data/repositories/` |
| `ScheduleRepository` | `ScheduleRepositoryImpl` | `features/today/data/repositories/` |
| `DailyPlanRepository` | `DailyPlanRepositoryImpl` | `features/today/data/repositories/` |
| `DailyStatsRepository` | `DailyStatsRepositoryImpl` | `features/today/data/repositories/` |
| `FocusSessionRepository` | `FocusSessionRepositoryImpl` | `features/today/data/repositories/` |

## Implemented Use Cases

| Use case | Responsibilities & Business Rules |
|---|---|
| `CreateTask` | Enforces non-empty title and positive duration. Initializes task as `pending`. |
| `UpdateTask` | Enforces validation rules and updates `updatedAt` timestamp via injected `Clock`. |
| `DeleteTask` | Deletes task and returns `TaskUndoToken` for session-based Undo (`undo()` restores task). |
| `CompleteTask` | Enforces valid lifecycle transition. Sets status `completed` and records `completedAt`. |
| `GetTasks` | Retrieves all tasks or watches active stream from database. |
| `GetTaskById` | Retrieves single task by id. |
| `StartFocus` | Transitions task to `inProgress`. Creates or resumes active `FocusSession`. |
| `PauseFocus` | **Task status remains `inProgress`**. `FocusSession` transitions to `paused`. Accumulates active duration. |
| `ResumeFocus` | Re-activates paused session and restarts active time tracking. |
| `CompleteFocus` | Sets `FocusSession` to `completed`. Sets task to `completed`, updates `actualDuration` and `completedAt`. |
| `RescheduleTask` | Creates or updates a manual `ScheduleBlock` (`source = manual`). Transitions pending task to `scheduled`. |
| `GetTodayPlan` | Combines `DailyPlan`, `ScheduleBlock`s, tasks, active `currentTask`, derived `overdueTaskIds`, and progress percentage. |
| `GenerateDailyPlan` | Calls pure `PlanningEngine` and delegates to `replaceAutomaticBlocks` preserving manual blocks. |
