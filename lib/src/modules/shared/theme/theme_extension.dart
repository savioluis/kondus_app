import 'package:flutter/material.dart';
import 'theme_data/chip/chip_theme_extension.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  ChipThemeData get chipTheme => theme.chipTheme;
  ChipThemeExtension? get customChipTheme => theme.extension<ChipThemeExtension>();
}
