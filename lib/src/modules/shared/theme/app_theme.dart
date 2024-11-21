import 'package:kondus/src/modules/shared/theme/theme_data/colors/app_colors.dart';
import 'package:kondus/src/modules/shared/theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'theme_data/elevated_button/elevated_button_theme_data.dart';
part 'theme_data/text/text_theme_data.dart';
part 'theme_data/colors/color_theme_data.dart';
part 'theme_data/text_field/text_field_theme_data.dart';
part 'theme_data/chip/chip_theme_data.dart';

class AppTheme {
  static ThemeData lightTheme() {
    final baseTheme = ThemeData.light();
    const colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      error: AppColors.error,
      onError: AppColors.onError,
    );

    return baseTheme.copyWith(
      scaffoldBackgroundColor: AppColors.surface,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(baseTheme.textTheme),
      elevatedButtonTheme: _elevatedButtonThemeData(),
      inputDecorationTheme: TextFieldThemeData.lightTheme(colorScheme),
      chipTheme: _chipThemeData(colorScheme),
    );
  }

  static ThemeData darkTheme() {
    final baseTheme = ThemeData.dark();
    const colorScheme = ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkOnSecondary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      error: AppColors.darkError,
      onError: AppColors.darkOnError,
    );

    return baseTheme.copyWith(
      scaffoldBackgroundColor: AppColors.darkSurface,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(baseTheme.textTheme),
      elevatedButtonTheme: _elevatedButtonThemeData(),
      inputDecorationTheme: TextFieldThemeData.darkTheme(colorScheme),
      chipTheme: _chipThemeData(colorScheme),
    );
  }
}
