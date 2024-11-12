part of '../../app_theme.dart';

extension TextFieldThemeExtension on BuildContext {
  InputDecorationTheme get textFieldTheme => Theme.of(this).inputDecorationTheme;

  InputDecoration get textFieldDecoration => InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        filled: textFieldTheme.filled,
        fillColor: textFieldTheme.fillColor,
        labelStyle: textFieldTheme.labelStyle,
        floatingLabelStyle: textFieldTheme.floatingLabelStyle,
        enabledBorder: textFieldTheme.enabledBorder,
        focusedBorder: textFieldTheme.focusedBorder,
        errorBorder: textFieldTheme.errorBorder,
        focusedErrorBorder: textFieldTheme.focusedErrorBorder,
      );

  BorderRadius get textFieldBorderRadius => BorderRadius.circular(16);
  Color get textFieldFillColor => textFieldTheme.fillColor ?? Colors.transparent;
}

class TextFieldThemeData {
  static InputDecorationTheme lightTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: false,
      fillColor: Colors.transparent,
      labelStyle: TextStyle(color: colorScheme.primary),
      floatingLabelStyle: TextStyle(color: colorScheme.primary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Define padding vertical
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
    );
  }

  static InputDecorationTheme darkTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: false,
      fillColor: Colors.transparent,
      labelStyle: TextStyle(color: colorScheme.primary),
      floatingLabelStyle: TextStyle(color: colorScheme.primary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Define padding vertical
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey[600]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
    );
  }
}
