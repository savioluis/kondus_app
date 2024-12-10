import 'package:kondus/src/modules/settings/domain/change_theme_usecase.dart';
import 'package:kondus/src/modules/settings/domain/get_configurated_theme_usecase.dart';
import 'package:kondus/src/modules/settings/domain/theme_section_viewmodel.dart';

import '../../../app/injections.dart';

Future settingsInjections() async {
  getIt.registerLazySingleton(() => GetConfiguredThemeUsecase());
  getIt.registerLazySingleton(() => ChangeThemeUsecase());
  getIt.registerLazySingleton(() => ThemeSectionViewmodel(getIt(), getIt()));
}