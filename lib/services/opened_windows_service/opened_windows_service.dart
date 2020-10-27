import 'package:adventskalender/configs/constants.dart' as constants;
import 'package:hive/hive.dart';

import 'i_opened_windows_service.dart';

/// A database which stores which windows have been opened
class OpenedWindowsService implements IOpenedWindowsService {
  /// A box to store objects
  Box<bool> _box;

  /// A name for the box
  static const _boxName = 'windows';

  /// Returns whether the player has opened window for a given day (1 - 24)
  @override
  bool getHasOpenedWindow(int day) => _box.get(day);

  /// Sets whether the player has opened window for a given day (1 - 24)
  @override
  void setHasOpenedWindow(int day) => _box.put(day, true);

  /// Initializes the database
  @override
  Future<void> initialize() async {
    _box ??= await Hive.openBox(_boxName);
    await _ensureDefaultsExist();
  }

  /// Resets the database
  @override
  Future<void> reset() async {
    await _box?.deleteAll(_box?.keys);
    await _ensureDefaultsExist();
  }

  Future<void> _ensureDefaultsExist() async {
    if (_box.keys.isEmpty) {
      for (var i = constants.firstAdventDay; i <= constants.numberDaysAdvent; i++) {
        await _box.put(i, false);
      }
    }
  }
}
