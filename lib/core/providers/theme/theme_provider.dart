import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider {
  ThemeProvider._internal();

  static const _themeKey = 'themeMode';
  static ThemeProvider? _instance;
  late SharedPreferences _preferences;

  static Future<ThemeProvider> getInstance() async {
    _instance ??= ThemeProvider._internal();
    _instance!._preferences = await SharedPreferences.getInstance();
    return _instance!;
  }

  ThemeMode get themeMode {
    final themeIndex = _preferences.getInt(_themeKey) ?? ThemeMode.system.index;
    return ThemeMode.values[themeIndex];
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _preferences.setInt(_themeKey, themeMode.index);
  }
}
