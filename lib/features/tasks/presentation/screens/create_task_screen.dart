import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/task.dart';
import '../controllers/tasks_controller.dart';
import '../widgets/category_chip.dart';
import '../widgets/duration_picker.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Duration _duration = const Duration(minutes: 30);
  String? _selectedCategoryId = 'cat-work';
  TaskPriority _priority = TaskPriority.medium;
  DateTime? _dueDate;
  PreferredTimeWindow _preferredWindow = PreferredTimeWindow.anytime;
  EnergyLevel? _energyLevel = EnergyLevel.medium;

  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    final controller = ref.read(tasksControllerProvider);
    controller.createTask(
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تمت إضافة المهمة إلى خطتك بهدوء 🌱'),
        backgroundColor: AppColors.getPrimaryColor(context),
        duration: const Duration(seconds: 2),
      ),
    );

    context.pop();
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
    final categoriesAsync = ref.watch(categoriesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة مهمة جديدة'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title Field
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
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: AppColors.getPrimaryText(context)),
                  decoration: const InputDecoration(
                    hintText: 'ما الذي ترغب بإنجازه اليوم؟',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'يرجى إدخال عنوان المهمة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Description Field
                Text(
                  'ملاحظات وتفاصيل إضافية (اختياري)',
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
                  decoration: const InputDecoration(
                    hintText: 'أضف أي روابط، ملاحظات، أو نقاط فرعية تود تذكرها...',
                  ),
                ),
                const SizedBox(height: 18),

                // Estimated Duration Picker
                DurationPickerField(
                  selectedDuration: _duration,
                  onChanged: (d) => setState(() => _duration = d),
                ),
                const SizedBox(height: 20),

                // Category Selector
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

                // Priority Selector
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
                const SizedBox(height: 20),

                // Due Date
                Text(
                  'تاريخ الاستحقاق',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.getPrimaryText(context),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _pickDueDate,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.getCardColor(context),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.getBorder(context)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today_rounded, size: 18, color: AppColors.getPrimaryColor(context)),
                            const SizedBox(width: 10),
                            Text(
                              _dueDate != null
                                  ? '${_dueDate!.year}-${_dueDate!.month.toString().padLeft(2, '0')}-${_dueDate!.day.toString().padLeft(2, '0')}'
                                  : 'اليوم (افتراضي)',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.getPrimaryText(context),
                              ),
                            ),
                          ],
                        ),
                        if (_dueDate != null)
                          IconButton(
                            icon: const Icon(Icons.close_rounded, size: 16),
                            onPressed: () => setState(() => _dueDate = null),
                          )
                        else
                          Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.getMutedText(context)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Preferred Time Window
                Text(
                  'الفترة المفضلة للإنجاز',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.getPrimaryText(context),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.getCardColor(context),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.getBorder(context)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<PreferredTimeWindow>(
                      value: _preferredWindow,
                      isExpanded: true,
                      dropdownColor: AppColors.getCardColor(context),
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.getPrimaryText(context),
                      ),
                      onChanged: (val) {
                        if (val != null) setState(() => _preferredWindow = val);
                      },
                      items: PreferredTimeWindow.values.map((w) {
                        return DropdownMenuItem(
                          value: w,
                          child: Text(w.labelAr),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Energy Level
                Text(
                  'مستوى الطاقة المطلوب',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.getPrimaryText(context),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: EnergyLevel.values.map((level) {
                    final isSelected = _energyLevel == level;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          avatar: Icon(level.icon, size: 16, color: isSelected ? Colors.white : AppColors.getPrimaryColor(context)),
                          label: Text(level.labelAr, style: const TextStyle(fontSize: 11)),
                          selected: isSelected,
                          onSelected: (_) => setState(() => _energyLevel = level),
                          selectedColor: AppColors.getPrimaryColor(context),
                          backgroundColor: AppColors.getSurfaceSecondary(context),
                          labelStyle: TextStyle(
                            fontSize: 11,
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

                // Submit Button
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.getPrimaryColor(context),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text(
                          'إضافة المهمة إلى الخطة',
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
  }
}
