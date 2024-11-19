part of '../../app_theme.dart';

extension TextThemeExtension on BuildContext {
  TextStyle? get displayLarge => textTheme.displayLarge;
  TextStyle? get displayMedium => textTheme.displayMedium;
  TextStyle? get displaySmall => textTheme.displaySmall;
  TextStyle? get headlineLarge => textTheme.headlineLarge;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineSmall => textTheme.headlineSmall;
  TextStyle? get titleLarge => textTheme.titleLarge;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleSmall => textTheme.titleSmall;
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get bodySmall => textTheme.bodySmall;
  TextStyle? get labelLarge => textTheme.labelLarge;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelSmall => textTheme.labelSmall;
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    displayLarge: _buildTextStyle(base.displayLarge, fontWeight: FontWeight.w900),
    displayMedium: _buildTextStyle(base.displayMedium, fontWeight: FontWeight.w800),
    displaySmall: _buildTextStyle(base.displaySmall, fontWeight: FontWeight.w700),
    headlineLarge: _buildTextStyle(base.headlineLarge, fontWeight: FontWeight.w600),
    headlineMedium: _buildTextStyle(base.headlineMedium, fontWeight: FontWeight.w500),
    headlineSmall: _buildTextStyle(base.headlineSmall, fontWeight: FontWeight.w400),
    titleLarge: _buildTextStyle(base.titleLarge, fontWeight: FontWeight.w700),
    titleMedium: _buildTextStyle(base.titleMedium, fontWeight: FontWeight.w600),
    titleSmall: _buildTextStyle(base.titleSmall, fontWeight: FontWeight.w500),
    bodyLarge: _buildTextStyle(base.bodyLarge, fontWeight: FontWeight.w400),
    bodyMedium: _buildTextStyle(base.bodyMedium, fontWeight: FontWeight.w300),
    bodySmall: _buildTextStyle(base.bodySmall, fontWeight: FontWeight.w200),
    labelLarge: _buildTextStyle(base.labelLarge, fontWeight: FontWeight.w700),
    labelMedium: _buildTextStyle(base.labelMedium, fontWeight: FontWeight.w500),
    labelSmall: _buildTextStyle(base.labelSmall, fontWeight: FontWeight.w300),
  );
}

TextStyle _buildTextStyle(TextStyle? base, {FontWeight? fontWeight, FontStyle fontStyle = FontStyle.normal}) {
  return GoogleFonts.inter(
    textStyle: base,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
  );
}
