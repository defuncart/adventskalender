import 'package:adventskalender/di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adventskalender'),
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Trigger Local Notification'),
                    onPressed: () async => await context.read(localNotificationServiceProvider).scheduleNotification(
                          id: 0,
                          title: 'Title',
                          body: 'Body',
                          scheduledDate: context.read(dateTimeServiceProvider).localNow.add(const Duration(seconds: 5)),
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
        ));
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
