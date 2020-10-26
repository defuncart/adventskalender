import 'package:adventskalender/di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _initFuture;

  @override
  void initState() {
    super.initState();

    _initFuture = _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adventskalender'),
      ),
      body: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data) {
                return Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text('Trigger Local Notification'),
                            onPressed: () async =>
                                await context.read(localNotificationServiceProvider).scheduleNotification(
                                      id: 0,
                                      title: 'Title',
                                      body: 'Body',
                                      scheduledDate: context
                                          .read(dateTimeServiceProvider)
                                          .localNow
                                          .add(const Duration(seconds: 5)),
                                    ),
                          ),
                          ElevatedButton(
                              child: Text('View db'),
                              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => _DB()))),
                        ],
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(context.read(dateTimeServiceProvider).localNow.toString()),
                      ),
                    )
                  ],
                );
              }
              return Container();
            default:
              return Container();
          }
        },
      ),
    );
  }

  Future<bool> _init() async {
    final db = context.read(databaseServiceProvider);
    await db.initialize();

    final _notificationService = context.read(localNotificationServiceProvider);
    await _notificationService.initialize();
    await _notificationService.requestPermissions();

    return true;
  }
}

class _DB extends StatelessWidget {
  const _DB({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, watch, child) {
          final dbService = watch(databaseServiceProvider);

          return ListView.builder(
            itemCount: 24,
            itemBuilder: (_, index) {
              final dayIndex = index + 1;
              final adventDay = dbService.getDay(dayIndex);

              return ListTile(
                leading: Image.asset('assets/database/$dayIndex.jpeg'),
                title: Text(adventDay.title),
                subtitle: Text(adventDay.description),
              );
            },
          );
        },
      ),
    );
  }
}
