import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ThemeSectionContent extends StatelessWidget {
  final ThemeMode currentTheme;
  final Function(ThemeMode) onTap;
  const ThemeSectionContent({super.key, required this.currentTheme, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tema", style: context.titleLarge),
          const SizedBox(height: 16),
          for (final theme in ThemeMode.values)
            GestureDetector(
              onTap: () => onTap(theme),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio<ThemeMode>(
                      value: theme,
                      groupValue: currentTheme,
                      onChanged: (_) => onTap(theme),
                      activeColor: context.blueColor,
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      switch (theme) {
                        ThemeMode.system => "Sistema",
                        ThemeMode.light => "Claro",
                        ThemeMode.dark => "Escuro",
                      },
                      style: context.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
