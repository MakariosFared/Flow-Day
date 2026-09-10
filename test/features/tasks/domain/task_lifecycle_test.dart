import 'package:flutter_test/flutter_test.dart';
import 'package:flowday/features/tasks/domain/entities/task.dart';

void main() {
  group('Task Invariants & Lifecycle', () {
    final now = DateTime(2026, 9, 10, 8, 0);

    test('Task requires non-empty title and positive estimatedDuration', () {
      expect(
        () => Task(
          id: '1',
          title: '   ',
          estimatedDuration: const Duration(minutes: 30),
          status: TaskStatus.pending,
          createdAt: now,
          updatedAt: now,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => Task(
          id: '2',
          title: 'Valid',
          estimatedDuration: Duration.zero,
          status: TaskStatus.pending,
          createdAt: now,
          updatedAt: now,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => Task(
          id: '3',
          title: 'Valid',
          estimatedDuration: const Duration(minutes: -10),
          status: TaskStatus.pending,
          createdAt: now,
          updatedAt: now,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('RecurrenceTemplate validates weekly recurrence requires days', () {
      expect(
        () => RecurrenceTemplate(
          id: 'rec-1',
          title: 'Gym',
          estimatedDuration: const Duration(hours: 1),
          recurrenceType: RecurrenceType.weekly,
          recurrenceDays: const {}, // empty!
          startDate: now,
          createdAt: now,
          updatedAt: now,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Lifecycle transitions comply strictly with specification', () {
      final task = Task(
        id: 'task-1',
        title: 'Feature',
        estimatedDuration: const Duration(hours: 2),
        status: TaskStatus.pending,
        createdAt: now,
        updatedAt: now,
      );

      // Pending transitions
      expect(task.canTransitionTo(TaskStatus.scheduled), isTrue);
      expect(task.canTransitionTo(TaskStatus.cancelled), isTrue);
      expect(task.canTransitionTo(TaskStatus.inProgress), isFalse);
      expect(task.canTransitionTo(TaskStatus.completed), isFalse);

      // Scheduled transitions
      final scheduledTask = task.copyWith(status: TaskStatus.scheduled);
      expect(scheduledTask.canTransitionTo(TaskStatus.pending), isTrue);
      expect(scheduledTask.canTransitionTo(TaskStatus.inProgress), isTrue);
      expect(scheduledTask.canTransitionTo(TaskStatus.cancelled), isTrue);
      expect(scheduledTask.canTransitionTo(TaskStatus.completed), isFalse);

      // InProgress transitions
      final inProgressTask = task.copyWith(status: TaskStatus.inProgress);
      expect(inProgressTask.canTransitionTo(TaskStatus.completed), isTrue);
      expect(inProgressTask.canTransitionTo(TaskStatus.scheduled), isFalse);
      expect(inProgressTask.canTransitionTo(TaskStatus.pending), isFalse);

      // Completed is terminal
      final completedTask = task.copyWith(status: TaskStatus.completed);
      expect(completedTask.canTransitionTo(TaskStatus.pending), isFalse);
      expect(completedTask.canTransitionTo(TaskStatus.inProgress), isFalse);

      // Cancelled is terminal
      final cancelledTask = task.copyWith(status: TaskStatus.cancelled);
      expect(cancelledTask.canTransitionTo(TaskStatus.pending), isFalse);
    });
  });
}
