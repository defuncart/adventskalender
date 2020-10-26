import 'package:adventskalender/models/advent_day.dart';

abstract class IDatabaseService {
  /// Returns a [AdventDay] model for a given day index (expected 1 - 24)
  AdventDay getDay(int day);

  /// Initializes the database
  Future<void> initialize();
}
