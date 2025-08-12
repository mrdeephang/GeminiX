import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData get currentTheme {
    // Returns the current theme based on the _isDarkMode flag
    return _isDarkMode ? ThemeData.light() : ThemeData.dark();
  }
}
