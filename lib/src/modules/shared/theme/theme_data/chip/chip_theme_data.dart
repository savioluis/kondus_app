part of '../../app_theme.dart';

ChipThemeData _chipThemeData(ColorScheme colorScheme) {
  return ChipThemeData(
    backgroundColor: colorScheme.surface,
    selectedColor: colorScheme.primary,
    disabledColor: colorScheme.onSurface.withOpacity(0.12),
    labelStyle: TextStyle(color: colorScheme.onSurface),
    secondaryLabelStyle: TextStyle(color: colorScheme.onPrimary),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: colorScheme.onSurface.withOpacity(0.3)),
    ),
  );
}
