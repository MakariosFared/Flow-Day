import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/task.dart';

class PriorityBadge extends StatelessWidget {
  const PriorityBadge({
    super.key,
    required this.priority,
    this.compact = false,
  });
  final TaskPriority priority;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final (label, color, bgColor) = switch (priority) {
      TaskPriority.high => (
        'أولوية عالية',
        AppColors.danger,
        AppColors.dangerLight,
      ),
      TaskPriority.medium => (
        'أولوية متوسطة',
        AppColors.warning,
        AppColors.warningLight,
      ),
      TaskPriority.low => (
        'أولوية عادية',
        AppColors.getSecondaryText(context),
        AppColors.getSurfaceSecondary(context),
      ),
    };

    if (compact) {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
