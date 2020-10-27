import 'package:adventskalender/configs/constants.dart' as constants;
import 'package:adventskalender/di_container.dart';
import 'package:adventskalender/models/advent_day.dart';
import 'package:adventskalender/widgets/home_screen/advent_day_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdventDayDetail extends StatelessWidget {
  final int day;

  const AdventDayDetail({
    Key key,
    @required this.day,
  })  : assert(day != null),
        assert(day >= constants.firstAdventDay && day <= constants.numberDaysAdvent),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final adventDay = context.read(databaseServiceProvider).getDay(day);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AdventDayImage(
              day: day,
              width: 125,
              height: 125,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                adventDay.title,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          adventDay.description,
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16),
        _CatsValue1Value2(
          adventDay: adventDay,
        ),
      ],
    );
  }
}

// TODO this is dependent on import database
class _CatsValue1Value2 extends StatelessWidget {
  final AdventDay adventDay;

  const _CatsValue1Value2({
    Key key,
    @required this.adventDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Alter:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: 4),
            Text(adventDay.value1),
          ],
        ),
        SizedBox(width: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Geschlecht:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: 4),
            Text(
              adventDay.value2,
            ),
          ],
        ),
      ],
    );
  }
}

void showAdventDayDetail(
  BuildContext context, {
  @required int day,
}) =>
    showDialog(
      context: context,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AdventDayDetail(
            day: day,
          ),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.6),
    );
