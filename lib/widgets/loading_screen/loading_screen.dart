import 'package:adventskalender/di_container.dart';
import 'package:adventskalender/widgets/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<bool> _initFuture;

  @override
  void initState() {
    super.initState();

    _initFuture = _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initFuture,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data) {
            return HomeScreen();
          }

          return Container();
        },
      ),
    );
  }

  Future<bool> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    final db = context.read(databaseServiceProvider);
    await db.initialize(dir.path);

    final _notificationService = context.read(localNotificationServiceProvider);
    await _notificationService.initialize();
    await _notificationService.requestPermissions();

    final userSettingsService = context.read(userSettingsServiceProvider);
    await userSettingsService.initialize();

    final openWindowsService = context.read(openedWindowsServiceProvider);
    await openWindowsService.initialize();

    return true;
  }
}
