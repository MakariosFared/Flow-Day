# FlowDay — Product Specification

**Version:** 0.4  
**Status:** Product concept / pre-design  
**Platform:** Flutter Mobile  
**Primary goal:** Build a distinctive productivity app that turns unstructured tasks into a realistic daily plan.

## Changelog (v0.3 → v0.4)

- Resolved the Phase 1 `overdue` contradiction: overdue is now a **derived temporal state**, not a Task lifecycle status.
- Removed `custom` from recurrence types; Phase 1.5 supports **Daily / Weekly** only.
- Clarified the Planning Engine as a pipeline: **Task Ranking → Candidate Tasks → Time Slot Generation → Constraint Checking → Schedule → Reality Check**.
- Standardized task duration around `estimatedDuration`; `actualDuration` remains separate for execution and learning.
- Clarified Preferred Time as a **time-window preference** rather than an exact start time.
- Clarified `dueDate` as a date-level deadline for MVP.
- Fixed break placement to a concrete default of **15 minutes after 90 minutes of continuous focus**.
- Clarified Brain Dump duration fallback: **30 minutes** when no duration can be inferred.
- Defined `Start Focus` behavior and actual-duration tracking at the product level.
- Clarified that Phase 1 supports one continuous daily Available Time range; multiple availability windows are future scope.
- Updated ScheduleBlock to support both task and break blocks.
- Added conflict and duplicate-block rules for scheduling.
- Simplified DailyStats so weekly productivity insights are calculated from historical execution data rather than storing a misleading daily `mostProductiveHourRange`.
- Added Settings to the proposed Flutter feature structure.
- Corrected example dates and arithmetic.
- Clarified recurring templates so generated occurrences preserve relevant task planning properties.
- Kept the core MVP scope unchanged; v0.4 is primarily a specification-consistency and architecture-clarity revision.

---

# 1. Product Overview

## Product Name

**FlowDay**

## One-line description

> FlowDay is a personal day and task planner that turns everything on your mind into a realistic plan for your day.

## Core idea

FlowDay is **not a traditional Todo app**.

The central experience is:

**Capture → Organize → Plan → Execute → Learn**

The user can dump everything they need to do without worrying about organization. FlowDay then helps organize the items, estimate effort, schedule them into available time, execute them through a timeline, and eventually learn from actual behavior.

---

# 2. Product Identity

## What FlowDay is

- Personal Day Planner
- Task Manager
- Time-blocking tool
- Brain Dump tool
- Lightweight productivity tracker

## What FlowDay is NOT

- A generic CRUD Todo app
- A full Notion replacement
- A complex project-management platform
- A calendar clone

## Main differentiator

> **FlowDay doesn't just store your tasks. It turns everything on your mind into a realistic plan for your day.**

---

## 2.1 Competitive Positioning

The Brain Dump → Organize → Time-block loop exists in products like Sunsama, Motion, and Reclaim.ai. FlowDay's differentiation is not "an unprecedented idea" — it is:

- **Mobile-first**, not a desktop/web tool ported to mobile.
- **Offline-first**, with no account or subscription required to get full value.
- **Lightweight**, without the complexity of Notion-style workspaces or full project management.
- **Calm, spatial visual identity**, instead of dense productivity-dashboard UI.

The product should be evaluated and marketed on **execution and feel**, not on novelty of concept alone.

---

# 3. Core Product Loop

```text
        Brain Dump
             ↓
         Organize
             ↓
       Estimate Tasks
             ↓
        Plan the Day
             ↓
      Execute Timeline
             ↓
      Complete / Move
             ↓
       Review the Day
             ↓
      Learn From Reality
```

---

# 4. MVP Scope

To reduce time-to-first-testable-build, the MVP is split into two phases. **Phase 1** must prove the core loop (Brain Dump → realistic Timeline → execution) works and feels right. **Phase 1.5** adds the features that improve the experience once the core loop is validated.

## Phase 1 — Core MVP

- Onboarding
- Today screen
- Create task
- Edit task
- Delete task
- Complete task
- Brain Dump (rule-based)
- Basic task categorization (fixed category list)
- Priority
- Estimated Duration
- Energy Level
- Available time
- Planning Engine
- Daily timeline
- Schedule blocks
- Drag & Drop rescheduling
- Reality Check / overload detection
- Daily progress
- Basic Tasks screen
- Basic Insights
- Undo for destructive actions (session-based)
- Local/offline storage
- Start Focus with basic actual-duration tracking

**Phase 1 fallback behaviors:**

- Incomplete tasks at day's end stay `pending` with no date; there is no dedicated rollover review screen yet.
- Overrunning tasks are visually indicated as **overdue** once their estimated end passes; the app does not automatically shift later blocks in Phase 1. The user manually reschedules if needed.

## Phase 1.5 — Execution Polish

- Recurring tasks (daily/weekly patterns)
- Dedicated Manual Rollover review screen
- Local notifications/reminders
- Live timeline adjustment for overrunning tasks
- Expanded Insights
- Custom category management

## Not included in MVP (either phase)

- AI
- Cloud synchronization
- Authentication
- Social features
- Subscription/payment system
- Advanced collaboration
- Complex project management
- Custom recurrence intervals (e.g. "every 2 days")

---

# 5. Navigation

Primary bottom navigation:

```text
┌─────────────────────────────────┐
│                                 │
│            SCREEN               │
│                                 │
├─────────────────────────────────┤
│                                 │
│ Today     Tasks     Insights    │
│  🏠         ✓          ◉        │
└─────────────────────────────────┘
```

## Main sections

### Today
The primary experience and default screen.

### Tasks
All tasks and task management.

### Insights
Daily/weekly productivity statistics.

### Brain Dump
Accessible primarily through a prominent Floating Action Button on Today.

### Settings
Accessible from the appropriate top-level navigation/header.

---

# 6. Screen Map

The initial product design will cover these screens in order:

1. Onboarding
2. Today
3. Brain Dump
4. Create Task
5. Task Details
6. Tasks
7. Insights
8. Settings

After screen design:

9. Database Schema
10. Domain Models
11. Planning Algorithm
12. Flutter Architecture
13. Sprint 1 implementation

---

# 7. Today Screen

The Today screen is the heart of FlowDay.

It should represent the day as a **visual timeline**, rather than a normal task list.

Example:

```text
TODAY
Sunday, September 6

Good morning.

3h 30m planned
████████░░ 78%

09:00
┌──────────────────────────┐
│ 💻 Flutter Feature       │
│ Work                     │
│ 2h                       │
└──────────────────────────┘

11:00
┌──────────────────────────┐
│ ☕ Break                 │
│ 15 min                   │
└──────────────────────────┘

11:15
┌──────────────────────────┐
│ 📚 Study Dart            │
│ 1h                       │
└──────────────────────────┘

12:15
┌──────────────────────────┐
│ 🏠 Groceries             │
│ 30 min                   │
└──────────────────────────┘

                         [+]
```

The numbers in examples are illustrative only; the UI must calculate them from actual scheduled blocks.

## Core interactions

- Scroll through the day
- Tap a scheduled task
- Drag a task to another time
- Start a task
- Complete a task
- Reschedule a task
- Add a new task
- Open Brain Dump
- See daily progress
- See current/overdue task state

---

# 8. Brain Dump

This is one of FlowDay's defining features.

The user should be encouraged to write without organizing.

Example:

```text
What's on your mind?

finish flutter feature
study isolates
go to gym
buy groceries
call Ahmed
read 20 pages

            Organize →
```

After organizing:

```text
We found 6 tasks.

💻 Work
Finish Flutter Feature
2h • High

📚 Learning
Study Isolates
1h • Medium

🏋️ Health
Go to Gym
1h 30m • Medium

🏠 Personal
Buy Groceries
30m • Low

👥 People
Call Ahmed
15m • Low

📚 Reading
Read 20 pages
30m • Low

        Add to my day
```

## MVP behavior

The initial version can use simple rule-based organization.

If the rule-based classifier cannot infer a duration from the text, it defaults to **30 minutes**. The user can adjust the duration before or after adding the task.

AI classification is a future feature.

---

# 9. Create Task

The task creation flow should be fast.

Required:

- Title
- Estimated Duration

Optional:

- Description
- Category
- Priority
- Date
- Preferred Time Window
- Energy level
- Due Date

Example:

```text
Create Task

Title
[____________________]

Category
[ Work              > ]

Priority
[ Low  Medium  High ]

Duration
[ 1h 30m ]

Date
[ Today             ]

Preferred Time
[ Any time          ]

Energy
[ Low  Medium  High ]

Due Date
[ None              ]

             Create
```

The user should not be forced to fill every field.

---

## 9.1 Preferred Time Window

Preferred Time is a **soft scheduling preference**, not a hard constraint.

MVP options:

```text
Any time
Morning
Afternoon
Evening
```

The Planning Engine should try to honor the preference when possible, but deadlines and priority can override it.

Exact preferred start times are not required in Phase 1.

---

## 9.2 Due Date

For MVP, `dueDate` represents the **calendar date by which the task should be completed**.

It does not represent an exact timestamp.

Example:

```text
Due Date
September 6
```

Exact deadline times can be added in a later version if needed.

---

## 9.3 Recurring Tasks *(Phase 1.5)*

A task can optionally repeat on a pattern:

```text
Repeat
[ Never  Daily  Weekly ]
```

- **Daily**: repeats every day.
- **Weekly**: user selects specific days (e.g. Mon/Wed/Fri for gym).
- **Custom** intervals such as "every 2 days" are excluded.

## Behavior

A recurring task is stored once as a **template** containing reusable task properties:

- Title
- Description
- Category
- Priority
- Estimated Duration
- Preferred Time Window
- Energy Level
- Recurrence pattern
- Start Date
- Optional End Date

The template generates a new Task instance for each occurrence date.

Editing a single occurrence does not affect the template or other occurrences unless the user explicitly chooses:

> Edit all future occurrences

Completing or skipping one occurrence has no effect on future occurrences.

Deleting a recurring task asks:

> Delete just today, or all future occurrences?

---

# 10. Task Details

Example:

```text
Flutter Feature

Priority
High

Duration
2h

Energy
High

Due Date
Today

Category
Work

Subtasks
□ API integration
□ UI
□ Testing
□ Refactor

Notes

Use repository pattern.
Check Dio interceptor.
Handle 401.

        Start Focus
```

## Start Focus

When the user taps **Start Focus**:

1. Task status becomes `inProgress`.
2. The task's focus session starts.
3. The app tracks active focus time.
4. The user can pause/resume the focus session.
5. When the task is completed, the recorded active focus time contributes to `actualDuration`.
6. Completing the task sets `completedAt`.

The MVP does not need advanced time-tracking analytics; it only needs enough data to distinguish estimated effort from actual effort.

## Future capabilities

- Attachments
- Related tasks
- Links
- Task history
- Advanced time tracking
- AI suggestions

---

# 11. Task vs Schedule

This is an important architectural distinction.

A **Task** describes what needs to be done.

A **ScheduleBlock** describes when it is planned.

Example:

```text
Task:
Finish Flutter Feature
Estimated Duration: 2h
Priority: High

Schedule:
September 6
14:00 → 16:00
```

The same task can be rescheduled to a different time.

Therefore:

> **Task ≠ ScheduleBlock**

A task may have zero or one active planned ScheduleBlock. Rescheduling updates/replaces the active block rather than silently creating duplicate active blocks.

---

# 12. Task Status

Lifecycle statuses:

```text
pending
scheduled
inProgress
completed
cancelled
```

There is **no `overdue` lifecycle status**.

`overdue` is a **derived temporal state**.

Example:

```text
status = inProgress
estimated end = 14:00
current time = 14:20

→ UI state: overdue
```

`rescheduled` is also an event/behavior, not a required lifecycle status.

---

# 13. Priority

Initial levels:

```text
Low
Medium
High
```

Internally:

```text
Low    = 1
Medium = 2
High   = 3
```

This makes them usable by the Planning Engine.

---

# 14. Energy Level

Tasks can optionally have:

```text
Low
Medium
High
```

Example:

```text
Coding → High
Reading → Medium
Groceries → Low
Gym → Medium/High
```

This helps FlowDay choose tasks that fit different parts of the day.

---

# 15. Planning Engine

The Planning Engine is a core technical feature.

It receives:

```text
Available Time
Tasks
Estimated Duration
Priority
Due Date
Preferred Time Window
Energy Level
Existing Schedule
```

and produces:

```text
Schedule
Reality Check
```

## Planning Pipeline

```text
Tasks
  ↓
Task Ranking
  ↓
Candidate Tasks
  ↓
Time Slot Generation
  ↓
Constraint Checking
  ↓
Schedule
  ↓
Reality Check
```

Ranking a task and finding a place for that task are treated as separate problems.

---

## 15.1 Task Ranking & Conflict Resolution Rules

When tasks compete for the same time slots:

1. **Due today** — tasks due today are scheduled before tasks with no due date or a future due date, regardless of priority.
2. **Priority** — High > Medium > Low.
3. **Preferred Time Window** — try to place the task inside its preferred window.
4. **Energy Level vs. time of day** — prefer task energy to match the default energy curve.
5. **Duration fit** — shorter tasks may fill small remaining gaps.
6. If all rules tie, preserve user-entered order.

### Default energy curve

```text
06:00 – 12:00  → High energy window
12:00 – 16:00  → Medium energy window
16:00 – end    → Low energy window
```

Energy matching is a **soft preference**. Deadline and priority always win in direct conflicts.

Historical learning can replace this default curve later.

---

## 15.2 Scheduling Rules

Phase 1 scheduling rules:

- Tasks are scheduled only inside the day's Available Time range.
- A task is not split into multiple blocks in MVP.
- A task requires a continuous slot equal to its estimated duration.
- Preferred Time Window is soft, not mandatory.
- Existing user-scheduled blocks are respected.
- The engine must not create overlapping ScheduleBlocks.
- If a task cannot fit, it remains unscheduled and is considered by Reality Check.
- The engine should prefer the earliest valid slot after ranking constraints are satisfied.
- Manual user rescheduling has higher authority than an automatic re-plan for the same day.

Task splitting can be considered in a future version.

---

## 15.3 Break Placement

- A short break of **15 minutes by default** is automatically inserted after any continuous focus block of **90 minutes or more**.
- Break duration is configurable in Settings.
- Suggested settings options: 5 / 10 / 15 / 20 / 30 minutes.
- Breaks are not counted in `plannedMinutes`.
- Breaks can be moved or deleted by the user.
- A break should not be inserted in the middle of a task.

---

## 15.4 Available Time

Phase 1 supports **one continuous Available Time range per day**.

Example:

```text
09:00 → 18:00
```

If the user has not set a range for the day:

- Use the configurable Working Hours default.
- On first use, ask the user to define the default.
- Reuse the setting on future days until changed.

Multiple separate availability windows are outside Phase 1.

---

# 16. Reality Check

FlowDay should detect unrealistic schedules.

Example:

```text
Your day looks ambitious.

Available: 6h
Planned:   8h

⚠️ Overloaded by 2h
```

The goal is not to force every task into the day.

The goal is to create a **realistic plan**.

## 16.1 Keep vs. Move Selection Logic

When overloaded:

1. Tasks with **no deadline today** are suggested to move first.
2. Among those, **Low priority** tasks are suggested before Medium, before High.
3. Among equal priority, **longer-duration** tasks are suggested before shorter ones.

This is only a **suggestion** — the user has full control to change the selection before confirming.

---

# 17. Daily Review

At the end of the day:

```text
YOUR DAY

76%

Completed
██████████████░░░░

✓ Flutter Feature
✓ Gym
✓ Study Dart

→ Groceries
→ Reading

You completed 3 of 5 tasks.

Focus time
3h 45m
```

The app should encourage rescheduling rather than making unfinished tasks feel like failures.

---

# 17.1 Manual Rollover Flow

## Phase 1 — fallback

Incomplete tasks are **not automatically moved to tomorrow**.

They remain:

```text
status = pending
date = null
```

and reappear in the Tasks list.

## Phase 1.5 — dedicated review

```text
YOUR DAY

3 tasks weren't finished.

□ Groceries        → Move to tomorrow?
□ Reading          → Move to tomorrow?
□ Call Ahmed       → Move to tomorrow?

        Review & Move
```

Each task can be:

- Move to tomorrow
- Move to a specific date
- Discard

If the user closes the review without deciding, the task remains pending with no date.

---

# 18. Weekly Insights

Initial statistics:

```text
THIS WEEK

Tasks completed
34

Completion rate
81%

Focus time
18h 40m

Best day
Tuesday

Most productive time
10 AM – 1 PM
```

`Most productive time` should be calculated from historical execution data rather than stored as a daily statistic.

If there is not enough historical data, show:

```text
Not enough data yet
```

Future insight example:

> You usually underestimate coding tasks by 22%.

This requires enough historical data and will be added later.

---

# 19. Notes

FlowDay can include notes, but notes are not the main product.

Notes should be attached to tasks.

The product remains centered around tasks and planning.

---

# 20. Future AI Features

AI should be introduced after the core product works.

## AI Brain Dump

User:

> finish flutter feature, study isolates, gym, groceries

AI converts this into structured tasks.

## AI Day Planning

User:

> I only have four hours today and seven tasks.

AI suggests a plan.

The user should approve or edit the plan.

AI is not required for the core value proposition.

---

# 21. Personal Productivity Learning

In later versions, FlowDay can learn from:

- Estimated duration
- Actual duration
- Completion time
- Rescheduling frequency
- Preferred working hours
- Task categories
- Energy levels
- Daily completion patterns

Example:

> Flutter tasks usually take you 25% longer than estimated.

This can improve future planning.

---

# 22. Data Model Overview

Initial entities:

```text
Task
Category
ScheduleBlock
DailyPlan
DailyStats
RecurrenceTemplate
```

## Task

```text
id
title
description
categoryId
priority
estimatedDuration
actualDuration
status
dueDate
preferredTimeWindow
energyLevel
recurrenceTemplateId   (nullable)
createdAt
updatedAt
completedAt
```

Notes:

- `estimatedDuration` is the canonical planning estimate.
- `actualDuration` stores measured active focus time.
- UI may label `estimatedDuration` as "Duration".
- `dueDate` is date-level in MVP.
- `preferredTimeWindow` is an enum such as `anytime | morning | afternoon | evening`.

## RecurrenceTemplate

```text
id
title
description
categoryId
priority
estimatedDuration
preferredTimeWindow
energyLevel
recurrenceType    (daily | weekly)
recurrenceDays    (e.g. [Mon, Wed, Fri], for weekly)
startDate
endDate           (nullable)
createdAt
updatedAt
```

## ScheduleBlock

```text
id
taskId            (nullable for breaks)
date
startTime
endTime
blockType         (task | break)
source            (auto | manual)
```

Rules:

- `taskId` is required when `blockType = task`.
- `taskId` is null when `blockType = break`.
- A task should not have multiple overlapping active ScheduleBlocks.
- Rescheduling updates/replaces the active block rather than creating an accidental duplicate.
- `source` distinguishes Planning Engine output from manual user scheduling.

## Category

```text
id
name
icon
```

Phase 1 uses a fixed category list.

Phase 1.5 adds custom category management.

## DailyPlan

```text
id
date
availableStartTime
availableEndTime
plannedMinutes
completedMinutes
```

Phase 1 intentionally supports one continuous availability range.

## DailyStats

```text
id
date
tasksPlanned
tasksCompleted
plannedMinutes
completedMinutes
overloadedMinutes
tasksRolledOver
```

`mostProductiveHourRange` is not stored here because it is a historical/weekly insight rather than a single-day fact.

`tasksRolledOver` may remain `0` in Phase 1 and becomes meaningful in Phase 1.5.

---

# 23. Local-First Architecture

The application should work completely offline in the MVP.

Initial flow:

```text
UI
 ↓
Use Case
 ↓
Repository
 ↓
Local Database
```

Future cloud architecture:

```text
UI
 ↓
Use Case
 ↓
Repository
 ↓
Local Database
 ↕
Cloud Sync
```

---

# 24. Proposed Flutter Stack

## Framework

Flutter

## Architecture

Clean Architecture + Feature-Based structure

## State Management

Riverpod

## Database

Drift + SQLite

## Core principles

- Offline-first
- Repository Pattern
- Dependency Injection
- Separation of concerns
- Testable business logic
- Immutable/domain-oriented models where appropriate

---

# 25. Proposed Flutter Structure

```text
lib/
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── theme/
│   ├── utils/
│   ├── planning/
│   └── widgets/
│
├── features/
│   ├── today/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── tasks/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── brain_dump/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── insights/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── settings/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart
```

---

# 26. Design Direction

FlowDay should not visually copy Notion, Todoist, or Google Tasks.

Desired visual identity:

- Calm
- Minimal
- Spatial
- Focused
- Modern
- Clear
- Low cognitive load

## Main visual element

The **Timeline** should be the visual identity of the app.

## Animations

Animations should communicate state changes rather than exist only for decoration.

Examples:

```text
Task created
    ↓
flies into Timeline

Task completed
    ↓
smooth collapse

Task moved
    ↓
Timeline rearranges

Day completed
    ↓
subtle progress animation
```

---

# 27. Notifications *(Phase 1.5)*

FlowDay includes basic local notifications to support execution.

## Scope

- A single reminder before a scheduled task starts (default: 5 minutes before, user-configurable).
- A gentle end-of-day nudge if the Daily Review hasn't been opened yet.

## Explicitly not in scope

- Smart/adaptive notification timing
- Location-based reminders
- Multiple reminders per task

All notifications are local and scheduled on-device.

---

# 28. Live Timeline Adjustment

## Phase 1 — fallback

When a task started via `Start Focus` runs longer than its estimated duration:

- The task remains `inProgress` while it is being worked on.
- The UI derives an **overdue** state once estimated time has passed.
- The app does not automatically shift later blocks.
- The user manually reschedules affected tasks.

## Phase 1.5 — automatic adjustment

- The Timeline automatically shifts all subsequent blocks later by the overrun amount.
- Relative order and gaps are preserved.
- If the shift pushes tasks beyond Available Time, the app treats it as overload and prompts the user to review/move tasks.
- Original `estimatedDuration` is preserved.
- `actualDuration` is recorded separately once the task is completed.
- If the user ends a task early, remaining planned time is freed and subsequent blocks can shift earlier.

---

# 29. Undo

To prevent accidental data loss:

- Deleting a task shows `Task deleted — Undo` for 5 seconds.
- Rescheduling or drag-and-drop moves can be reversed.
- Undo is session-based only in MVP.
- Undo history does not persist across app restarts.

---

# 30. Development Roadmap

## Phase 1 — Core MVP

### Sprint 1 — Foundation

- Flutter project setup
- Project architecture
- Theme
- Routing
- Database setup
- Core models
- Basic dependency injection
- Initial tests

### Sprint 2 — Tasks

- Create
- Read
- Update
- Delete (with Undo)
- Complete
- Categories (fixed list)
- Priority
- Estimated Duration
- Energy level
- Due Date / Preferred Time Window

### Sprint 3 — Today

- Timeline
- Schedule blocks
- Drag & Drop (with Undo)
- Daily progress
- Task rescheduling
- Start Focus
- Derived overdue state

### Sprint 4 — Brain Dump

- Brain Dump UI
- Text parsing
- Basic categorization
- Duration fallback
- Convert to tasks

### Sprint 5 — Planning Engine

- Available time
- Task ranking
- Candidate selection
- Time slot generation
- Constraint checking
- Scheduling
- Break placement
- Conflict detection
- Overload detection
- Keep vs. Move suggestion logic

### Sprint 6 — Insights & Release

- Daily statistics
- Weekly statistics
- Completion rate
- Focus time
- Productivity summaries
- Phase 1 release / first testable build

## Phase 1.5 — Execution Polish

### Sprint 7 — Recurring & Rollover

- Recurring tasks
- Template + occurrence generation
- Dedicated Manual Rollover review screen
- Rolled-over tasks tracking

### Sprint 8 — Notifications & Live Adjustment

- Local reminder notifications
- Live timeline adjustment
- Most productive hour insight

### Sprint 9 — Category Management

- Create/edit/delete custom categories

## Later

- AI
- Authentication
- Cloud sync
- Cross-device synchronization
- Advanced productivity learning
- Exact deadline times
- Multiple availability windows
- Task splitting

---

# 31. Product Principles

These rules should guide future decisions.

### 1. Simplicity first
Adding a feature is only useful if it improves the core experience.

### 2. Tasks should lead to action
The app should help users execute, not only collect tasks.

### 3. Planning must be realistic
Never overload a user's day just to show every task as scheduled.

### 4. Minimize input
Users should be able to create useful tasks quickly.

### 5. Timeline is the center
The day should feel like a flow of activities, not a list of database records.

### 6. Offline-first
Core functionality must work without internet.

### 7. AI comes later
The product must provide value without AI.

---

# 32. Current Product Decision

The selected product direction is:

> **FlowDay — a personal day and task planner that transforms a Brain Dump into a realistic, time-blocked daily plan.**

The MVP focuses on:

```text
Brain Dump
    ↓
Tasks
    ↓
Planning
    ↓
Timeline
    ↓
Execution
    ↓
Daily Review
```

---

# 33. Next Design Phase

The next phase is **UI/UX Design**.

We will design every screen individually in this order:

1. **Onboarding**
2. **Today**
3. **Brain Dump**
4. **Create Task**
5. **Task Details**
6. **Tasks**
7. **Insights**
8. **Settings**

For every screen we will define:

- Purpose
- User goal
- Layout
- Components
- Typography
- Spacing
- Colors
- Icons
- States
- Empty states
- Loading states
- Error states
- Interactions
- Animations
- Navigation
- Edge cases

After completing all screens, we will finalize:

```text
UI/UX
  ↓
Database Schema
  ↓
Domain Models
  ↓
Planning Algorithm
  ↓
Flutter Architecture
  ↓
Sprint 1
```

---

# 34. Document Status

**Current status:** Product concept approved (**v0.4**) — specification consistency and architecture ambiguities resolved without expanding the core MVP scope.

The core FlowDay concept remains:

> **Capture → Organize → Plan → Execute → Learn**

The next task is to start detailed UI/UX design with the **Onboarding** screen, scoped to Phase 1 first.

Phase 1.5 screens and behaviors can be designed after the core Phase 1 experience is validated.

**Important:** Any future product or architecture decision should be evaluated against the core FlowDay concept and updated in this document when finalized.
