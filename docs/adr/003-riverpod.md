# ADR-003 Riverpod

## Context
Features need testable dependency injection and derived reactive state.

## Decision
Use Riverpod exclusively for application state and DI.

## Reason
Provider overrides and explicit dependencies fit Clean Architecture.

## Consequences
No BLoC, GetX, Redux, or second state framework; ephemeral widget state remains local.
