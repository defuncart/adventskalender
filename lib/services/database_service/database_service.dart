import 'dart:io';

import 'package:adventskalender/configs/hive_adapter_type.dart';
import 'package:adventskalender/models/advent_day.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import 'i_database_service.dart';

class DatabaseService implements IDatabaseService {
  /// A box to store objects
  Box<AdventDay> _box;

  /// A name for the box
  static const _boxName = 'db';

  /// Returns a [AdventDay] model for a given day index (expected 1 - 24)
  @override
  AdventDay getDay(int day) => _box.getAt(day - 1);

  /// Initializes the database
  ///
  /// [dirPath] is a path to a directory where the db should be saved to
  @override
  Future<void> initialize(String dirPath) async {
    if (!await Hive.isAdapterRegistered(HiveAdapterType.adventDay)) {
      await Hive.registerAdapter(AdventDayAdapter());
    }

    final file = File('$dirPath/$_boxName.hive');
    if (!file.existsSync()) {
      final assetDB = await rootBundle.load('assets/database/$_boxName.hive');
      final bytes = assetDB.buffer.asUint8List(assetDB.offsetInBytes, assetDB.lengthInBytes);
      file.writeAsBytesSync(bytes);
    }

    _box = await Hive.openBox(_boxName);
  }
}
