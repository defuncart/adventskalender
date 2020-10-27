import 'package:adventskalender/configs/constants.dart' as constants;
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
    if (month < constants.adventMonth) {
      return AdventStatus.before;
    } else if (month == constants.adventMonth && day > constants.numberDaysAdvent) {
      return AdventStatus.after;
    }

    return AdventStatus.during;
  }
}
