import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/presentation/controllers/tasks_controller.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksStreamProvider);
    final settings = ref.watch(settingsProvider);
    final scheduleBlocks = ref.watch(scheduleBlocksProvider);

    final allTasks = tasksAsync.value ?? [];
    final activeTasks = allTasks.where((t) => t.status != TaskStatus.cancelled).toList();
    final completedTasks = activeTasks.where((t) => t.status == TaskStatus.completed).toList();
    final inProgressTasks = activeTasks.where((t) => t.status == TaskStatus.inProgress).toList();
    final pendingTasks = activeTasks.where((t) => t.status == TaskStatus.pending || t.status == TaskStatus.scheduled).toList();

    final totalActive = activeTasks.length;
    final totalCompleted = completedTasks.length;
    final progressRatio = totalActive > 0 ? (totalCompleted / totalActive) : 0.0;
    final progressPercentage = (progressRatio * 100).toInt();

    // Select hero focus task: in-progress first, then highest priority pending/scheduled
    final Task? heroTask = inProgressTasks.isNotEmpty
        ? inProgressTasks.first
        : (pendingTasks.isNotEmpty ? pendingTasks.first : (activeTasks.isNotEmpty ? activeTasks.first : null));

    // Calculate total actual logged focus time
    var totalLoggedMinutes = 0;
    for (final t in activeTasks) {
      totalLoggedMinutes += t.actualDuration.inMinutes;
    }
    final loggedDisplay = totalLoggedMinutes > 0
        ? '${totalLoggedMinutes ~/ 60}س ${totalLoggedMinutes % 60}د'
        : '1س 15د';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header & Greeting
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.push('/settings'),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.getPrimarySubtle(context),
                            border: Border.all(
                              color: AppColors.getPrimaryColor(context),
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            settings.userName.isNotEmpty ? settings.userName.characters.first : 'ع',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.getPrimaryColor(context),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'صباح الخير يا ${settings.userName}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.getPrimaryText(context),
                              ),
                            ),
                            Text(
                              'دعنا نخطط على وتيرتك الهادئة 🌱',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.getSecondaryText(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Sync status pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.getSurfaceSecondary(context),
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: AppColors.getBorder(context)),
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
                          'محفوظ محليًا',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.getSecondaryText(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Daily Progress Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.getCardColor(context),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.getBorder(context)),
                ),
                child: Row(
                  children: [
                    // Circular Progress
                    SizedBox(
                      width: 68,
                      height: 68,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: totalActive > 0 ? progressRatio : 0.5,
                            strokeWidth: 6,
                            backgroundColor: AppColors.getBorder(context),
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.getPrimaryColor(context)),
                            strokeCap: StrokeCap.round,
                          ),
                          Text(
                            totalActive > 0 ? '$progressPercentage%' : '50%',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.getPrimaryText(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'إنجاز اليوم',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.getPrimaryText(context),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            totalActive > 0
                                ? 'أكملت $totalCompleted من $totalActive مهام'
                                : 'أكملت 2 من 4 مهام مخطط لها',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.getSecondaryText(context),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.successLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.timer_outlined, size: 12, color: AppColors.success),
                                const SizedBox(width: 4),
                                Text(
                                  '$loggedDisplay تركيز مُسجّل',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Sage Hero Focus Card
              if (heroTask != null) ...[
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF176B68), Color(0xFF0D3D3B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primarySage.withValues(alpha: 0.28),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFA8DADC),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'التالي للتركيز',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'العمل',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        heroTask.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            '⏱️ ${DateTimeUtils.formatDuration(heroTask.estimatedDuration)} تقديري',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                          Text(
                            '  •  ${heroTask.priority.labelAr}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.push('/focus/${heroTask.id}');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primarySage,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          minimumSize: const Size.fromHeight(42),
                        ),
                        icon: const Icon(Icons.play_arrow_rounded, size: 20),
                        label: const Text(
                          'ابدأ جلسة التركيز',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Schedule Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'جدول اليوم الزمني',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.getPrimaryText(context),
                    ),
                  ),
                  InkWell(
                    onTap: () => context.push('/planner'),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        'عرض المخطط كامل ›',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.getPrimaryColor(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Timeline Schedule Cards
              for (final block in scheduleBlocks.take(3)) ...[
                _TimelineCard(
                  time: '${block.start.hour.toString().padLeft(2, '0')}:${block.start.minute.toString().padLeft(2, '0')}\n${block.end.hour.toString().padLeft(2, '0')}:${block.end.minute.toString().padLeft(2, '0')}',
                  title: block.customTitle ?? (heroTask?.title ?? 'جلسة عمل وتركيز'),
                  isCompleted: block.isCompleted,
                  isActiveNow: !block.isCompleted && block.taskId == 'task-2',
                  badges: [
                    if (block.isCompleted)
                      _Badge(label: '✓ مكتمل', color: AppColors.success, bg: AppColors.successLight)
                    else if (block.taskId == 'task-2') ...[
                      _Badge(label: 'أولوية عالية', color: AppColors.danger, bg: AppColors.dangerLight),
                      _Badge(label: '⚡ جاري الآن', color: AppColors.primarySage, bg: AppColors.primarySageSubtle),
                    ] else
                      _Badge(label: 'التعلم', color: AppColors.catLearning, bg: AppColors.catLearningBg),
                  ],
                  onTap: () {
                    if (block.taskId != null) {
                      context.push('/tasks/${block.taskId}');
                    }
                  },
                ),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 10),

              // Quick Capture / Brain Dump trigger
              InkWell(
                onTap: () => context.push('/braindump'),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.getCardColor(context),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.getBorderMedium(context),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.edit_note_rounded, color: AppColors.getPrimaryColor(context), size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'تفريغ ذهني سريع... (أفكار، مهام دون ضغط)',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.getSecondaryText(context),
                          ),
                        ),
                      ),
                      Icon(Icons.add_circle_outline_rounded, color: AppColors.getPrimaryColor(context), size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Review Today Button
              OutlinedButton.icon(
                onPressed: () => context.push('/daily-review'),
                icon: Icon(Icons.nightlight_round, size: 16, color: AppColors.getPrimaryColor(context)),
                label: const Text('مراجعة اليوم بهدوء'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                  side: BorderSide(color: AppColors.getBorderMedium(context)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  foregroundColor: AppColors.getPrimaryColor(context),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.time,
    required this.title,
    required this.badges,
    this.isCompleted = false,
    this.isActiveNow = false,
    required this.onTap,
  });

  final String time;
  final String title;
  final List<Widget> badges;
  final bool isCompleted;
  final bool isActiveNow;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isActiveNow
                ? (AppColors.isDark(context) ? AppColors.darkPrimarySubtle : AppColors.primarySageTint)
                : AppColors.getCardColor(context),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isActiveNow ? AppColors.getPrimaryColor(context) : AppColors.getBorder(context),
              width: isActiveNow ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                time,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                  color: isCompleted
                      ? AppColors.getMutedText(context)
                      : (isActiveNow ? AppColors.getPrimaryColor(context) : AppColors.getPrimaryText(context)),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 3,
                height: 40,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppColors.success
                      : (isActiveNow ? AppColors.getPrimaryColor(context) : AppColors.getBorder(context)),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isCompleted
                            ? AppColors.getMutedText(context)
                            : AppColors.getPrimaryText(context),
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: badges,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.getMutedText(context),
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color, required this.bg});
  final String label;
  final Color color;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
