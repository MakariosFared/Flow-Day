# ADR-006 Task vs ScheduleBlock separation

## Context
An intention and its placement have different lifecycles.

## Decision
Model Task as what and ScheduleBlock as when.

## Reason
Rescheduling must not mutate task intent or create duplicate plans.

## Consequences
Tasks can be unscheduled; blocks have interval/source constraints; overdue remains derived.
