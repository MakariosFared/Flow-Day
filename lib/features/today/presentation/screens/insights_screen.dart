import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';

class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen> {
  int _selectedPeriod = 0; // 0 = هذا الأسبوع, 1 = هذا الشهر

  final List<({String day, double height, bool isToday})> _weekBars = const [
    (day: 'السبت', height: 0.65, isToday: false),
    (day: 'الأحد', height: 0.80, isToday: false),
    (day: 'الإثنين', height: 0.90, isToday: false),
    (day: 'الثلاثاء', height: 0.45, isToday: false),
    (day: 'الأربعاء', height: 0.70, isToday: true),
    (day: 'الخميس', height: 0.20, isToday: false),
    (day: 'الجمعة', height: 0.10, isToday: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المؤشرات الهادئة (Insights)'),
        actions: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.getSurfaceSecondary(context),
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: AppColors.getBorder(context)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_rounded, size: 12, color: AppColors.success),
                const SizedBox(width: 4),
                Text(
                  'محدّث',
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Period Selector Tabs
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.getSurfaceSecondary(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedPeriod = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: _selectedPeriod == 0 ? AppColors.getCardColor(context) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: _selectedPeriod == 0
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'هذا الأسبوع',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: _selectedPeriod == 0 ? FontWeight.w700 : FontWeight.w500,
                              color: _selectedPeriod == 0 ? AppColors.getPrimaryText(context) : AppColors.getSecondaryText(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedPeriod = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: _selectedPeriod == 1 ? AppColors.getCardColor(context) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: _selectedPeriod == 1
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'هذا الشهر',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: _selectedPeriod == 1 ? FontWeight.w700 : FontWeight.w500,
                              color: _selectedPeriod == 1 ? AppColors.getPrimaryText(context) : AppColors.getSecondaryText(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Weekly Bar Chart Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.getCardColor(context),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.getBorder(context)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ساعات التركيز اليومية',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.getPrimaryText(context),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'متوسط 3.2 ساعة تركيز هادئ يوميًا',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.getSecondaryText(context),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.successLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '+12% استقرار',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.success,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Bar Chart
                    SizedBox(
                      height: 140,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _weekBars.map((item) {
                          final barHeight = 100 * item.height;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 22,
                                height: barHeight,
                                decoration: BoxDecoration(
                                  color: item.isToday
                                      ? AppColors.getPrimaryColor(context)
                                      : (AppColors.isDark(context)
                                          ? AppColors.darkPrimarySubtle
                                          : AppColors.primarySageSubtle),
                                  borderRadius: BorderRadius.circular(6),
                                  border: item.isToday
                                      ? Border.all(color: AppColors.getPrimaryColor(context), width: 1.5)
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item.day,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: item.isToday ? FontWeight.w700 : FontWeight.w500,
                                  color: item.isToday
                                      ? AppColors.getPrimaryColor(context)
                                      : AppColors.getSecondaryText(context),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // KPI Row Cards
              Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      icon: Icons.timer_outlined,
                      iconColor: AppColors.getPrimaryColor(context),
                      title: 'إجمالي التركيز',
                      value: '18.5 س',
                      subtitle: 'على مدار الأسبوع',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MetricCard(
                      icon: Icons.check_circle_outline_rounded,
                      iconColor: AppColors.success,
                      title: 'مهام مكتملة',
                      value: '22 مهمة',
                      subtitle: 'بدون أي تأجيل قسري',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Category Distribution Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.getCardColor(context),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.getBorder(context)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'توزيع الوقت حسب التصنيف',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.getPrimaryText(context),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _CategoryBar(
                      name: 'العمل (Work)',
                      percent: 0.55,
                      hoursText: '10.2 ساعة',
                      color: AppColors.catWork,
                    ),
                    const SizedBox(height: 10),
                    _CategoryBar(
                      name: 'التعلم (Learning)',
                      percent: 0.25,
                      hoursText: '4.6 ساعة',
                      color: AppColors.catLearning,
                    ),
                    const SizedBox(height: 10),
                    _CategoryBar(
                      name: 'الصحة (Health)',
                      percent: 0.12,
                      hoursText: '2.2 ساعة',
                      color: AppColors.catHealth,
                    ),
                    const SizedBox(height: 10),
                    _CategoryBar(
                      name: 'حياة شخصية (Personal)',
                      percent: 0.08,
                      hoursText: '1.5 ساعة',
                      color: AppColors.catPersonal,
                    ),
                  ],
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

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.getCardColor(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.getBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.getPrimaryText(context),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.getSecondaryText(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.getMutedText(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({
    required this.name,
    required this.percent,
    required this.hoursText,
    required this.color,
  });

  final String name;
  final double percent;
  final String hoursText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.getPrimaryText(context),
              ),
            ),
            Text(
              hoursText,
              style: TextStyle(
                fontSize: 11,
                color: AppColors.getSecondaryText(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: percent,
          minHeight: 6,
          backgroundColor: AppColors.getSurfaceSecondary(context),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
