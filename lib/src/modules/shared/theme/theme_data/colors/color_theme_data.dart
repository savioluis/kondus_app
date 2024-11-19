part of '../../app_theme.dart';

extension ColorExtension on BuildContext {
  ColorScheme get colorScheme => theme.colorScheme;

  // Cores do tema principal e secundário
  Color get primaryColor => colorScheme.primary;
  Color get onPrimaryColor => colorScheme.onPrimary;
  Color get secondaryColor => colorScheme.secondary;
  Color get onSecondaryColor => colorScheme.onSecondary;

  // Cores do fundo e superfície
  Color get surfaceColor => colorScheme.surface;
  Color get onSurfaceColor => colorScheme.onSurface;

  Color get blueColor => AppColors.blue;
  Color get yellowColor => AppColors.yellow;
  Color get whiteColor => Colors.white;

  // Cores de erro
  Color get errorColor => colorScheme.error;
  Color get onErrorColor => colorScheme.onError;

  // Cores adicionais
  Color get greyColor => AppColors.grey;
  Color get lightGreyColor => AppColors.lightGrey;

  // Métodos utilitários para acessar cores
  Color getBackgroundColor(bool isPrimary) => isPrimary ? primaryColor : secondaryColor;
  Color getForegroundColor(bool isPrimary) => isPrimary ? onPrimaryColor : onSecondaryColor;

  Color getColor(Set<WidgetState> states, {bool isPrimary = true}) {
    if (states.contains(WidgetState.disabled)) {
      return AppColors.grey;
    }
    return isPrimary ? primaryColor : secondaryColor;
  }

  Color getTextColor(Set<WidgetState> states, {bool isPrimary = true}) {
    if (states.contains(WidgetState.disabled)) {
      return AppColors.grey.withOpacity(0.6);
    }
    return isPrimary ? onPrimaryColor : onSecondaryColor;
  }
}
