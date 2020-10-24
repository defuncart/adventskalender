import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:timezone/timezone.dart';

import 'i_local_notification_service.dart';

class LocalNotificationService implements ILocalNotificationService {
  static const _androidAppIconFileName = 'app_icon';
  static const _androidChannelId = 'com.defuncart.adventskalender';
  static const _androidChannelName = 'Daily Notifications';
  static const _androidChannelDescription = 'Daily notifations during Advent.';

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final Future<void> Function(int) _onNotificationReceivedCallback;

  LocalNotificationService({@required Future<void> Function(int) onNotificationReceived})
      : assert(onNotificationReceived != null),
        _onNotificationReceivedCallback = onNotificationReceived;

  @override
  Future<void> initialize() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(_androidAppIconFileName);
    final initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _onSelectNotification,
    );
  }

  @override
  Future<bool> requestPermissions() async => _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  Future<void> _onSelectNotification(String payload) async => await _onNotificationReceived(payload);

  Future<void> _onDidReceiveLocalNotification(int id, String title, String body, String payload) async =>
      await _onNotificationReceived(payload);

  Future<void> _onNotificationReceived(String payload) async {
    if (_onNotificationReceivedCallback != null) {
      final id = int.tryParse(payload);
      if (id != null) {
        await _onNotificationReceivedCallback(id);
      }
    }
  }

  @override
  Future<void> scheduleNotification({
    @required int id,
    @required String title,
    @required String body,
    @required TZDateTime scheduledDate,
  }) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannelId,
          _androidChannelName,
          _androidChannelDescription,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: id.toString(),
    );
  }
}
