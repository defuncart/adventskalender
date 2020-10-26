import 'package:adventskalender/services/data_time_service/date_time_service.dart';
// import 'package:adventskalender/services/data_time_service/fake_date_time_service.dart';
import 'package:adventskalender/services/data_time_service/i_date_time_service.dart';
import 'package:adventskalender/services/database_service/database_service.dart';
import 'package:adventskalender/services/database_service/i_database_service.dart';
import 'package:adventskalender/services/local_notification_service/i_local_notification_service.dart';
import 'package:adventskalender/services/local_notification_service/local_notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localNotificationServiceProvider = Provider<ILocalNotificationService>(
  (_) => LocalNotificationService(
    onNotificationReceived: (id) async => print('id: $id'),
  ),
);

final dateTimeServiceProvider = Provider<IDateTimeService>(
  // (_) => FakeDateTimeService(
  //   day: 2,
  // ),
  (_) => DateTimeService(),
);

final databaseServiceProvider = Provider<IDatabaseService>(
  (_) => DatabaseService(),
);
