import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/task.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  final Category category;
  final bool isSelected;
  final VoidCallback? onTap;

  static (Color text, Color bg) getCategoryColors(String name) {
    switch (name.toLowerCase()) {
      case 'work':
      case 'العمل':
        return (AppColors.catWork, AppColors.catWorkBg);
      case 'learning':
      case 'التعلم':
        return (AppColors.catLearning, AppColors.catLearningBg);
      case 'personal':
      case 'شخصي':
      case 'حياة شخصية':
        return (AppColors.catPersonal, AppColors.catPersonalBg);
      case 'health':
      case 'الصحة':
      case 'الصحة والرياضة':
        return (AppColors.catHealth, AppColors.catHealthBg);
      case 'reading':
      case 'القراءة':
        return (AppColors.catReading, AppColors.catReadingBg);
      default:
        return (AppColors.primarySage, AppColors.primarySageSubtle);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = getCategoryColors(category.name);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? colors.$2 : AppColors.getCardColor(context),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(
              color: isSelected ? colors.$1 : AppColors.getBorder(context),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(category.icon, style: const TextStyle(fontSize: 13)),
              const SizedBox(width: 6),
              Text(
                category.nameAr,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? colors.$1 : AppColors.getSecondaryText(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
