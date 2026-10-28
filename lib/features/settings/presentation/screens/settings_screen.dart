import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../controllers/settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _showEditNameDialog(BuildContext context, WidgetRef ref, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.getCardColor(context),
        title: Text(
          'تعديل الاسم',
          style: TextStyle(color: AppColors.getPrimaryText(context)),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: TextStyle(color: AppColors.getPrimaryText(context)),
          decoration: const InputDecoration(hintText: 'أدخل اسمك'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                ref.read(settingsProvider.notifier).updateProfile(name: newName);
              }
              Navigator.of(ctx).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.getPrimaryColor(context),
              foregroundColor: Colors.white,
            ),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final isDark = settings.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات (Settings)'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Local Profile Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.getBorder(context)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.getPrimarySubtle(context),
                      border: Border.all(color: AppColors.getPrimaryColor(context), width: 1.5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      settings.userName.isNotEmpty ? settings.userName.characters.first : 'ع',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.getPrimaryColor(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          settings.userName,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.getPrimaryText(context),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ملف محلي على هذا الجهاز 🌱',
                          style: TextStyle(fontSize: 12, color: AppColors.getSecondaryText(context)),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      _showEditNameDialog(context, ref, settings.userName);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: BorderSide(color: AppColors.getBorderMedium(context)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      foregroundColor: AppColors.getPrimaryColor(context),
                    ),
                    child: const Text('تعديل', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Appearance Section
            Text(
              'المظهر والتخصيص',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.getSecondaryText(context),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.getCardColor(context),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.getBorder(context)),
              ),
              child: SwitchListTile(
                title: Text(
                  'الوضع الداكن (Dark Theme)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.getPrimaryText(context),
                  ),
                ),
                subtitle: Text(
                  'ألوان داكنة مريحة للعين في المساء',
                  style: TextStyle(fontSize: 12, color: AppColors.getSecondaryText(context)),
                ),
                secondary: Icon(
                  isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  color: AppColors.getPrimaryColor(context),
                ),
                value: isDark,
                onChanged: (val) {
                  ref.read(settingsProvider.notifier).toggleTheme();
                },
              ),
            ),
            const SizedBox(height: 20),

            // Preferences Section
            Text(
              'تفضيلات الإنتاجية الهادئة',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.getSecondaryText(context),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.getCardColor(context),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.getBorder(context)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.hourglass_top_rounded, color: AppColors.getPrimaryColor(context)),
                    title: Text(
                      'سقف ساعات العمل اليومي',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.getPrimaryText(context)),
                    ),
                    subtitle: Text('الحد الأقصى لتفادي الإرهاق', style: TextStyle(fontSize: 12, color: AppColors.getSecondaryText(context))),
                    trailing: Text(
                      settings.dailyHoursCap,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.getPrimaryColor(context)),
                    ),
                  ),
                  Divider(height: 1, indent: 56, color: AppColors.getBorder(context)),
                  ListTile(
                    leading: Icon(Icons.schedule_rounded, color: AppColors.getPrimaryColor(context)),
                    title: Text(
                      'ساعات التفرغ المتاحة',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.getPrimaryText(context)),
                    ),
                    trailing: Text(
                      settings.availableTime,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.getSecondaryText(context)),
                    ),
                  ),
                  Divider(height: 1, indent: 56, color: AppColors.getBorder(context)),
                  ListTile(
                    leading: Icon(Icons.coffee_rounded, color: AppColors.getPrimaryColor(context)),
                    title: Text(
                      'فترات الاستراحة التلقائية',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.getPrimaryText(context)),
                    ),
                    subtitle: Text('15 دقيقة بعد كل 90 دقيقة تركيز', style: TextStyle(fontSize: 12, color: AppColors.getSecondaryText(context))),
                    trailing: const Text('✓ مفعّل', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.success)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // About & System Info
            Text(
              'عن التطبيق',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.getSecondaryText(context),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.getCardColor(context),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.getBorder(context)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.cloud_off_rounded, color: AppColors.getPrimaryColor(context)),
                    title: Text(
                      'يعمل محليًا بالكامل بدون إنترنت',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.getPrimaryText(context)),
                    ),
                    subtitle: Text('بياناتك محفوظة على جهازك فقط', style: TextStyle(fontSize: 12, color: AppColors.getSecondaryText(context))),
                  ),
                  Divider(height: 1, indent: 56, color: AppColors.getBorder(context)),
                  ListTile(
                    leading: Icon(Icons.info_outline_rounded, color: AppColors.getPrimaryColor(context)),
                    title: Text(
                      'إصدار الواجهة',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.getPrimaryText(context)),
                    ),
                    trailing: const Text(
                      'FlowDay 1.0.0 (UI Edition)',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primarySage),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
