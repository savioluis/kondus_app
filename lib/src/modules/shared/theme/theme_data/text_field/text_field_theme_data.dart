part of '../../app_theme.dart';

extension TextFieldThemeExtension on BuildContext {
  InputDecorationTheme get textFieldTheme => theme.inputDecorationTheme;

  InputDecoration get textFieldDecoration => InputDecoration(
        contentPadding: const EdgeInsets.all(18),
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
      contentPadding: const EdgeInsets.all(18),
      hintStyle: TextStyle(fontSize: 16, color: AppColors.lightGrey.withOpacity(0.5)),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(width: 1, color: AppColors.blue),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(width: 1, color: Colors.orange),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(width: 1, color: AppColors.lightGrey),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(
          width: 1,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(width: 1, color: AppColors.error),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(width: 1, color: AppColors.error),
      ),
    );
  }

  static InputDecorationTheme darkTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: false,
      fillColor: Colors.transparent,
      labelStyle: TextStyle(color: colorScheme.primary),
      floatingLabelStyle: TextStyle(color: colorScheme.primary),
      hintStyle: TextStyle(fontSize: 16, color: AppColors.darkLightGrey.withOpacity(0.5)),
      contentPadding: const EdgeInsets.all(18),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(width: 1, color: AppColors.blue),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(width: 1, color: Colors.orange),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(width: 1, color: AppColors.darkLightGrey),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(
          width: 1,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(width: 1, color: AppColors.darkError),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(width: 1, color: AppColors.darkError),
      ),
    );
  }
}
