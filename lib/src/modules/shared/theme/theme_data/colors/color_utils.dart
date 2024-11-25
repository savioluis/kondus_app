import 'package:flutter/material.dart';

class ColorUtils {
  /// Gera cores próximas a uma cor base.
  static List<Color> generateNearbyColors({
    required Color baseColor,
    int count = 5,
    double hueShift = 10.0,
    double saturationFactor = 0.9,
    double lightnessFactor = 0.9,
  }) {
    final hslBase = HSLColor.fromColor(baseColor);
    return List<Color>.generate(count, (index) {
      final shift = (index - count ~/ 2) * hueShift;
      return hslBase
          .withHue((hslBase.hue + shift) % 360)
          .withSaturation(
              (hslBase.saturation * saturationFactor).clamp(0.0, 1.0))
          .withLightness((hslBase.lightness * lightnessFactor).clamp(0.0, 1.0))
          .toColor();
    });
  }

  static List<Color> generateTonalColors({
    required Color baseColor,
    int count = 5,
    double saturationRange = 0.3, // Fator de variação para saturação
    double lightnessRange = 0.05, // Fator de variação para luminosidade
  }) {
    // Converter a cor base para HSL
    final hslBase = HSLColor.fromColor(baseColor);

    return List<Color>.generate(count, (index) {
      // Distribuir as variações uniformemente
      final factor = (index - count ~/ 2) / (count ~/ 2);
      return hslBase
          .withSaturation(
              (hslBase.saturation + factor * saturationRange).clamp(0.0, 1.0))
          .withLightness(
              (hslBase.lightness + factor * lightnessRange).clamp(0.0, 1.0))
          .toColor();
    });
  }

  /// Gera cores com base no tema (usando o contexto).
  static List<Color> generateThemeColors(BuildContext context,
      {int count = 5}) {
    final primaryColor = Theme.of(context).primaryColor;
    return generateNearbyColors(
      baseColor: primaryColor,
      count: count,
      hueShift: 5.0,
      saturationFactor: 0.8,
      lightnessFactor: 0.9,
    );
  }
}
