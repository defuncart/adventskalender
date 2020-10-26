import 'package:timezone/timezone.dart' as tz;

abstract class IDateTimeService {
  tz.TZDateTime get localNow;
}
