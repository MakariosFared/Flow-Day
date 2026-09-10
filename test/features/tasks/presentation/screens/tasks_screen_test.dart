import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowday/core/theme/app_theme.dart';
import 'package:flowday/features/tasks/domain/entities/task.dart';
import 'package:flowday/features/tasks/domain/usecases/task_usecases.dart';
import 'package:flowday/features/tasks/presentation/controllers/tasks_controller.dart';
import 'package:flowday/features/tasks/presentation/screens/tasks_screen.dart';

class _FakeTasksController extends TasksController {
  _FakeTasksController({this.onDelete, this.onUndo, this.onComplete}) : super();

  final void Function(String id)? onComplete;
  final TaskUndoToken? Function(String id)? onDelete;
  final void Function(TaskUndoToken token)? onUndo;

  @override
  Future<Task> completeTask(String taskId) async {
    onComplete?.call(taskId);
    return Task(
      id: taskId,
      title: 'Completed Task',
      estimatedDuration: const Duration(minutes: 30),
      status: TaskStatus.completed,
      createdAt: DateTime(2026, 9, 10),
      updatedAt: DateTime(2026, 9, 10),
    );
  }

  @override
  Future<TaskUndoToken?> deleteTask(String taskId) async {
    if (onDelete != null) return onDelete!(taskId);
    return TaskUndoToken(
      deletedTask: Task(
        id: taskId,
        title: 'Deleted Task',
        estimatedDuration: const Duration(minutes: 30),
        status: TaskStatus.pending,
        createdAt: DateTime(2026, 9, 10),
        updatedAt: DateTime(2026, 9, 10),
      ),
    );
  }

  @override
  Future<void> undoDelete(TaskUndoToken token) async {
    onUndo?.call(token);
  }
}

void main() {
  Widget buildTestWidget({
    required List<Task> tasks,
    List<Category> categories = const [],
    _FakeTasksController? fakeController,
  }) {
    return ProviderScope(
      overrides: [
        tasksStreamProvider.overrideWith((ref) => Stream.value(tasks)),
        categoriesStreamProvider.overrideWith(
          (ref) => Stream.value(categories),
        ),
        if (fakeController != null)
          tasksControllerProvider.overrideWithValue(fakeController),
      ],
      child: MaterialApp(theme: appTheme, home: const TasksScreen()),
    );
  }

  group('TasksScreen Widget Tests', () {
    testWidgets('Displays empty state when no tasks exist', (tester) async {
      await tester.pumpWidget(buildTestWidget(tasks: []));
      await tester.pump();

      expect(find.text('Tasks'), findsOneWidget);
      expect(find.text('No tasks created yet'), findsOneWidget);
      expect(find.text('Add your first task'), findsOneWidget);
    });

    testWidgets('Displays task list items with title and badges', (
      tester,
    ) async {
      final now = DateTime(2026, 9, 10, 9, 0);
      final tasks = [
        Task(
          id: 'task-1',
          title: 'Review PR for Drift',
          estimatedDuration: const Duration(minutes: 45),
          status: TaskStatus.pending,
          priority: TaskPriority.high,
          createdAt: now,
          updatedAt: now,
        ),
      ];

      await tester.pumpWidget(buildTestWidget(tasks: tasks));
      await tester.pump();

      expect(find.text('Review PR for Drift'), findsOneWidget);
      expect(find.text('High'), findsOneWidget);
      expect(find.text('45m'), findsOneWidget);
    });

    testWidgets('Shows Undo SnackBar when task is deleted and triggers undo', (
      tester,
    ) async {
      final now = DateTime(2026, 9, 10, 9, 0);
      final task = Task(
        id: 'task-del-test',
        title: 'Task To Be Dismissed',
        estimatedDuration: const Duration(minutes: 30),
        status: TaskStatus.pending,
        createdAt: now,
        updatedAt: now,
      );

      bool undoCalled = false;
      final fakeController = _FakeTasksController(
        onDelete: (id) => TaskUndoToken(deletedTask: task),
        onUndo: (token) {
          undoCalled = true;
        },
      );

      await tester.pumpWidget(
        buildTestWidget(tasks: [task], fakeController: fakeController),
      );
      await tester.pump();

      expect(find.text('Task To Be Dismissed'), findsOneWidget);

      // Swipe to dismiss
      await tester.drag(
        find.text('Task To Be Dismissed'),
        const Offset(-500, 0),
      );
      await tester.pumpAndSettle();

      // SnackBar appears
      expect(find.text('Task deleted'), findsOneWidget);
      expect(find.text('Undo'), findsOneWidget);

      // Click Undo
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();

      expect(undoCalled, isTrue);
    });

    testWidgets('Tapping complete icon triggers task completion', (
      tester,
    ) async {
      final now = DateTime(2026, 9, 10, 9, 0);
      final task = Task(
        id: 'task-complete-test',
        title: 'Task To Be Completed',
        estimatedDuration: const Duration(minutes: 30),
        status: TaskStatus.pending,
        createdAt: now,
        updatedAt: now,
      );

      String? completedId;
      final fakeController = _FakeTasksController(
        onComplete: (id) {
          completedId = id;
        },
      );

      await tester.pumpWidget(
        buildTestWidget(tasks: [task], fakeController: fakeController),
      );
      await tester.pump();

      expect(find.text('Task To Be Completed'), findsOneWidget);

      final completeButtonFinder = find.byIcon(
        Icons.radio_button_unchecked_rounded,
      );
      expect(completeButtonFinder, findsOneWidget);

      await tester.tap(completeButtonFinder);
      await tester.pump();

      expect(completedId, equals('task-complete-test'));
    });
  });
}
