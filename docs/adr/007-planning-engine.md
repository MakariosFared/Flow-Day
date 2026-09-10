# ADR-007 Planning Engine separation

## Context
The engine is the core product differentiator and needs deterministic tests.

## Decision
Implement it as pure domain interfaces/services receiving explicit requests.

## Reason
This makes ranking, slots, constraints, and Reality Check independent of UI and DB.

## Consequences
Use cases load/persist; the engine never calls repositories or Flutter APIs.
