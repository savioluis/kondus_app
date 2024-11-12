import 'package:flutter/material.dart';

class ChipThemeExtension extends ThemeExtension<ChipThemeExtension> {
  ChipThemeExtension({
    required this.defaultBackgroundColor,
    required this.selectedBackgroundColor,
    required this.defaultLabelColor,
    required this.selectedLabelColor,
    required this.defaultBorderColor,
    required this.selectedBorderColor,
  });

  final Color defaultBackgroundColor;
  final Color selectedBackgroundColor;
  final Color defaultLabelColor;
  final Color selectedLabelColor;
  final Color defaultBorderColor;
  final Color selectedBorderColor;

  @override
  ChipThemeExtension copyWith({
    Color? defaultBackgroundColor,
    Color? selectedBackgroundColor,
    Color? defaultLabelColor,
    Color? selectedLabelColor,
    Color? defaultBorderColor,
    Color? selectedBorderColor,
  }) {
    return ChipThemeExtension(
      defaultBackgroundColor: defaultBackgroundColor ?? this.defaultBackgroundColor,
      selectedBackgroundColor: selectedBackgroundColor ?? this.selectedBackgroundColor,
      defaultLabelColor: defaultLabelColor ?? this.defaultLabelColor,
      selectedLabelColor: selectedLabelColor ?? this.selectedLabelColor,
      defaultBorderColor: defaultBorderColor ?? this.defaultBorderColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
    );
  }

  @override
  ThemeExtension<ChipThemeExtension> lerp(ThemeExtension<ChipThemeExtension>? other, double t) {
    if (other is! ChipThemeExtension) return this;
    return ChipThemeExtension(
      defaultBackgroundColor: Color.lerp(defaultBackgroundColor, other.defaultBackgroundColor, t)!,
      selectedBackgroundColor:
          Color.lerp(selectedBackgroundColor, other.selectedBackgroundColor, t)!,
      defaultLabelColor: Color.lerp(defaultLabelColor, other.defaultLabelColor, t)!,
      selectedLabelColor: Color.lerp(selectedLabelColor, other.selectedLabelColor, t)!,
      defaultBorderColor: Color.lerp(defaultBorderColor, other.defaultBorderColor, t)!,
      selectedBorderColor: Color.lerp(selectedBorderColor, other.selectedBorderColor, t)!,
    );
  }
}
