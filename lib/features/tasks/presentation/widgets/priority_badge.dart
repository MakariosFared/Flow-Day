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
        'High',
        AppColors.priorityHigh,
        const Color(0xFFFFEBEB),
      ),
      TaskPriority.medium => (
        'Medium',
        AppColors.priorityMedium,
        const Color(0xFFFFF4E5),
      ),
      TaskPriority.low => (
        'Low',
        AppColors.priorityLow,
        const Color(0xFFF1F3F5),
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
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}
