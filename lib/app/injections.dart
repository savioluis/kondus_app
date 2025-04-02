import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:kondus/core/providers/http/http_provider.dart';
import 'package:kondus/core/providers/http/i_http_provider.dart';
import 'package:kondus/core/providers/theme/theme_provider.dart';
import 'package:kondus/src/modules/history/history_injections.dart';
import 'package:kondus/src/modules/product_details/product_details_injections.dart';
import 'package:kondus/src/modules/profile/profile_injections.dart';
import 'package:kondus/src/modules/settings/settings_injections.dart';

final getIt = GetIt.instance;

Future<void> initInjections() async {
  final baseUrl = 'https://jsonplaceholder.typicode.com';

  log('🔧 Base URL loaded: $baseUrl');

  final themeProvider = await ThemeProvider.getInstance();

  getIt.registerSingleton<ThemeProvider>(themeProvider);

  getIt.registerLazySingleton<IHttpProvider>(
    () => HttpProvider(
      baseUrl: baseUrl,
    ),
  );

  await historyInjections();
  await profileInjections();
  await productDetailsInjections();
  await settingsInjections();
}
