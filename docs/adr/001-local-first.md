# ADR-001 Local-first architecture

## Context
Phase 1 must work offline and excludes authentication/cloud sync.

## Decision
Persist all core data locally behind repositories.

## Reason
It fulfills MVP reliability and keeps planning available without network.

## Consequences
Repositories must support a future sync source without exposing it now.
