import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class DayPlannerScreen extends ConsumerStatefulWidget {
  const DayPlannerScreen({super.key});

  @override
  ConsumerState<DayPlannerScreen> createState() => _DayPlannerScreenState();
}

class _DayPlannerScreenState extends ConsumerState<DayPlannerScreen> {
  int _selectedDayIndex = 4; // الأربعاء (اليوم)
  final List<(String dayName, String dayNum)> _days = const [
    ('سبت', '24'),
    ('أحد', '25'),
    ('إثنين', '26'),
    ('ثلاثاء', '27'),
    ('أربعاء', '28'),
    ('خميس', '29'),
    ('جمعة', '30'),
  ];

  void _rebalancePlan() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تمت موازنة فترات الراحة وجدول اليوم بمرونة وهدوء 🌱'),
        backgroundColor: AppColors.getPrimaryColor(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مخطط اليوم الزمني'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'إضافة مهمة للجدول',
            onPressed: () => context.push('/tasks/create'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Horizontal Day Selector Strip
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_days.length, (index) {
                    final isSelected = _selectedDayIndex == index;
                    final day = _days[index];

                    return GestureDetector(
                      onTap: () => setState(() => _selectedDayIndex = index),
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(end: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.getPrimaryColor(context)
                              : AppColors.getCardColor(context),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.getPrimaryColor(context)
                                : AppColors.getBorder(context),
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primarySage.withValues(alpha: 0.25),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              day.$1,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : AppColors.getSecondaryText(context),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              day.$2,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: isSelected ? Colors.white : AppColors.getPrimaryText(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),

              // Capacity Banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.getPrimarySubtle(context),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.getBorderMedium(context)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '5.5س مخطط / 6س كحد أقصى',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.getPrimaryText(context),
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            '✓ 45 دقيقة فترة أمان · الخطة واقعية ومتوازنة',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _rebalancePlan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.getPrimaryColor(context),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('موازنة ذكية', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Visual Timeline Hours Grid Header
              Text(
                'توزيع الساعات والمهام',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.getPrimaryText(context),
                ),
              ),
              const SizedBox(height: 12),

              _HourSlot(
                hour: '09:00',
                child: _ScheduleBlock(
                  title: 'مراجعة وتحديث Design Tokens',
                  durationText: '45 دقيقة',
                  badge: 'العمل',
                  badgeColor: AppColors.catWork,
                  badgeBg: AppColors.catWorkBg,
                  isCompleted: true,
                ),
              ),
              const SizedBox(height: 8),

              _HourSlot(
                hour: '10:00',
                child: _ScheduleBlock(
                  title: 'إعادة هيكلة كود التنقل والواجهات',
                  durationText: '45 دقيقة',
                  badge: 'أولوية عالية',
                  badgeColor: AppColors.danger,
                  badgeBg: AppColors.dangerLight,
                  isHighlighted: true,
                  onTap: () => context.push('/focus'),
                ),
              ),
              const SizedBox(height: 8),

              _HourSlot(
                hour: '11:00',
                child: _ScheduleBlock(
                  title: 'قراءة فصل في أنماط تصميم Flutter',
                  durationText: '45 دقيقة',
                  badge: 'التعلم',
                  badgeColor: AppColors.catLearning,
                  badgeBg: AppColors.catLearningBg,
                  warningText: '⚠️ اقتراح: أخذ استراحة قصيرة بعد الجلسة',
                ),
              ),
              const SizedBox(height: 8),

              // Break Slot
              _HourSlot(
                hour: '12:00',
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.successBorder),
                  ),
                  child: const Row(
                    children: [
                      Text('☕ ', style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Text(
                          'فترة راحة وغداء هادئة ومريحة (45 دقيقة)',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              _HourSlot(
                hour: '13:00',
                child: _ScheduleBlock(
                  title: 'جلسة مشي هادئة ومراجعة خفيفة',
                  durationText: '30 دقيقة',
                  badge: 'الصحة',
                  badgeColor: AppColors.catHealth,
                  badgeBg: AppColors.catHealthBg,
                  isCompleted: true,
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

class _HourSlot extends StatelessWidget {
  const _HourSlot({required this.hour, required this.child});
  final String hour;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 48,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              hour,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.getMutedText(context),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: child),
      ],
    );
  }
}

class _ScheduleBlock extends StatelessWidget {
  const _ScheduleBlock({
    required this.title,
    required this.durationText,
    required this.badge,
    required this.badgeColor,
    required this.badgeBg,
    this.isCompleted = false,
    this.isHighlighted = false,
    this.warningText,
    this.onTap,
  });

  final String title;
  final String durationText;
  final String badge;
  final Color badgeColor;
  final Color badgeBg;
  final bool isCompleted;
  final bool isHighlighted;
  final String? warningText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isHighlighted
                ? (AppColors.isDark(context) ? AppColors.darkPrimarySubtle : AppColors.primarySageTint)
                : AppColors.getCardColor(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHighlighted
                  ? AppColors.getPrimaryColor(context)
                  : AppColors.getBorder(context),
              width: isHighlighted ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
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
                  ),
                  Text(
                    durationText,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.getSecondaryText(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: badgeColor,
                      ),
                    ),
                  ),
                  if (isHighlighted)
                    Row(
                      children: [
                        Text(
                          'اضغط لبدء التركيز',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.getPrimaryColor(context),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.play_circle_fill_rounded,
                          size: 16,
                          color: AppColors.getPrimaryColor(context),
                        ),
                      ],
                    ),
                ],
              ),
              if (warningText != null) ...[
                const SizedBox(height: 6),
                Text(
                  warningText!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.warning,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
