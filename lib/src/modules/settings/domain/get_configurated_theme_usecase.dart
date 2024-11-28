import 'package:flutter/material.dart';

import '../../../../core/providers/theme/theme_provider.dart';

final class GetConfiguredThemeUsecase{
    final Future<ThemeProvider> _themeProvider = ThemeProvider.getInstance();

    Future<ThemeMode> call() async{
        return (await _themeProvider).themeMode;
    }
}