import 'package:flutter/material.dart';
import 'package:kondus/src/modules/settings/domain/change_theme_usecase.dart';
import 'package:kondus/src/modules/settings/domain/get_configurated_theme_usecase.dart';

final class ThemeSectionViewmodel {
  final GetConfiguredThemeUsecase _getConfiguredThemeUsecase;
  final ChangeThemeUsecase _changeThemeUsecase;

  ThemeSectionViewmodel(
      this._getConfiguredThemeUsecase, this._changeThemeUsecase);

  final ValueNotifier<ThemeSectionState> state =
      ValueNotifier(ThemeSectionEmptyState());

  Future getInitialTheme() async {
    if (state.value is! ThemeSectionEmptyState) return;
    state.value = await _getConfiguredThemeUsecase.call();
  }

  Future changeTheme(ThemeMode newTheme) async {
    if (state.value is! ThemeSectionContentState) return;
    final contentState = state.value as ThemeSectionContentState;

    if (contentState.currentTheme == newTheme) return;

    state.value = await _changeThemeUsecase.call(newTheme,contentState.currentTheme);
  }
}

sealed class ThemeSectionState {}

final class ThemeSectionEmptyState implements ThemeSectionState {}

sealed class ThemeSectionContentState implements ThemeSectionState {
  final ThemeMode currentTheme;

  ThemeSectionContentState({required this.currentTheme});
}

final class ChangeThemeErrorState extends ThemeSectionContentState {
  final String message = "Ocorreu um erro desconhecido ao trocar o tema";
  ChangeThemeErrorState({required currentTheme})
      : super(currentTheme: currentTheme);
}

final class ThemeSectionSuccessState extends ThemeSectionContentState {
  ThemeSectionSuccessState({required currentTheme})
      : super(currentTheme: currentTheme);
}