import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../controllers/settings_controller.dart';

class LocalSetupScreen extends ConsumerStatefulWidget {
  const LocalSetupScreen({super.key});

  @override
  ConsumerState<LocalSetupScreen> createState() => _LocalSetupScreenState();
}

class _LocalSetupScreenState extends ConsumerState<LocalSetupScreen> {
  final _nameController = TextEditingController(text: 'عمر السيد');
  final _timeController = TextEditingController(text: '09:00 — 17:00');

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : 'عمر السيد';
    ref.read(settingsProvider.notifier).updateProfile(
          name: name,
          availableTime: _timeController.text.trim(),
        );
    context.go('/today');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              // Brand Icon
              Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1B827C), Color(0xFF43AFA2)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'FD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'لنخطط على وتيرتك الهادئة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.getPrimaryText(context),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'ابدأ فورًا — لا حاجة لتسجيل حساب ولا اتصال بالإنترنت.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.getSecondaryText(context),
                ),
              ),
              const SizedBox(height: 28),

              // Name Field
              Text(
                'الاسم أو اللقب',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.getPrimaryText(context),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: TextStyle(color: AppColors.getPrimaryText(context)),
                decoration: const InputDecoration(
                  hintText: 'كيف تحب أن نناديك؟',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
              ),
              const SizedBox(height: 18),

              // Available Time
              Text(
                'ساعات التفرغ المعتادة',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.getPrimaryText(context),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _timeController,
                style: TextStyle(color: AppColors.getPrimaryText(context)),
                decoration: const InputDecoration(
                  hintText: 'مثال: 09:00 — 17:00',
                  prefixIcon: Icon(Icons.access_time_rounded),
                ),
              ),
              const SizedBox(height: 36),

              // Submit Button
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.getPrimaryColor(context),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  'الدخول إلى التطبيق 🌱',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
