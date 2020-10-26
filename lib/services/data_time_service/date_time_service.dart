import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'i_date_time_service.dart';

class DateTimeService implements IDateTimeService {
  DateTimeService() {
    tz.initializeTimeZones();
    // TODO support other locations http://github.com/srawlins/timezone/issues/50
    tz.setLocalLocation(tz.getLocation('Europe/Berlin'));
  }

  @override
  tz.TZDateTime get localNow => tz.TZDateTime.now(tz.local);
}
