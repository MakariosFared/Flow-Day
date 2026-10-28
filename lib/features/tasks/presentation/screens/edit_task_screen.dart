import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
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

  Duration _duration = const Duration(minutes: 30);
  String? _selectedCategoryId;
  TaskPriority _priority = TaskPriority.medium;
  DateTime? _dueDate;
  PreferredTimeWindow _preferredWindow = PreferredTimeWindow.anytime;
  EnergyLevel? _energyLevel = EnergyLevel.medium;
  bool _initialized = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _initFromTask(Task task) {
    if (_initialized) return;
    _initialized = true;
    _titleController.text = task.title;
    _descriptionController.text = task.description ?? '';
    _duration = task.estimatedDuration;
    _selectedCategoryId = task.categoryId;
    _priority = task.priority;
    _dueDate = task.dueDate;
    _preferredWindow = task.preferredTimeWindow;
    _energyLevel = task.energyLevel;
  }

  void _submit(Task originalTask) {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final updated = originalTask.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isNotEmpty
          ? _descriptionController.text.trim()
          : null,
      estimatedDuration: _duration,
      categoryId: _selectedCategoryId,
      priority: _priority,
      dueDate: _dueDate,
      preferredTimeWindow: _preferredWindow,
      energyLevel: _energyLevel,
      updatedAt: DateTime.now(),
    );

    ref.read(tasksControllerProvider).updateTask(updated);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تم حفظ التعديلات بنجاح 🌱'),
        backgroundColor: AppColors.getPrimaryColor(context),
      ),
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final taskAsync = ref.watch(taskByIdProvider(widget.taskId));
    final categoriesAsync = ref.watch(categoriesStreamProvider);

    return taskAsync.when(
      data: (task) {
        if (task == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('تعديل المهمة')),
            body: const Center(child: Text('المهمة غير موجودة')),
          );
        }

        _initFromTask(task);

        return Scaffold(
          appBar: AppBar(title: const Text('تعديل المهمة')),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'عنوان المهمة *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.getPrimaryText(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _titleController,
                      style: TextStyle(color: AppColors.getPrimaryText(context)),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'يرجى إدخال عنوان المهمة' : null,
                    ),
                    const SizedBox(height: 18),

                    Text(
                      'الملاحظات والتفاصيل',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.getPrimaryText(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      style: TextStyle(color: AppColors.getPrimaryText(context)),
                    ),
                    const SizedBox(height: 18),

                    DurationPickerField(
                      selectedDuration: _duration,
                      onChanged: (d) => setState(() => _duration = d),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'التصنيف',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.getPrimaryText(context),
                      ),
                    ),
                    const SizedBox(height: 10),
                    categoriesAsync.when(
                      data: (categories) => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: categories.map((cat) {
                          final isSelected = _selectedCategoryId == cat.id;
                          return CategoryChip(
                            category: cat,
                            isSelected: isSelected,
                            onTap: () => setState(() {
                              _selectedCategoryId = isSelected ? null : cat.id;
                            }),
                          );
                        }).toList(),
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'مستوى الأولوية',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.getPrimaryText(context),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: TaskPriority.values.map((p) {
                        final isSelected = _priority == p;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              label: Center(child: Text(p.labelAr)),
                              selected: isSelected,
                              onSelected: (_) => setState(() => _priority = p),
                              selectedColor: AppColors.getPrimaryColor(context),
                              backgroundColor: AppColors.getSurfaceSecondary(context),
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? Colors.white : AppColors.getPrimaryText(context),
                              ),
                              showCheckmark: false,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: isSelected ? AppColors.getPrimaryColor(context) : AppColors.getBorder(context),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),

                    ElevatedButton(
                      onPressed: _isSubmitting ? null : () => _submit(task),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.getPrimaryColor(context),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Text(
                        'حفظ التعديلات',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, __) => const Scaffold(body: Center(child: Text('حدث خطأ'))),
    );
  }
}
