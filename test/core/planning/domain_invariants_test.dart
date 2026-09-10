import 'package:flutter_test/flutter_test.dart';
import 'package:flowday/features/tasks/domain/entities/task.dart';
import 'package:flowday/features/today/domain/entities/schedule_block.dart';

void main() {
  test('overdue is derived and is not a task lifecycle status', () {
    final start = DateTime.utc(2026, 9, 10, 9);
    final task = Task(
      id: 'task-1',
      title: 'Plan',
      estimatedDuration: const Duration(hours: 1),
      status: TaskStatus.inProgress,
      createdAt: start,
      updatedAt: start,
    );

    expect(
      task.isOverdue(
        now: start.add(const Duration(hours: 2)),
        scheduledEnd: start.add(const Duration(hours: 1)),
      ),
      isTrue,
    );
    expect(
      TaskStatus.values.map((status) => status.name),
      isNot(contains('overdue')),
    );
  });

  test('a break block cannot reference a task', () {
    final start = DateTime.utc(2026, 9, 10, 9);
    expect(
      () => ScheduleBlock(
        id: 'break-1',
        date: start,
        start: start,
        end: start.add(const Duration(minutes: 15)),
        type: ScheduleBlockType.breakBlock,
        source: ScheduleBlockSource.automatic,
        taskId: 'task-1',
      ),
      throwsA(isA<AssertionError>()),
    );
  });
}
