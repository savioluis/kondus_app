import 'package:flutter/material.dart';

import '../../../../core/providers/theme/theme_provider.dart';

final class ChangeThemeUsecase{
  final Future<ThemeProvider> _themeProvider = ThemeProvider.getInstance();

  Future call(ThemeMode newTheme) async{
    final provider = await _themeProvider;
    await provider.setThemeMode(newTheme);
  }
}