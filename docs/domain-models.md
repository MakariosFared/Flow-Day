# Domain models

## Shared invariants

Domain entities are immutable and use domain value types (`Duration`, calendar date, enums), never Drift rows or SQL dates. `estimatedDuration` is positive and is the sole planning estimate; `actualDuration` is accumulated active focus time. Calendar dates do not carry deadline times in MVP.

| Model | Purpose and rules |
|---|---|
| Task | The **what**. Required non-empty title and positive estimate; optional category, due date, preferred window, energy, and recurrence source. Lifecycle is `pending`, `scheduled`, `inProgress`, `completed`, `cancelled`. A Task can exist without a ScheduleBlock. `overdue` is derived only from in-progress task plus estimated scheduled end. |
| ScheduleBlock | The **when**. Has a date, non-empty continuous interval, type (`task` or `breakBlock`), and source (`automatic` or `manual`). Task blocks require a task ID; breaks forbid one. |
| Category | Fixed Phase 1 classification (`Work`, `Learning`, `Health`, `Personal`, `People`, `Reading`) with stable id, name, and icon. Custom management is Phase 1.5. |
| DailyPlan | A day’s one continuous available range and its aggregate planned/completed minutes. It owns no task lifecycle. |
| DailyStats | Durable daily aggregate: planned/completed counts and minutes, overload and rollover counters. Independent historical snapshot that survives task deletion. |
| RecurrenceTemplate | Phase 1.5 source for daily/weekly occurrence tasks. Occurrences copy planning properties; changing one occurrence does not mutate the template. |
| FocusSession | Basic execution record for a Task. Active time excludes pauses; completion contributes to Task.actualDuration. Resilient to process restarts. |

## Approved Architectural Decisions

1. **Pause Focus**: When a focus session is paused, `Task.status` remains `inProgress`. The `FocusSession` itself transitions to `paused`. Pausing does not return the task to `scheduled`.
2. **Manual Scheduling Authority**: Manual schedule blocks have higher authority than automatic ones. Automatic re-planning strictly preserves manual blocks.
3. **Historical Statistics Independence**: `DailyStats` is an independent aggregate record. Deleting a `Task` does not delete or alter historical `DailyStats` snapshots.
4. **Re-planning**: When re-planning a day, `auto` blocks are replaced, while `manual` blocks are preserved.

## Transitions and relationships

- `pending → scheduled`: valid task ScheduleBlock created.
- `scheduled → pending`: active schedule removed.
- `scheduled → inProgress`: Start Focus.
- `inProgress → completed`: Complete Focus / Task complete with `completedAt`.
- `pending / scheduled → cancelled`: Task cancelled.
- Cancellation from `inProgress` or reopening from `completed` is prohibited in Phase 1.
