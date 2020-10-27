import 'dart:math';

import 'package:adventskalender/configs/constants.dart' as constants;
import 'package:adventskalender/di_container.dart';
import 'package:adventskalender/widgets/home_screen/advent_day_detail.dart';
import 'package:adventskalender/widgets/home_screen/advent_day_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdventWindow extends StatelessWidget {
  final int day;
  final double width;
  final double height;

  const AdventWindow({
    Key key,
    @required this.day,
    @required this.width,
    @required this.height,
  })  : assert(day != null),
        assert(day >= constants.firstAdventDay && day <= constants.numberDaysAdvent),
        assert(width != null),
        assert(width > 0),
        assert(height != null),
        assert(height > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOpened = context.read(openedWindowsServiceProvider).getHasOpenedWindow(day);

    return GestureDetector(
      child: Container(
        width: width,
        height: height,
        color: isOpened ? Colors.green : Colors.red,
        child: Center(
          child: isOpened
              ? AdventDayImage(
                  day: day,
                  width: width * 0.925,
                  height: height * 0.925,
                )
              : Text(
                  day.toString(),
                  style: TextStyle(
                    fontSize: min(width, height) * 0.35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
      onTap: isOpened ? () => showAdventDayDetail(context, day: day) : null,
    );
  }
}
