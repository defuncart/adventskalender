import 'package:meta/meta.dart';
import 'package:timezone/timezone.dart';

abstract class ILocalNotificationService {
  Future<void> initialize();

  Future<bool> requestPermissions();

  Future<void> scheduleNotification({
    @required int id,
    @required String title,
    @required String body,
    @required TZDateTime scheduledDate,
  });
}
