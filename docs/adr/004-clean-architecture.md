# ADR-004 Clean Architecture

## Context
Planning must be independently testable and persistence will evolve.

## Decision
Separate presentation, application, domain, and data with inward dependencies.

## Reason
It prevents Flutter/Drift from contaminating business rules.

## Consequences
Mapping code and interfaces add structure but make testing and future sync safer.
