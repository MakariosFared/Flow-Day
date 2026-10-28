import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../tasks/presentation/controllers/tasks_controller.dart';

class FocusSessionScreen extends ConsumerStatefulWidget {
  const FocusSessionScreen({super.key, this.taskId});
  final String? taskId;

  @override
  ConsumerState<FocusSessionScreen> createState() => _FocusSessionScreenState();
}

class _FocusSessionScreenState extends ConsumerState<FocusSessionScreen> {
  Timer? _timer;
  int _remainingSeconds = 25 * 60; // 25:00
  final int _totalPlannedSeconds = 25 * 60;
  bool _isRunning = true;
  bool _isSoundOn = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning && _remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _toggleSound() {
    setState(() {
      _isSoundOn = !_isSoundOn;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSoundOn ? 'أصوات الطبيعة الهادئة مفعّلة 🌿' : 'تم كتم الصوت'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addFiveMinutes() {
    setState(() {
      _remainingSeconds += 5 * 60;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تمت إضافة 5 دقائق للجلسة 🌱'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _finishSession(String? taskId) {
    final elapsedSecs = _totalPlannedSeconds - _remainingSeconds;
    final elapsedMins = elapsedSecs > 0 ? (elapsedSecs / 60).round() : 25;

    if (taskId != null) {
      ref.read(tasksControllerProvider).finishFocus(
            taskId,
            Duration(minutes: elapsedMins),
          );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('رائع ومثمر! تم تسجيل $elapsedMins دقيقة تركيز فعلي بنجاح 🌱'),
        backgroundColor: AppColors.getPrimaryColor(context),
      ),
    );
    context.go('/today');
  }

  @override
  Widget build(BuildContext context) {
    final taskAsync = widget.taskId != null ? ref.watch(taskByIdProvider(widget.taskId!)) : null;
    final task = taskAsync?.value;

    final title = task?.title ?? 'جلسة تركيز هادئة وعميقة';
    final progress = (_totalPlannedSeconds - _remainingSeconds) / _totalPlannedSeconds;

    final mins = _remainingSeconds ~/ 60;
    final secs = _remainingSeconds % 60;

    return Scaffold(
      backgroundColor: AppColors.isDark(context) ? AppColors.darkBackground : const Color(0xFFF1F7F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('جلسة تركيز'),
        actions: [
          IconButton(
            icon: Icon(
              _isSoundOn ? Icons.volume_up_rounded : Icons.volume_off_rounded,
              color: _isSoundOn ? AppColors.getPrimaryColor(context) : AppColors.getMutedText(context),
            ),
            tooltip: 'أصوات الطبيعة المريحة',
            onPressed: _toggleSound,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top task title pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.getCardColor(context),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.getBorder(context)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _isRunning ? AppColors.success : AppColors.warning,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.getPrimaryText(context),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Central Circular Timer Widget
              Column(
                children: [
                  SizedBox(
                    width: 240,
                    height: 240,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 230,
                          height: 230,
                          child: CircularProgressIndicator(
                            value: progress.clamp(0.0, 1.0),
                            strokeWidth: 8,
                            backgroundColor: AppColors.getBorder(context),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.getPrimaryColor(context),
                            ),
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -1,
                                color: AppColors.getPrimaryText(context),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _isRunning ? 'تركيز مستمر...' : 'متوقف مؤقتًا',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.getSecondaryText(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton.icon(
                    onPressed: _addFiveMinutes,
                    icon: const Icon(Icons.add_rounded, size: 16),
                    label: const Text('+5 دقائق إضافية'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.getPrimaryColor(context),
                    ),
                  ),
                ],
              ),

              // Bottom Controls
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Play/Pause Floating Action Button
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.getPrimaryColor(context),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primarySage.withValues(alpha: 0.35),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            _isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: _togglePlayPause,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Finish Session Button
                  ElevatedButton(
                    onPressed: () => _finishSession(widget.taskId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.getCardColor(context),
                      foregroundColor: AppColors.getPrimaryText(context),
                      minimumSize: const Size.fromHeight(48),
                      side: BorderSide(color: AppColors.getBorder(context)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'إنهاء الجلسة وتسجيل الإنجاز ✓',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
