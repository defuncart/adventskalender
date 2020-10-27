import 'package:adventskalender/services/data_time_service/i_date_time_service.dart';

enum AdventStatus {
  before,
  during,
  after,
}

extension IDateTimeServiceExtensions on IDateTimeService {
  AdventStatus get adventStatus {
    final month = localNow.month;
    final day = localNow.day;
    if (month < 12) {
      return AdventStatus.before;
    } else if (month == 12 && day > 24) {
      return AdventStatus.after;
    }

    return AdventStatus.during;
  }
}
