import 'package:flutter_test/flutter_test.dart';
import 'package:flowday/features/today/domain/entities/schedule_block.dart';

void main() {
  group('ScheduleBlock Invariants', () {
    final start = DateTime(2026, 9, 10, 9, 0);
    final end = DateTime(2026, 9, 10, 10, 0);

    test('ScheduleBlock requires end to be strictly after start', () {
      expect(
        () => ScheduleBlock(
          id: 'b1',
          date: start,
          start: start,
          end: start, // same!
          type: ScheduleBlockType.task,
          source: ScheduleBlockSource.manual,
          taskId: 'task-1',
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => ScheduleBlock(
          id: 'b2',
          date: start,
          start: end,
          end: start, // end before start!
          type: ScheduleBlockType.task,
          source: ScheduleBlockSource.manual,
          taskId: 'task-1',
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Task block requires taskId; Break block forbids taskId', () {
      // Task without taskId -> throws
      expect(
        () => ScheduleBlock(
          id: 'b3',
          date: start,
          start: start,
          end: end,
          type: ScheduleBlockType.task,
          source: ScheduleBlockSource.manual,
          taskId: null,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Break with taskId -> throws
      expect(
        () => ScheduleBlock(
          id: 'b4',
          date: start,
          start: start,
          end: end,
          type: ScheduleBlockType.breakBlock,
          source: ScheduleBlockSource.automatic,
          taskId: 'task-1',
        ),
        throwsA(isA<AssertionError>()),
      );

      // Valid break block
      final breakBlock = ScheduleBlock(
        id: 'b5',
        date: start,
        start: start,
        end: end,
        type: ScheduleBlockType.breakBlock,
        source: ScheduleBlockSource.automatic,
        taskId: null,
      );
      expect(breakBlock.type, equals(ScheduleBlockType.breakBlock));
      expect(breakBlock.duration, equals(const Duration(hours: 1)));
    });

    test(
      'DailyPlan invariants validate available time and non-negative minutes',
      () {
        expect(
          () => DailyPlan(
            id: 'dp-1',
            date: start,
            availableStart: end,
            availableEnd: start, // end before start!
            plannedMinutes: 0,
            completedMinutes: 0,
          ),
          throwsA(isA<AssertionError>()),
        );

        expect(
          () => DailyPlan(
            id: 'dp-2',
            date: start,
            availableStart: start,
            availableEnd: end,
            plannedMinutes: -5, // negative!
            completedMinutes: 0,
          ),
          throwsA(isA<AssertionError>()),
        );
      },
    );
  });
}
