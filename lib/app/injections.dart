import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/providers/http/http_provider.dart';
import 'package:kondus/core/providers/http/i_http_provider.dart';
import 'package:kondus/core/providers/theme/theme_provider.dart';
import 'package:kondus/core/repositories/i_token_repository.dart';
import 'package:kondus/core/repositories/token_repository.dart';
import 'package:kondus/core/services/auth/auth_service.dart';
import 'package:kondus/core/services/auth/session_manager.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/src/modules/product_details/product_details_injections.dart';
import 'package:kondus/src/modules/profile/profile_injections.dart';
import 'package:kondus/src/modules/settings/settings_injections.dart';

final getIt = GetIt.instance;

Future<void> initInjections() async {
  final baseUrl = 'http://0.0.0.0:8080';

  log('🔧 Base URL loaded: $baseUrl');

  final themeProvider = await ThemeProvider.getInstance();

  getIt.registerSingleton<ThemeProvider>(themeProvider);

  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  getIt.registerLazySingleton<IHttpProvider>(
    () => HttpProvider(
      baseUrl: baseUrl,
    ),
  );

  getIt.registerLazySingleton<ITokenRepository>(
    () => TokenRepository(storage: getIt()),
  );

  getIt.registerLazySingleton<SessionManager>(
    () => SessionManager(),
  );

  getIt.registerLazySingleton<AuthService>(
    () => AuthService(
      httpProvider: getIt(),
      tokenRepository: getIt(),
      sessionManager: getIt(),
    ),
  );

  getIt.registerLazySingleton<ItemsService>(
    () => ItemsService(
      httpProvider: getIt(),
      tokenRepository: getIt(),
      sessionManager: getIt(),
    ),
  );

  await profileInjections();
  await productDetailsInjections();
  await settingsInjections();
}
