import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/task.dart';
import '../controllers/tasks_controller.dart';
import '../widgets/category_chip.dart';
import '../widgets/priority_badge.dart';

class TaskDetailsScreen extends ConsumerStatefulWidget {
  const TaskDetailsScreen({super.key, required this.taskId});
  final String taskId;

  @override
  ConsumerState<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends ConsumerState<TaskDetailsScreen> {
  final List<bool> _subtasks = [true, false, false];
  final List<String> _subtaskLabels = [
    'مراجعة النقاط الأساسية وتحديد الأولويات',
    'تطبيق التعديلات واختبار التوافق',
    'التأكد من سهولة الاستخدام والانسيابية',
  ];

  void _startFocus(Task task) {
    ref.read(tasksControllerProvider).startFocus(task.id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('بدأت جلسة التركيز 🌱')),
    );
    context.push('/focus/${task.id}');
  }

  void _toggleComplete(Task task) {
    ref.read(tasksControllerProvider).toggleComplete(task.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          task.status == TaskStatus.completed
              ? 'تمت إعادة المهمة للنشطة'
              : 'رائع! تم اكتمال المهمة بنجاح ✓',
        ),
      ),
    );
  }

  Future<void> _deleteTask(Task task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف المهمة'),
        content: Text('هل أنت متأكد من رغبتك في حذف "${task.title}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      ref.read(tasksControllerProvider).deleteTask(task.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حذف المهمة')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskAsync = ref.watch(taskByIdProvider(widget.taskId));
    final categoriesAsync = ref.watch(categoriesStreamProvider);

    final categoriesMap = <String, Category>{};
    categoriesAsync.whenData((categories) {
      for (final cat in categories) {
        categoriesMap[cat.id] = cat;
      }
    });

    return taskAsync.when(
      data: (task) {
        if (task == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('تفاصيل المهمة')),
            body: const Center(child: Text('المهمة غير موجودة أو تم حذفها')),
          );
        }

        final category = task.categoryId != null ? categoriesMap[task.categoryId] : null;
        final isCompleted = task.status == TaskStatus.completed;

        return Scaffold(
          appBar: AppBar(
            title: const Text('تفاصيل المهمة'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'تعديل المهمة',
                onPressed: () => context.push('/tasks/${task.id}/edit'),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: AppColors.danger),
                tooltip: 'حذف المهمة',
                onPressed: () => _deleteTask(task),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _toggleComplete(task),
                      icon: Icon(
                        isCompleted ? Icons.undo_rounded : Icons.check_circle_outline_rounded,
                        size: 18,
                      ),
                      label: Text(isCompleted ? 'إعادة فتح' : 'اكتمال المهمة'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        foregroundColor: isCompleted ? AppColors.getSecondaryText(context) : AppColors.success,
                        side: BorderSide(
                          color: isCompleted ? AppColors.getBorderMedium(context) : AppColors.success,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _startFocus(task),
                      icon: const Icon(Icons.play_arrow_rounded, size: 20),
                      label: const Text('بدء التركيز'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        backgroundColor: AppColors.getPrimaryColor(context),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title and Status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.getPrimaryText(context),
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Meta row: Category, Priority, Duration
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (category != null)
                      CategoryChip(category: category, isSelected: true),
                    PriorityBadge(priority: task.priority),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.getSurfaceSecondary(context),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('⏱️ ', style: TextStyle(fontSize: 11)),
                          Text(
                            'مقدر: ${DateTimeUtils.formatDuration(task.estimatedDuration)}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.getSecondaryText(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (task.actualDuration > Duration.zero)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.successLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'مُنجز: ${DateTimeUtils.formatDuration(task.actualDuration)}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.success,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),

                // Description card
                if (task.description != null && task.description!.isNotEmpty) ...[
                  Text(
                    'الوصف والملاحظات',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.getPrimaryText(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.getCardColor(context),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.getBorder(context)),
                    ),
                    child: Text(
                      task.description!,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.getPrimaryText(context),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Subtasks Section
                Text(
                  'الخطوات الفرعية',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.getPrimaryText(context),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.getCardColor(context),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.getBorder(context)),
                  ),
                  child: Column(
                    children: List.generate(_subtasks.length, (idx) {
                      final done = _subtasks[idx];
                      return CheckboxListTile(
                        value: done,
                        onChanged: (val) {
                          setState(() => _subtasks[idx] = val ?? false);
                        },
                        title: Text(
                          _subtaskLabels[idx],
                          style: TextStyle(
                            fontSize: 13,
                            color: done ? AppColors.getMutedText(context) : AppColors.getPrimaryText(context),
                            decoration: done ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        activeColor: AppColors.getPrimaryColor(context),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, __) => const Scaffold(body: Center(child: Text('حدث خطأ'))),
    );
  }
}
