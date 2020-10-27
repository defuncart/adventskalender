import 'package:adventskalender/di_container.dart';
import 'package:adventskalender/extensions/i_date_time_service_extensions.dart';
import 'package:adventskalender/localizations.dart';
import 'package:adventskalender/widgets/home_screen/advent_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adventStatusProvider = Provider<AdventStatus>((ref) {
  final dateTimeService = ref.watch(dateTimeServiceProvider);
  return dateTimeService.adventStatus;
});

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Consumer(
              builder: (_, watch, __) {
                switch (watch(adventStatusProvider)) {
                  case AdventStatus.before:
                    return Text(
                      AppLocalizations.homeScreenBeforeAdventLabel,
                      textAlign: TextAlign.center,
                    );
                  case AdventStatus.during:
                    return AdventCalendar();
                  case AdventStatus.after:
                    return Text(
                      AppLocalizations.homeScreenAfterAdventLabel,
                      textAlign: TextAlign.center,
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
