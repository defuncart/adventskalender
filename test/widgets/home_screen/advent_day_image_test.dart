import 'package:adventskalender/widgets/home_screen/advent_day_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Ensure widget tree is correct', (tester) async {
    final widget = AdventDayImage(
      day: 1,
      width: 100,
      height: 100,
    );

    await tester.pumpWidget(MaterialApp(home: widget));

    expect(find.byType(SizedBox), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Ensure properties are correct', (tester) async {
    final width = 100.0;
    final height = 100.0;
    final widget = AdventDayImage(
      day: 1,
      width: width,
      height: height,
    );

    await tester.pumpWidget(MaterialApp(home: widget));

    final sizedBoxWidget = tester.firstWidget(find.byType(SizedBox)) as SizedBox;

    expect(sizedBoxWidget.width, width);
    expect(sizedBoxWidget.height, height);
  });

  test('day null value triggers assertion', () {
    expect(
      () => AdventDayImage(
        day: null,
        width: 100,
        height: 100,
      ),
      throwsAssertionError,
    );
  });

  test('day invalid value triggers assertion', () {
    expect(
      () => AdventDayImage(
        day: -1,
        width: 100,
        height: 100,
      ),
      throwsAssertionError,
    );

    expect(
      () => AdventDayImage(
        day: 32,
        width: 100,
        height: 100,
      ),
      throwsAssertionError,
    );
  });

  test('width null value triggers assertion', () {
    expect(
      () => AdventDayImage(
        day: 1,
        width: null,
        height: 100,
      ),
      throwsAssertionError,
    );
  });

  test('width invalid value triggers assertion', () {
    expect(
      () => AdventDayImage(
        day: 1,
        width: 0,
        height: 100,
      ),
      throwsAssertionError,
    );
  });

  test('height null value triggers assertion', () {
    expect(
      () => AdventDayImage(
        day: 1,
        width: 100,
        height: null,
      ),
      throwsAssertionError,
    );
  });

  test('height invalid value triggers assertion', () {
    expect(
      () => AdventDayImage(
        day: 1,
        width: 100,
        height: 0,
      ),
      throwsAssertionError,
    );
  });
}
