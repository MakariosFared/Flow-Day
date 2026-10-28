import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_time_utils.dart';

class DurationPickerField extends StatelessWidget {
  const DurationPickerField({
    super.key,
    required this.selectedDuration,
    required this.onChanged,
  });

  final Duration selectedDuration;
  final ValueChanged<Duration> onChanged;

  static const List<Duration> presets = [
    Duration(minutes: 15),
    Duration(minutes: 30),
    Duration(minutes: 45),
    Duration(hours: 1),
    Duration(hours: 1, minutes: 30),
    Duration(hours: 2),
    Duration(hours: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'المدة التقديرية *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.getPrimaryText(context),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.getPrimarySubtle(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                DateTimeUtils.formatDuration(selectedDuration),
                style: TextStyle(
                  color: AppColors.getPrimaryColor(context),
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: presets.map((preset) {
            final isSelected = preset == selectedDuration;
            return ChoiceChip(
              label: Text(DateTimeUtils.formatDuration(preset)),
              selected: isSelected,
              onSelected: (_) => onChanged(preset),
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.getPrimaryText(context),
              ),
              selectedColor: AppColors.getPrimaryColor(context),
              backgroundColor: AppColors.getSurfaceSecondary(context),
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.getPrimaryColor(context)
                      : AppColors.getBorder(context),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
