import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/settings/presentation/screens/local_setup_screen.dart';
import '../../features/settings/presentation/screens/onboarding_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/tasks/presentation/screens/braindump_screen.dart';
import '../../features/tasks/presentation/screens/create_task_screen.dart';
import '../../features/tasks/presentation/screens/edit_task_screen.dart';
import '../../features/tasks/presentation/screens/task_details_screen.dart';
import '../../features/tasks/presentation/screens/tasks_screen.dart';
import '../../features/today/presentation/screens/daily_review_screen.dart';
import '../../features/today/presentation/screens/day_planner_screen.dart';
import '../../features/today/presentation/screens/focus_session_screen.dart';
import '../../features/today/presentation/screens/insights_screen.dart';
import '../../features/today/presentation/screens/today_screen.dart';
import '../theme/app_theme.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/today',
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return _AppScaffoldShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/today',
          builder: (context, state) => const TodayScreen(),
        ),
        GoRoute(
          path: '/tasks',
          builder: (context, state) => const TasksScreen(),
        ),
        GoRoute(
          path: '/insights',
          builder: (context, state) => const InsightsScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/planner',
      builder: (context, state) => const DayPlannerScreen(),
    ),
    GoRoute(
      path: '/focus',
      builder: (context, state) => const FocusSessionScreen(),
    ),
    GoRoute(
      path: '/focus/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return FocusSessionScreen(taskId: id);
      },
    ),
    GoRoute(
      path: '/braindump',
      builder: (context, state) => const BrainDumpScreen(),
    ),
    GoRoute(
      path: '/daily-review',
      builder: (context, state) => const DailyReviewScreen(),
    ),
    GoRoute(
      path: '/tasks/create',
      builder: (context, state) => const CreateTaskScreen(),
    ),
    GoRoute(
      path: '/tasks/:id',
      builder: (context, state) {
        final taskId = state.pathParameters['id']!;
        return TaskDetailsScreen(taskId: taskId);
      },
    ),
    GoRoute(
      path: '/tasks/:id/edit',
      builder: (context, state) {
        final taskId = state.pathParameters['id']!;
        return EditTaskScreen(taskId: taskId);
      },
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/setup',
      builder: (context, state) => const LocalSetupScreen(),
    ),
  ],
);

class _AppScaffoldShell extends StatelessWidget {
  const _AppScaffoldShell({required this.child});
  final Widget child;

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/today')) return 0;
    if (location.startsWith('/tasks')) return 1;
    if (location.startsWith('/insights')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/today');
        break;
      case 1:
        context.go('/tasks');
        break;
      case 2:
        context.go('/insights');
        break;
      case 3:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (idx) => _onItemTapped(idx, context),
        backgroundColor: AppColors.getCardColor(context),
        indicatorColor: AppColors.getPrimarySubtle(context),
        elevation: 0,
        height: 66,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.today_outlined),
            selectedIcon: Icon(
              Icons.today_rounded,
              color: AppColors.getPrimaryColor(context),
            ),
            label: 'اليوم',
          ),
          NavigationDestination(
            icon: const Icon(Icons.check_circle_outline_rounded),
            selectedIcon: Icon(
              Icons.check_circle_rounded,
              color: AppColors.getPrimaryColor(context),
            ),
            label: 'المهام',
          ),
          NavigationDestination(
            icon: const Icon(Icons.insights_outlined),
            selectedIcon: Icon(
              Icons.insights_rounded,
              color: AppColors.getPrimaryColor(context),
            ),
            label: 'المؤشرات',
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: Icon(
              Icons.settings_rounded,
              color: AppColors.getPrimaryColor(context),
            ),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }
}
