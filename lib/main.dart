import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

void main() => runApp(const ProviderScope(child: FlowDayApp()));

/// Application shell only. Feature screens are intentionally deferred past Sprint 1.
class FlowDayApp extends ConsumerWidget {
  const FlowDayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    title: 'FlowDay',
    theme: appTheme,
    routerConfig: appRouter,
  );
}
