import 'package:adventskalender/configs/constants.dart' as constants;
import 'package:adventskalender/widgets/home_screen/advent_window.dart';
import 'package:flutter/material.dart';

class AdventCalendar extends StatelessWidget {
  static const _numberColumns = 4;
  static const _numberRows = 6;
  static const _paddingX = 8.0;
  static const _paddingY = 8.0;

  const AdventCalendar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = (constraints.maxWidth - _paddingX * (_numberColumns - 1)) / _numberColumns;
        final height = (constraints.maxHeight - _paddingY * (_numberRows - 1)) / _numberRows;

        return Wrap(
          spacing: _paddingX,
          runSpacing: _paddingY,
          children: [
            for (var day = constants.firstAdventDay; day <= constants.numberDaysAdvent; day++)
              AdventWindow(
                day: day,
                width: width,
                height: height,
              ),
          ],
        );
      },
    );
  }
}
