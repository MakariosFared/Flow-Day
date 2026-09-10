# ADR-005 Feature-based structure

## Context
FlowDay grows by user capability, not technical layer alone.

## Decision
Organize data/domain/presentation beneath feature folders, retaining shared core modules.

## Reason
It keeps Today, Tasks, Brain Dump, Insights, and Settings coherent.

## Consequences
Cross-feature use cases depend on domain interfaces, not another feature’s data implementation.
