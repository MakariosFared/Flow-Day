import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/task.dart';
import '../controllers/tasks_controller.dart';

class BrainDumpScreen extends ConsumerStatefulWidget {
  const BrainDumpScreen({super.key});

  @override
  ConsumerState<BrainDumpScreen> createState() => _BrainDumpScreenState();
}

class _BrainDumpScreenState extends ConsumerState<BrainDumpScreen> {
  final TextEditingController _textController = TextEditingController(
    text: '• كتابة اختبارات خوارزمية تتبع الوقت بهدوء\n• مراجعة مكتبة Riverpod وتحديث المزودات\n• فكرة: تصميم ملخص أسبوعي مرئي',
  );
  bool _isOrganized = false;
  bool _isSaving = false;

  final List<({String title, String duration, String category, Color catColor, Color catBg, TaskPriority priority})> _parsedTasks = [
    (
      title: 'كتابة اختبارات خوارزمية تتبع الوقت بهدوء',
      duration: '45 دقيقة',
      category: 'العمل',
      catColor: AppColors.catWork,
      catBg: AppColors.catWorkBg,
      priority: TaskPriority.high,
    ),
    (
      title: 'مراجعة مكتبة Riverpod وتحديث المزودات',
      duration: '30 دقيقة',
      category: 'التعلم',
      catColor: AppColors.catLearning,
      catBg: AppColors.catLearningBg,
      priority: TaskPriority.medium,
    ),
    (
      title: 'تصميم ملخص أسبوعي مرئي',
      duration: '30 دقيقة',
      category: 'حياة شخصية',
      catColor: AppColors.catPersonal,
      catBg: AppColors.catPersonalBg,
      priority: TaskPriority.low,
    ),
  ];

  void _commitTasks() {
    setState(() => _isSaving = true);
    final controller = ref.read(tasksControllerProvider);

    for (final t in _parsedTasks) {
      controller.createTask(
        title: t.title,
        estimatedDuration: const Duration(minutes: 30),
        priority: t.priority,
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تم تنظيم وحفظ المهام في خطتك بنجاح 🌱'),
        backgroundColor: AppColors.getPrimaryColor(context),
      ),
    );
    context.go('/tasks');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفريغ ذهني (Brain Dump)'),
        actions: [
          TextButton(
            onPressed: () {
              _textController.clear();
              setState(() => _isOrganized = false);
            },
            child: const Text('مسح الكل'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Intro banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.getPrimarySubtle(context),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.getBorder(context)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.spa_rounded, color: AppColors.getPrimaryColor(context), size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'أفرغ ما في ذهنك بحرية ودون قلق بالتنسيق. سيتولى النظام فرزها وتحويلها لمهام قابلة للجدولة.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.getPrimaryText(context),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Multiline Text Area
              Container(
                decoration: BoxDecoration(
                  color: AppColors.getCardColor(context),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.getBorder(context)),
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: 6,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.getPrimaryText(context),
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    hintText: 'اكتب كل ما يدور في ذهنك... مهمة، فكرة، ملاحظة، تذكير...',
                    hintStyle: TextStyle(fontSize: 13, color: AppColors.getMutedText(context)),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.all(14),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Organize Button
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _isOrganized = true);
                },
                icon: const Icon(Icons.auto_awesome_rounded, size: 18),
                label: const Text('تنظيم وتنسيق بالذكاء الاصطناعي ✨'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.getPrimaryColor(context),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(46),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
              const SizedBox(height: 24),

              // Organized Tasks Preview Section
              if (_isOrganized) ...[
                Text(
                  'المهام المستخرجة المقترحة',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.getPrimaryText(context),
                  ),
                ),
                const SizedBox(height: 10),
                for (final item in _parsedTasks) ...[
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.getCardColor(context),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.getBorder(context)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.getPrimaryText(context),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: item.catBg,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      item.category,
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: item.catColor),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '⏱️ ${item.duration}',
                                    style: TextStyle(fontSize: 11, color: AppColors.getSecondaryText(context)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.check_circle_outline_rounded, color: AppColors.getPrimaryColor(context)),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),

                // Save to Tasks Button
                ElevatedButton(
                  onPressed: _isSaving ? null : _commitTasks,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.getPrimaryColor(context),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: _isSaving
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('اعتماد وإضافة المهام إلى الخطة 🌱', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
