import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/task.dart';
import '../controllers/tasks_controller.dart';
import '../widgets/task_empty_state.dart';
import '../widgets/task_list_item.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(filteredTasksProvider);
    final allTasks = ref.watch(tasksNotifierProvider);
    final categoriesAsync = ref.watch(categoriesStreamProvider);
    final currentFilter = ref.watch(taskFilterProvider);
    final controller = ref.read(tasksControllerProvider);

    final categoriesMap = <String, Category>{};
    categoriesAsync.whenData((categories) {
      for (final cat in categories) {
        categoriesMap[cat.id] = cat;
      }
    });

    final totalCount = allTasks.where((t) => t.status != TaskStatus.cancelled).length;
    final filteredTasks = tasksAsync.value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المهام'),
        actions: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.getPrimarySubtle(context),
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: AppColors.getBorder(context), width: 0.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '$totalCount مهام',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.getPrimaryColor(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/tasks/create'),
        backgroundColor: AppColors.getPrimaryColor(context),
        foregroundColor: Colors.white,
        tooltip: 'إضافة مهمة جديدة',
        child: const Icon(Icons.add_rounded, size: 28),
      ),
      body: Column(
        children: [
          // Search input bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.getCardColor(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.getBorder(context)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => ref.read(taskSearchQueryProvider.notifier).state = val,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.getPrimaryText(context),
                ),
                decoration: InputDecoration(
                  hintText: 'ابحث في المهام، التصنيفات، أو الملاحظات...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: AppColors.getMutedText(context),
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 20,
                    color: AppColors.getMutedText(context),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded, size: 16),
                          onPressed: () {
                            _searchController.clear();
                            ref.read(taskSearchQueryProvider.notifier).state = '';
                            setState(() {});
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                ),
              ),
            ),
          ),

          // Horizontal Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: TaskFilter.values.map((filter) {
                final isSelected = filter == currentFilter;
                final count = switch (filter) {
                  TaskFilter.all => allTasks.where((t) => t.status != TaskStatus.cancelled).length,
                  TaskFilter.active => allTasks.where((t) =>
                      t.status == TaskStatus.pending ||
                      t.status == TaskStatus.scheduled ||
                      t.status == TaskStatus.inProgress).length,
                  TaskFilter.inbox => allTasks.where((t) => t.status == TaskStatus.pending).length,
                  TaskFilter.upcoming => allTasks.where((t) =>
                      t.status == TaskStatus.scheduled ||
                      t.status == TaskStatus.inProgress).length,
                  TaskFilter.completed => allTasks.where((t) => t.status == TaskStatus.completed).length,
                };

                return Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: FilterChip(
                    label: Text('${filter.labelAr} ($count)'),
                    selected: isSelected,
                    onSelected: (_) {
                      ref.read(taskFilterProvider.notifier).state = filter;
                    },
                    selectedColor: AppColors.getPrimarySubtle(context),
                    backgroundColor: AppColors.getCardColor(context),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? AppColors.getPrimaryColor(context)
                          : AppColors.getSecondaryText(context),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.getPrimaryColor(context)
                            : AppColors.getBorder(context),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    showCheckmark: false,
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 6),

          // Tasks List
          Expanded(
            child: filteredTasks.isEmpty
                ? TaskEmptyState(
                    message: _searchController.text.isNotEmpty
                        ? 'لا توجد نتائج مطابقة لبحثك'
                        : 'لا توجد مهام في هذا التصنيف',
                    actionLabel: _searchController.text.isEmpty ? 'إضافة مهمة' : null,
                    onAction: _searchController.text.isEmpty
                        ? () => context.push('/tasks/create')
                        : null,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 4, bottom: 80),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      final category = task.categoryId != null ? categoriesMap[task.categoryId] : null;

                      return TaskListItem(
                        task: task,
                        category: category,
                        onTap: () => context.push('/tasks/${task.id}'),
                        onComplete: () => controller.toggleComplete(task.id),
                        onDelete: () => controller.deleteTask(task.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
