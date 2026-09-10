import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/task.dart';
import '../controllers/tasks_controller.dart';
import '../widgets/task_empty_state.dart';
import '../widgets/task_list_item.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(filteredTasksProvider);
    final categoriesAsync = ref.watch(categoriesStreamProvider);
    final currentFilter = ref.watch(taskFilterProvider);
    final controller = ref.read(tasksControllerProvider);

    final categoriesMap = <String, Category>{};
    categoriesAsync.whenData((categories) {
      for (final cat in categories) {
        categoriesMap[cat.id] = cat;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Create Task',
            onPressed: () => context.push('/tasks/create'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                _FilterChip(
                  label: 'All',
                  isSelected: currentFilter == TaskFilter.all,
                  onSelected: () =>
                      ref.read(taskFilterProvider.notifier).state =
                          TaskFilter.all,
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Active',
                  isSelected: currentFilter == TaskFilter.active,
                  onSelected: () =>
                      ref.read(taskFilterProvider.notifier).state =
                          TaskFilter.active,
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Completed',
                  isSelected: currentFilter == TaskFilter.completed,
                  onSelected: () =>
                      ref.read(taskFilterProvider.notifier).state =
                          TaskFilter.completed,
                ),
              ],
            ),
          ),
        ),
      ),
      body: tasksAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 48,
                  color: AppColors.priorityHigh,
                ),
                const SizedBox(height: 12),
                Text(
                  'Failed to load tasks: $error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () => ref.refresh(tasksStreamProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (tasks) {
          if (tasks.isEmpty) {
            return TaskEmptyState(
              message: switch (currentFilter) {
                TaskFilter.all => 'No tasks created yet',
                TaskFilter.active => 'No active tasks to work on',
                TaskFilter.completed => 'No completed tasks yet',
              },
              actionLabel: currentFilter != TaskFilter.completed
                  ? 'Add your first task'
                  : null,
              onAction: () => context.push('/tasks/create'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final category = task.categoryId != null
                  ? categoriesMap[task.categoryId]
                  : null;

              return TaskListItem(
                task: task,
                category: category,
                onTap: () => context.push('/tasks/${task.id}'),
                onComplete: () async {
                  try {
                    await controller.completeTask(task.id);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Cannot complete task: $e')),
                      );
                    }
                  }
                },
                onDelete: () async {
                  final token = await controller.deleteTask(task.id);
                  if (context.mounted && token != null) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Task deleted'),
                        duration: const Duration(seconds: 5),
                        action: SnackBarAction(
                          label: 'Undo',
                          textColor: AppColors.primary,
                          onPressed: () => controller.undoDelete(token),
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/tasks/create'),
        tooltip: 'Create Task',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        color: isSelected ? Colors.white : AppColors.textSecondary,
      ),
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.surface,
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
      ),
    );
  }
}
