import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'i_date_time_service.dart';

class FakeDateTimeService implements IDateTimeService {
  final int year;
  final int month;
  final int day;

  FakeDateTimeService({
    this.year = 2020,
    this.month = 12,
    this.day = 1,
  })  : assert(year != null),
        assert(year >= 2020),
        assert(month != null),
        assert(day != null),
        assert(day >= 1 && day <= 31) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Berlin'));
  }

  @override
  tz.TZDateTime get localNow {
    final device = tz.TZDateTime.now(tz.local);
    return tz.TZDateTime(tz.local, year, month, day, device.hour, device.minute, device.second, device.millisecond);
  }
}
