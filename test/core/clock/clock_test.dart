import 'package:flutter_test/flutter_test.dart';
import 'package:flowday/core/clock/clock.dart';

void main() {
  group('Clock', () {
    test('SystemClock returns a non-null current time', () {
      const clock = SystemClock();
      final before = DateTime.now();
      final now = clock.now();
      final after = DateTime.now();

      expect(now.isAfter(before) || now.isAtSameMomentAs(before), isTrue);
      expect(now.isBefore(after) || now.isAtSameMomentAs(after), isTrue);
    });

    test('FakeClock allows deterministic time advancement', () {
      final initial = DateTime(2026, 9, 10, 9, 0);
      final fakeClock = FakeClock(initial);

      expect(fakeClock.now(), equals(initial));

      fakeClock.advance(const Duration(minutes: 45));
      expect(fakeClock.now(), equals(DateTime(2026, 9, 10, 9, 45)));

      fakeClock.setTime(DateTime(2026, 9, 11, 12, 0));
      expect(fakeClock.now(), equals(DateTime(2026, 9, 11, 12, 0)));
    });
  });
}
