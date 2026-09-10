# ADR-002 Drift + SQLite

## Context
FlowDay needs local relational data, migrations, transactions, and testability.

## Decision
Use Drift over SQLite.

## Reason
It provides typed queries and migrations while retaining SQLite transactional guarantees.

## Consequences
Generated/data types stay in infrastructure; migration tests are mandatory.
