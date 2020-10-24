import 'package:adventskalender/services/i_local_notification_service.dart';
import 'package:adventskalender/services/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ILocalNotificationService _notificationService;
  Future<bool> _initFuture;

  @override
  void initState() {
    super.initState();

    _notificationService = LocalNotificationService(
      onNotificationReceived: (id) async => print(id),
    );
    _initFuture = _init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Adventskalender'),
                  ),
                  body: Center(
                    child: ElevatedButton(
                      child: Text('Trigger Local Notification'),
                      onPressed: () async => await _notificationService.scheduleNotification(
                        id: 0,
                        title: 'Title',
                        body: 'Body',
                        scheduledDate: tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            default:
              return Container();
          }
        });
  }

  Future<bool> _init() async {
    tz.initializeTimeZones();

    await _notificationService.initialize();

    await _notificationService.requestPermissions();

    return true;
  }
}
