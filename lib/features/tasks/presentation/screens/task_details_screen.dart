import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/task.dart';
import '../controllers/tasks_controller.dart';
import '../widgets/priority_badge.dart';

class TaskDetailsScreen extends ConsumerStatefulWidget {
  const TaskDetailsScreen({super.key, required this.taskId});
  final String taskId;

  @override
  ConsumerState<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends ConsumerState<TaskDetailsScreen> {
  bool _isLoadingAction = false;

  Future<void> _startFocus(Task task) async {
    setState(() => _isLoadingAction = true);
    try {
      final controller = ref.read(tasksControllerProvider);
      await controller.startFocus(task.id);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Focus session started')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Cannot start focus: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingAction = false);
      }
    }
  }

  Future<void> _completeTask(Task task) async {
    setState(() => _isLoadingAction = true);
    try {
      final controller = ref.read(tasksControllerProvider);
      await controller.completeTask(task.id);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Task completed')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Cannot complete task: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingAction = false);
      }
    }
  }

  Future<void> _deleteTask(Task task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.priorityHigh,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final controller = ref.read(tasksControllerProvider);
      final token = await controller.deleteTask(task.id);

      if (mounted) {
        context.pop();
        if (token != null) {
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskAsync = ref.watch(taskByIdProvider(widget.taskId));
    final categoriesAsync = ref.watch(categoriesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          taskAsync.when(
            data: (task) => task != null
                ? Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: 'Edit Task',
                        onPressed: () => context.push('/tasks/${task.id}/edit'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded),
                        tooltip: 'Delete Task',
                        onPressed: () => _deleteTask(task),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: taskAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (err, _) => Center(child: Text('Error loading task: $err')),
        data: (task) {
          if (task == null) {
            return const Center(
              child: Text(
                'Task not found',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          Category? category;
          categoriesAsync.whenData((cats) {
            category = cats.where((c) => c.id == task.categoryId).firstOrNull;
          });

          final isCompleted = task.status == TaskStatus.completed;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title & Status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: isCompleted
                              ? AppColors.textMuted
                              : AppColors.textPrimary,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    _StatusBadge(status: task.status),
                  ],
                ),
                const SizedBox(height: 16),

                // Metadata Cards
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _DetailRow(
                          label: 'Priority',
                          valueWidget: PriorityBadge(priority: task.priority),
                        ),
                        const Divider(height: 20, color: AppColors.divider),
                        _DetailRow(
                          label: 'Estimated Duration',
                          value: DateTimeUtils.formatDuration(
                            task.estimatedDuration,
                          ),
                        ),
                        if (task.actualDuration > Duration.zero) ...[
                          const Divider(height: 20, color: AppColors.divider),
                          _DetailRow(
                            label: 'Actual Focus Time',
                            value: DateTimeUtils.formatDuration(
                              task.actualDuration,
                            ),
                            valueColor: AppColors.primary,
                          ),
                        ],
                        if (category != null) ...[
                          const Divider(height: 20, color: AppColors.divider),
                          _DetailRow(
                            label: 'Category',
                            value: '${category!.icon}  ${category!.name}',
                          ),
                        ],
                        if (task.dueDate != null) ...[
                          const Divider(height: 20, color: AppColors.divider),
                          _DetailRow(
                            label: 'Due Date',
                            value: DateTimeUtils.formatHumanDate(task.dueDate!),
                          ),
                        ],
                        const Divider(height: 20, color: AppColors.divider),
                        _DetailRow(
                          label: 'Preferred Time',
                          value: switch (task.preferredTimeWindow) {
                            PreferredTimeWindow.anytime => 'Any time',
                            PreferredTimeWindow.morning => 'Morning',
                            PreferredTimeWindow.afternoon => 'Afternoon',
                            PreferredTimeWindow.evening => 'Evening',
                          },
                        ),
                        if (task.energyLevel != null) ...[
                          const Divider(height: 20, color: AppColors.divider),
                          _DetailRow(
                            label: 'Energy Level',
                            value: switch (task.energyLevel!) {
                              EnergyLevel.high => 'High',
                              EnergyLevel.medium => 'Medium',
                              EnergyLevel.low => 'Low',
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Description / Notes
                if (task.description != null &&
                    task.description!.trim().isNotEmpty) ...[
                  const Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        task.description!.trim(),
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ] else
                  const SizedBox(height: 12),

                // Action Buttons
                if (!isCompleted) ...[
                  ElevatedButton.icon(
                    onPressed: _isLoadingAction
                        ? null
                        : () => _startFocus(task),
                    icon: const Icon(Icons.play_arrow_rounded, size: 22),
                    label: const Text('Start Focus'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _isLoadingAction
                        ? null
                        : () => _completeTask(task),
                    icon: const Icon(Icons.check_rounded, size: 20),
                    label: const Text('Complete Task'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final TaskStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (status) {
      TaskStatus.pending => (
        'Pending',
        AppColors.pending,
        const Color(0xFFF1F3F5),
      ),
      TaskStatus.scheduled => (
        'Scheduled',
        AppColors.inProgress,
        const Color(0xFFEBF2FF),
      ),
      TaskStatus.inProgress => (
        'In Progress',
        AppColors.inProgress,
        const Color(0xFFEBF2FF),
      ),
      TaskStatus.completed => (
        'Completed',
        AppColors.completed,
        const Color(0xFFE6F7ED),
      ),
      TaskStatus.cancelled => (
        'Cancelled',
        AppColors.textMuted,
        const Color(0xFFF1F3F5),
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    this.value,
    this.valueWidget,
    this.valueColor,
  });

  final String label;
  final String? value;
  final Widget? valueWidget;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        if (valueWidget != null)
          valueWidget!
        else
          Text(
            value ?? '',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
      ],
    );
  }
}
