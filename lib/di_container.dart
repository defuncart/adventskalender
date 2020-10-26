import 'package:adventskalender/services/local_notification_service/i_local_notification_service.dart';
import 'package:adventskalender/services/local_notification_service/local_notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localNotificationServiceProvider = Provider<ILocalNotificationService>(
  (_) => LocalNotificationService(
    onNotificationReceived: (id) async => print('id: $id'),
  ),
);
