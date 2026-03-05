import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String key = 'isDarkMode';
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  ThemeProvider() {
    getTheme();
  }
  setDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);

    _isDarkMode = value;
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(key) ?? false;

    return _isDarkMode;
  }
}
