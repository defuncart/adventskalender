import 'package:adventskalender/configs/constants.dart' as constants;
import 'package:flutter/material.dart';

class AdventDayImage extends StatelessWidget {
  final int day;
  final double width;
  final double height;

  const AdventDayImage({
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
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        'assets/database/$day.jpeg',
        fit: BoxFit.cover,
      ),
    );
  }
}
