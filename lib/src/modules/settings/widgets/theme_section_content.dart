import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ThemeSectionContent extends StatelessWidget {
  final ThemeMode currentTheme;
  final Function(ThemeMode) onTap;
  const ThemeSectionContent({super.key, required this.currentTheme, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Tema", style: context.titleLarge),
      for (final theme in ThemeMode.values)
        GestureDetector(
          onTap: () => onTap(theme),
          child: ListTile(
            title: Text(switch (theme) {
              ThemeMode.system => "Sistema",
              ThemeMode.light => "Claro",
              ThemeMode.dark => "Escuro",
            }),
            leading: Radio(
              value: theme,
              groupValue: currentTheme,
              onChanged: (_) => onTap(theme),
            ),
          ),
        ),
    ]);
  }
}
