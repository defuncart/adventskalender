import 'package:adventskalender/services/data_time_service/date_time_service.dart';
// import 'package:adventskalender/services/data_time_service/fake_date_time_service.dart';
import 'package:adventskalender/services/data_time_service/i_date_time_service.dart';
import 'package:adventskalender/services/database_service/database_service.dart';
import 'package:adventskalender/services/database_service/i_database_service.dart';
import 'package:adventskalender/services/local_notification_service/i_local_notification_service.dart';
import 'package:adventskalender/services/local_notification_service/local_notification_service.dart';
import 'package:adventskalender/services/opened_windows_service/fake_opened_windows_service.dart';
import 'package:adventskalender/services/opened_windows_service/i_opened_windows_service.dart';
import 'package:adventskalender/services/user_settings_service/i_users_settings_service.dart';
import 'package:adventskalender/services/user_settings_service/users_settings_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localNotificationServiceProvider = Provider<ILocalNotificationService>(
  (_) => LocalNotificationService(
    onNotificationReceived: (id) async => print('id: $id'),
  ),
);

final dateTimeServiceProvider = Provider<IDateTimeService>(
  // (_) => FakeDateTimeService(
  //   month: 12,
  //   day: 24,
  // ),
  (_) => DateTimeService(),
);

final databaseServiceProvider = Provider<IDatabaseService>(
  (_) => DatabaseService(),
);

final userSettingsServiceProvider = Provider<IUserSettingsService>(
  (_) => UserSettingsService(),
);

final openedWindowsServiceProvider = Provider<IOpenedWindowsService>(
  (_) => FakeOpenedWindowsService(
    days: [
      FOW(1, true),
      FOW(2, true),
      FOW(3, false),
      FOW(4, false),
      FOW(5, false),
      FOW(6, false),
      FOW(7, false),
      FOW(8, false),
      FOW(9, false),
      FOW(10, false),
      FOW(11, false),
      FOW(12, false),
      FOW(13, false),
      FOW(14, false),
      FOW(15, false),
      FOW(16, false),
      FOW(17, false),
      FOW(18, false),
      FOW(19, false),
      FOW(20, false),
      FOW(21, false),
      FOW(22, false),
      FOW(23, false),
      FOW(24, true),
    ],
  ),
  // (_) => FakeOpenedWindowsService.all(false),
  // (_) => OpenedWindowsService(),
);
