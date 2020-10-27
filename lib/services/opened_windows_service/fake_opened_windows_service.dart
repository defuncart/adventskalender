import 'package:adventskalender/configs/constants.dart' as constants;

import 'i_opened_windows_service.dart';

class FOW {
  final int day;
  final bool value;

  const FOW(this.day, this.value);
}

/// A database which stores which windows have been opened
class FakeOpenedWindowsService implements IOpenedWindowsService {
  List<bool> _days;

  FakeOpenedWindowsService({List<FOW> days}) {
    if (days == null || days.isEmpty || days.length > constants.numberDaysAdvent) {
      reset();
    }

    _days = <bool>[];
    for (final day in days) {
      _days.add(day.value);
    }
  }

  FakeOpenedWindowsService.all(bool value) {
    _setAll(value);
  }

  /// Returns whether the player has opened window for a given day (1 - 24)
  @override
  bool getHasOpenedWindow(int day) => _days[day - 1];

  /// Sets whether the player has opened window for a given day (1 - 24)
  @override
  void setHasOpenedWindow(int day) => _days[day - 1] = true;

  /// Initializes the database
  @override
  Future<void> initialize() async {}

  /// Resets the database
  @override
  Future<void> reset() async => _setAll(false);

  void _setAll(bool value) => _days = List.generate(constants.numberDaysAdvent, (index) => value);
}
