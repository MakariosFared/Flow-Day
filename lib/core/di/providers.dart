import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/tasks/presentation/controllers/tasks_controller.dart';
import '../../features/today/domain/entities/schedule_block.dart';

// Schedule blocks mock provider for Day Planner
final scheduleBlocksProvider = Provider<List<ScheduleBlock>>((ref) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  return [
    ScheduleBlock(
      id: 'sb-1',
      date: today,
      start: DateTime(now.year, now.month, now.day, 9, 0),
      end: DateTime(now.year, now.month, now.day, 9, 45),
      type: ScheduleBlockType.task,
      taskId: 'task-1',
      customTitle: 'مراجعة وتحديث Design Tokens والواجهات',
      isCompleted: true,
    ),
    ScheduleBlock(
      id: 'sb-2',
      date: today,
      start: DateTime(now.year, now.month, now.day, 10, 0),
      end: DateTime(now.year, now.month, now.day, 10, 45),
      type: ScheduleBlockType.task,
      taskId: 'task-2',
      customTitle: 'إعادة هيكلة كود التنقل والصفحات التفاعلية',
      isCompleted: false,
    ),
    ScheduleBlock(
      id: 'sb-3',
      date: today,
      start: DateTime(now.year, now.month, now.day, 11, 15),
      end: DateTime(now.year, now.month, now.day, 12, 0),
      type: ScheduleBlockType.task,
      taskId: 'task-3',
      customTitle: 'قراءة فصل في أنماط تصميم Flutter الحديثة',
      isCompleted: false,
    ),
    ScheduleBlock(
      id: 'sb-4',
      date: today,
      start: DateTime(now.year, now.month, now.day, 12, 0),
      end: DateTime(now.year, now.month, now.day, 12, 45),
      type: ScheduleBlockType.breakBlock,
      customTitle: 'استراحة غداء هادئة واستعادة النشاط ☕',
      isCompleted: false,
    ),
    ScheduleBlock(
      id: 'sb-5',
      date: today,
      start: DateTime(now.year, now.month, now.day, 13, 0),
      end: DateTime(now.year, now.month, now.day, 13, 30),
      type: ScheduleBlockType.task,
      taskId: 'task-5',
      customTitle: 'تمرين رياضي ومشي خفيف لاستعادة النشاط',
      isCompleted: true,
    ),
  ];
});

// Complete focus helper function provider
typedef CompleteFocusFn = Future<void> Function(String taskId, [int? minutes]);

final completeFocusProvider = Provider<CompleteFocusFn>((ref) {
  return (String taskId, [int? minutes]) async {
    final controller = ref.read(tasksControllerProvider);
    await controller.finishFocus(
      taskId,
      Duration(minutes: minutes ?? 25),
    );
  };
});
