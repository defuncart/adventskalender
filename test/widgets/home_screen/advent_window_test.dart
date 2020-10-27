import 'package:adventskalender/di_container.dart';
import 'package:adventskalender/services/opened_windows_service/fake_opened_windows_service.dart';
import 'package:adventskalender/widgets/home_screen/advent_day_image.dart';
import 'package:adventskalender/widgets/home_screen/advent_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Ensure widget tree is correct', (tester) async {
    final widget = AdventWindow(
      day: 1,
      width: 100,
      height: 100,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          openedWindowsServiceProvider.overrideWithProvider(Provider((ref) => FakeOpenedWindowsService.all(false))),
        ],
        child: MaterialApp(home: widget),
      ),
    );

    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets('Ensure widget tree is correct', (tester) async {
    final widget = AdventWindow(
      day: 1,
      width: 100,
      height: 100,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          openedWindowsServiceProvider.overrideWithProvider(Provider((ref) => FakeOpenedWindowsService.all(true))),
        ],
        child: MaterialApp(home: widget),
      ),
    );

    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(AdventDayImage), findsOneWidget);
  });

  test('day null value triggers assertion', () {
    expect(
      () => AdventWindow(
        day: null,
        width: 100,
        height: 100,
      ),
      throwsAssertionError,
    );
  });

  test('day invalid value triggers assertion', () {
    expect(
      () => AdventWindow(
        day: -1,
        width: 100,
        height: 100,
      ),
      throwsAssertionError,
    );

    expect(
      () => AdventWindow(
        day: 32,
        width: 100,
        height: 100,
      ),
      throwsAssertionError,
    );
  });

  test('width null value triggers assertion', () {
    expect(
      () => AdventWindow(
        day: 1,
        width: null,
        height: 100,
      ),
      throwsAssertionError,
    );
  });

  test('width invalid value triggers assertion', () {
    expect(
      () => AdventWindow(
        day: 1,
        width: 0,
        height: 100,
      ),
      throwsAssertionError,
    );
  });

  test('height null value triggers assertion', () {
    expect(
      () => AdventWindow(
        day: 1,
        width: 100,
        height: null,
      ),
      throwsAssertionError,
    );
  });

  test('height invalid value triggers assertion', () {
    expect(
      () => AdventWindow(
        day: 1,
        width: 100,
        height: 0,
      ),
      throwsAssertionError,
    );
  });
}
