/// A database which stores which windows have been opened
abstract class IOpenedWindowsService {
  /// Returns whether the player has opened window for a given day (1 - 24)
  bool getHasOpenedWindow(int day);

  /// Sets whether the player has opened window for a given day (1 - 24)
  void setHasOpenedWindow(int day);

  /// Initializes the database
  Future<void> initialize();

  /// Resets the database
  Future<void> reset();
}
