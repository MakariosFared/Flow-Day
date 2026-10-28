import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flowday/main.dart';

void main() {
  testWidgets('FlowDay smoke test - renders UI without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FlowDayApp()));
    await tester.pumpAndSettle();

    // Verify app renders Today screen elements
    expect(find.textContaining('صباح الخير'), findsOneWidget);
    expect(find.text('إنجاز اليوم'), findsOneWidget);
    expect(find.text('اليوم'), findsOneWidget);
    expect(find.text('المهام'), findsOneWidget);
  });
}
