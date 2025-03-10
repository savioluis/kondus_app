part of '../../app_theme.dart';

extension ButtonThemeExtension on BuildContext {
  ElevatedButtonThemeData get elevatedButtonTheme => theme.elevatedButtonTheme;
  ButtonStyle get buttonStyle => elevatedButtonTheme.style!;
}

ElevatedButtonThemeData _elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      minimumSize: const Size(double.infinity, 56),
    ).copyWith(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.grey.withOpacity(0.12); // Cinza claro para botões desabilitados
        }
        return AppColors.primary; // Cor primária para botões habilitados
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.grey.withOpacity(0.38); // Cinza para texto desabilitado
        }
        return AppColors.onPrimary; // Cor de contraste para texto habilitado
      }),

      // Certificando-se que a cor de fundo sempre contraste com o texto:
      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.grey.withOpacity(0.2); // Efeito ao pressionar
        }
        return null;
      }),
    ),
  );
}
