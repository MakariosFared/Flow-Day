import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/tasks/presentation/screens/create_task_screen.dart';
import '../../features/tasks/presentation/screens/edit_task_screen.dart';
import '../../features/tasks/presentation/screens/task_details_screen.dart';
import '../../features/tasks/presentation/screens/tasks_screen.dart';
import '../theme/app_theme.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/tasks',
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return _AppScaffoldShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/today',
          builder: (context, state) => const _SprintPlaceholderScreen(
            title: 'Today',
            subtitle: 'Timeline & daily plan will arrive in Sprint 3.',
            icon: Icons.calendar_today_rounded,
          ),
        ),
        GoRoute(
          path: '/tasks',
          builder: (context, state) => const TasksScreen(),
        ),
        GoRoute(
          path: '/insights',
          builder: (context, state) => const _SprintPlaceholderScreen(
            title: 'Insights',
            subtitle: 'Productivity statistics will arrive in Sprint 6.',
            icon: Icons.insights_rounded,
          ),
        ),
      ],
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
    return 1;
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
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primaryContainer,
        elevation: 1,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(
              Icons.calendar_today_rounded,
              color: AppColors.primary,
            ),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline_rounded),
            selectedIcon: Icon(
              Icons.check_circle_rounded,
              color: AppColors.primary,
            ),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(
              Icons.insights_rounded,
              color: AppColors.primary,
            ),
            label: 'Insights',
          ),
        ],
      ),
    );
  }
}

class _SprintPlaceholderScreen extends StatelessWidget {
  const _SprintPlaceholderScreen({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: AppColors.textMuted),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
