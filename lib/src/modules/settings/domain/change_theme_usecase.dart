import 'package:flutter/material.dart';
import 'package:kondus/src/modules/settings/domain/theme_section_viewmodel.dart';

import '../../../../core/providers/theme/theme_provider.dart';

final class ChangeThemeUsecase {
  final Future<ThemeProvider> _themeProvider = ThemeProvider.getInstance();

  Future<ThemeSectionState> call(ThemeMode newTheme, ThemeMode previousTheme) async {
    try{
      final provider = await _themeProvider;
      await provider.setThemeMode(newTheme);
      return ThemeSectionSuccessState(currentTheme: newTheme);
    }catch(_){
      return ChangeThemeErrorState(currentTheme: previousTheme);
    }
  }
}