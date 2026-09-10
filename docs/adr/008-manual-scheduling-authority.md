# ADR-008 Manual scheduling authority

## Context
Automatic replanning must not override user intent.

## Decision
Manual ScheduleBlocks reserve time and outrank automatic planner output.

## Reason
Users retain control and trust in a realistic plan.

## Consequences
Replans replace only automatic blocks and reject overlaps; manual changes are auditable by source.
