import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowday/core/theme/app_theme.dart';
import 'package:flowday/features/tasks/domain/entities/task.dart';
import 'package:flowday/features/tasks/presentation/controllers/tasks_controller.dart';
import 'package:flowday/features/tasks/presentation/screens/create_task_screen.dart';
import 'package:flowday/features/tasks/presentation/screens/edit_task_screen.dart';
import 'package:flowday/features/tasks/presentation/screens/task_details_screen.dart';
import 'package:flowday/features/today/domain/entities/schedule_block.dart';

class _FakeTasksController extends TasksController {
  _FakeTasksController({
    this.onCreate,
    this.onUpdate,
    this.onComplete,
    this.onStartFocus,
  }) : super();

  final void Function(String title, Duration duration)? onCreate;
  final void Function(Task task)? onUpdate;
  final void Function(String id)? onComplete;
  final void Function(String id)? onStartFocus;

  @override
  Future<Task> createTask({
    required String title,
    required Duration estimatedDuration,
    String? description,
    String? categoryId,
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueDate,
    PreferredTimeWindow preferredTimeWindow = PreferredTimeWindow.anytime,
    EnergyLevel? energyLevel,
  }) async {
    onCreate?.call(title, estimatedDuration);
    return Task(
      id: 'task-created-id',
      title: title,
      estimatedDuration: estimatedDuration,
      status: TaskStatus.pending,
      createdAt: DateTime(2026, 9, 10),
      updatedAt: DateTime(2026, 9, 10),
    );
  }

  @override
  Future<Task> updateTask(Task task) async {
    onUpdate?.call(task);
    return task;
  }

  @override
  Future<Task> completeTask(String taskId) async {
    onComplete?.call(taskId);
    return Task(
      id: taskId,
      title: 'Completed',
      estimatedDuration: const Duration(minutes: 30),
      status: TaskStatus.completed,
      createdAt: DateTime(2026, 9, 10),
      updatedAt: DateTime(2026, 9, 10),
    );
  }

  @override
  Future<FocusSession> startFocus(String taskId) async {
    onStartFocus?.call(taskId);
    return FocusSession(
      id: 'session-id',
      taskId: taskId,
      state: FocusSessionState.active,
      startedAt: DateTime(2026, 9, 10),
      activeDuration: Duration.zero,
    );
  }
}

void main() {
  group('CreateTaskScreen & TaskDetailsScreen & EditTaskScreen Widget Tests', () {
    testWidgets(
      'CreateTaskScreen validates empty title and creates valid task',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        String? createdTitle;
        Duration? createdDuration;

        final fakeController = _FakeTasksController(
          onCreate: (title, duration) {
            createdTitle = title;
            createdDuration = duration;
          },
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              categoriesStreamProvider.overrideWith((ref) => Stream.value([])),
              tasksControllerProvider.overrideWithValue(fakeController),
            ],
            child: MaterialApp(theme: appTheme, home: const CreateTaskScreen()),
          ),
        );
        await tester.pump();

        expect(find.text('Create Task'), findsWidgets);

        final submitFinder = find.widgetWithText(ElevatedButton, 'Create Task');
        await tester.ensureVisible(submitFinder);

        // Tap Create Task without title -> validation error
        await tester.tap(submitFinder);
        await tester.pump();

        expect(find.text('Title is required'), findsOneWidget);

        // Enter valid title
        await tester.enterText(
          find.byType(TextFormField).first,
          'Write Sprint 2 Specs',
        );
        await tester.pump();

        // Submit
        await tester.ensureVisible(submitFinder);
        await tester.tap(submitFinder);
        await tester.pump();

        expect(createdTitle, equals('Write Sprint 2 Specs'));
        expect(createdDuration, equals(const Duration(minutes: 30)));
      },
    );

    testWidgets(
      'TaskDetailsScreen displays details and handles focus & complete actions',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        final now = DateTime(2026, 9, 10, 9, 0);
        final task = Task(
          id: 'task-details-1',
          title: 'Detailed Task Title',
          estimatedDuration: const Duration(hours: 1),
          description: 'Notes for this task',
          status: TaskStatus.scheduled,
          priority: TaskPriority.high,
          createdAt: now,
          updatedAt: now,
        );

        bool startFocusCalled = false;
        bool completeTaskCalled = false;

        final fakeController = _FakeTasksController(
          onStartFocus: (id) => startFocusCalled = true,
          onComplete: (id) => completeTaskCalled = true,
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              taskByIdProvider(
                'task-details-1',
              ).overrideWith((ref) => Stream.value(task)),
              categoriesStreamProvider.overrideWith((ref) => Stream.value([])),
              tasksControllerProvider.overrideWithValue(fakeController),
            ],
            child: MaterialApp(
              theme: appTheme,
              home: const TaskDetailsScreen(taskId: 'task-details-1'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Detailed Task Title'), findsOneWidget);
        expect(find.text('Notes for this task'), findsOneWidget);
        expect(find.text('High'), findsOneWidget);
        expect(find.text('1h'), findsOneWidget);
        final startFocusFinder = find.ancestor(
          of: find.text('Start Focus'),
          matching: find.byWidgetPredicate((w) => w is ElevatedButton),
        );
        expect(startFocusFinder, findsOneWidget);
        await tester.tap(startFocusFinder);
        await tester.pumpAndSettle();
        expect(startFocusCalled, isTrue);

        final completeFinder = find.ancestor(
          of: find.text('Complete Task'),
          matching: find.byWidgetPredicate((w) => w is OutlinedButton),
        );
        expect(completeFinder, findsOneWidget);
        await tester.tap(completeFinder);
        await tester.pumpAndSettle();
        expect(completeTaskCalled, isTrue);

        // Drain any SnackBar timer before test finishes
        await tester.pump(const Duration(seconds: 5));
      },
    );

    testWidgets('EditTaskScreen pre-fills values and saves updates', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final now = DateTime(2026, 9, 10, 9, 0);
      final task = Task(
        id: 'task-edit-1',
        title: 'Original Title',
        estimatedDuration: const Duration(minutes: 45),
        status: TaskStatus.pending,
        createdAt: now,
        updatedAt: now,
      );

      String? updatedTitle;

      final fakeController = _FakeTasksController(
        onUpdate: (updated) {
          updatedTitle = updated.title;
        },
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            taskByIdProvider(
              'task-edit-1',
            ).overrideWith((ref) => Stream.value(task)),
            categoriesStreamProvider.overrideWith((ref) => Stream.value([])),
            tasksControllerProvider.overrideWithValue(fakeController),
          ],
          child: MaterialApp(
            theme: appTheme,
            home: const EditTaskScreen(taskId: 'task-edit-1'),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Original Title'), findsOneWidget);

      // Change title
      await tester.enterText(
        find.byType(TextFormField).first,
        'Modified Title',
      );
      await tester.pump();

      // Tap Save Changes
      final saveFinder = find.widgetWithText(ElevatedButton, 'Save Changes');
      await tester.ensureVisible(saveFinder);
      await tester.tap(saveFinder);
      await tester.pump();

      expect(updatedTitle, equals('Modified Title'));
    });
  });
}
