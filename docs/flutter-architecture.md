# Flutter architecture

FlowDay uses feature-first Clean Architecture. Dependency direction is Presentation → Application/use cases → Domain ← Data. `core/planning` is a domain-oriented shared module, never a widget service.

```text
lib/
  core/{database,di,errors,planning,routing,theme}
  features/
    tasks/{data,domain/{entities,repositories,usecases},presentation}
    today/{data,domain/{entities,repositories,usecases},presentation}
    brain_dump/{data,domain,presentation}
    insights/{data,domain,presentation}
    settings/{data,domain,presentation}
```

- Presentation: Riverpod providers/controllers and widgets only. Today reads a derived `TodayViewState`; it never ranks or schedules tasks.
- Application: use cases orchestrate repositories and pure domain services.
- Domain: entities, repository interfaces, invariants, planning interfaces. No Flutter or Drift imports.
- Data: Drift tables, DAOs, converters, repository implementations and local data source.
- Composition root: `core/di` wires concrete Drift repositories and engine implementations. Riverpod is the DI mechanism; use provider overrides for tests.

Routing uses `go_router`; Sprint 1 exposes only a foundation route. Theme is Material 3-based but screen/UI work is explicitly deferred.

## Riverpod ownership

| State | Owner |
|---|---|
| Dialog visibility, drag affordance, transient selection | Local widget state |
| Today date, plan, blocks, current task, progress, Reality Check | Today feature providers; derived from repository streams and clock provider |
| Task lists and mutations | Tasks feature providers/use cases |
| Planning execution/loading/error | Scoped planning controller/provider |
| Focus elapsed time | Focus session controller backed by persistence and a testable clock |
| Persisted data | Drift repositories only |

Future cloud sync is a second data source behind the same repository interfaces; no auth/network dependency belongs in Phase 1.

## Today and focus data flow

`GetTodayPlan(date)` combines the DailyPlan, scheduled blocks, referenced Tasks, a clock-derived current task/overdue state, daily progress, and Reality Check into a presentation DTO. The Today controller only observes this DTO and invokes use cases; it never invokes the Planning Engine directly. `StartFocus` persists an active `FocusSession`, then a timer renders elapsed time from the injected clock. Pause/resume and completion persist accumulated active duration. On launch, the controller restores an active/paused session and recomputes elapsed time, avoiding timer state as a source of truth.
