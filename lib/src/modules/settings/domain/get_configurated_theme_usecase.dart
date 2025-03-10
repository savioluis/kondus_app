import 'package:kondus/src/modules/settings/domain/theme_section_viewmodel.dart';

import '../../../../core/providers/theme/theme_provider.dart';

final class GetConfiguredThemeUsecase {
  final Future<ThemeProvider> _themeProvider = ThemeProvider.getInstance();

  Future<ThemeSectionState> call() async {
    try{
      final theme = (await _themeProvider).value;
      return ThemeSectionSuccessState(currentTheme: theme);
    }catch(_){
      return ThemeSectionEmptyState();
    }
  }
}