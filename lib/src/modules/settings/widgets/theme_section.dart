import 'package:flutter/material.dart';
import 'package:kondus/src/modules/settings/domain/theme_section_viewmodel.dart';
import 'package:kondus/src/modules/settings/widgets/theme_section_content.dart';

import '../../../../app/injections.dart';

class ThemeSection extends StatefulWidget {
  const ThemeSection({super.key});

  @override
  State<ThemeSection> createState() => _ThemeSectionState();
}

class _ThemeSectionState extends State<ThemeSection> {
  final viewmodel = getIt<ThemeSectionViewmodel>();

  @override
  void initState() {
    viewmodel.getInitialTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewmodel.state,
      builder: (context, state, widget) {
        if (state is ChangeThemeErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            state.message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )));
        }

        return switch (state) {
          ThemeSectionEmptyState() => const SizedBox(),
          ThemeSectionContentState(currentTheme: final currentTheme) =>
            ThemeSectionContent(
              currentTheme: currentTheme,
              onTap: (theme) {
                viewmodel.changeTheme(theme);
              },
            )
        };
      },
    );
  }
}
