import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/task.dart';
import '../controllers/tasks_controller.dart';
import '../widgets/category_chip.dart';
import '../widgets/duration_picker.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  const EditTaskScreen({super.key, required this.taskId});
  final String taskId;

  @override
  ConsumerState<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  bool _isInitialized = false;
  late Duration _duration;
  String? _selectedCategoryId;
  late TaskPriority _priority;
  DateTime? _dueDate;
  late PreferredTimeWindow _preferredWindow;
  EnergyLevel? _energyLevel;

  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  void _initFields(Task task) {
    if (_isInitialized) return;
    _titleController.text = task.title;
    _descriptionController.text = task.description ?? '';
    _duration = task.estimatedDuration;
    _selectedCategoryId = task.categoryId;
    _priority = task.priority;
    _dueDate = task.dueDate;
    _preferredWindow = task.preferredTimeWindow;
    _energyLevel = task.energyLevel;
    _isInitialized = true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit(Task originalTask) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final controller = ref.read(tasksControllerProvider);

      // Preserve immutable and execution state
      final updatedTask = originalTask.copyWith(
        title: _titleController.text.trim(),
        estimatedDuration: _duration,
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        categoryId: _selectedCategoryId,
        priority: _priority,
        dueDate: _dueDate,
        preferredTimeWindow: _preferredWindow,
        energyLevel: _energyLevel,
      );

      await controller.updateTask(updatedTask);

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 3)),
    );
    if (picked != null && mounted) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskAsync = ref.watch(taskByIdProvider(widget.taskId));
    final categoriesAsync = ref.watch(categoriesStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: taskAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (task) {
          if (task == null) {
            return const Center(child: Text('Task not found'));
          }

          _initFields(task);

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.priorityHigh.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.priorityHigh.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          color: AppColors.priorityHigh,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: AppColors.priorityHigh,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Title
                TextFormField(
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(labelText: 'Title *'),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Duration Picker
                DurationPickerField(
                  selectedDuration: _duration,
                  onChanged: (d) => setState(() => _duration = d),
                ),
                const SizedBox(height: 22),

                // Category Selection
                const Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                categoriesAsync.when(
                  data: (categories) => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: categories.map((cat) {
                      final isSelected = _selectedCategoryId == cat.id;
                      return CategoryChip(
                        category: cat,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedCategoryId = isSelected ? null : cat.id;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  loading: () => const SizedBox(height: 36),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 22),

                // Priority
                const Text(
                  'Priority',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                SegmentedButton<TaskPriority>(
                  segments: const [
                    ButtonSegment(value: TaskPriority.low, label: Text('Low')),
                    ButtonSegment(
                      value: TaskPriority.medium,
                      label: Text('Medium'),
                    ),
                    ButtonSegment(
                      value: TaskPriority.high,
                      label: Text('High'),
                    ),
                  ],
                  selected: {_priority},
                  onSelectionChanged: (set) =>
                      setState(() => _priority = set.first),
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                // Due Date & Preferred Window Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Due Date',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                            onPressed: _pickDueDate,
                            icon: const Icon(Icons.event_outlined, size: 16),
                            label: Text(
                              _dueDate != null
                                  ? DateTimeUtils.formatHumanDate(_dueDate!)
                                  : 'None',
                              style: TextStyle(
                                fontSize: 13,
                                color: _dueDate != null
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Preferred Time',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<PreferredTimeWindow>(
                            initialValue: _preferredWindow,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            items: PreferredTimeWindow.values.map((w) {
                              final label = switch (w) {
                                PreferredTimeWindow.anytime => 'Any time',
                                PreferredTimeWindow.morning => 'Morning',
                                PreferredTimeWindow.afternoon => 'Afternoon',
                                PreferredTimeWindow.evening => 'Evening',
                              };
                              return DropdownMenuItem(
                                value: w,
                                child: Text(
                                  label,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _preferredWindow = val);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                // Energy Level
                const Text(
                  'Energy Level',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                SegmentedButton<EnergyLevel?>(
                  emptySelectionAllowed: true,
                  segments: const [
                    ButtonSegment(value: EnergyLevel.low, label: Text('Low')),
                    ButtonSegment(
                      value: EnergyLevel.medium,
                      label: Text('Medium'),
                    ),
                    ButtonSegment(value: EnergyLevel.high, label: Text('High')),
                  ],
                  selected: {_energyLevel},
                  onSelectionChanged: (set) =>
                      setState(() => _energyLevel = set.firstOrNull),
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                // Description / Notes
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText: 'Additional details or context...',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 32),

                // Submit Button
                ElevatedButton(
                  onPressed: _isSubmitting ? null : () => _submit(task),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Save Changes'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
