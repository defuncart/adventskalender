import 'package:adventskalender/models/advent_day.dart';

abstract class IDatabaseService {
  /// Returns a [AdventDay] model for a given day index (expected 1 - 24)
  AdventDay getDay(int day);

  /// Initializes the database
  ///
  /// [dirPath] is a path to a directory where the db should be saved to
  Future<void> initialize(String dirPath);
}
