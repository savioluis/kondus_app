import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_router.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_observer_provider.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/providers/theme/theme_provider.dart';
import 'package:kondus/core/services/auth/auth_gate.dart';
import 'package:kondus/core/services/auth/session_manager.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KondusApp extends StatefulWidget {
  const KondusApp({super.key});

  @override
  State<KondusApp> createState() => _KondusAppState();
}

class _KondusAppState extends State<KondusApp> {
  final ThemeProvider themeProvider = GetIt.instance<ThemeProvider>();
  final SessionManager sessionManager = GetIt.instance<SessionManager>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeProvider,
      builder: (context, themeMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeMode,
          onGenerateRoute: AppRouter.generateRoute,
          navigatorObservers: [AppNavigatorObserver()],
          navigatorKey: NavigatorProvider.navigatorKey,
          title: 'Kondus',
          home: const InitialPage(),
          builder: (context, child) {
            return AuthGate(child: child!);
          },
        );
      },
    );
  }
}

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _sessionManager = GetIt.instance<SessionManager>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _handleInitialNavigation();
    }, debugLabel: 'initialNavigation');
  }

  Future<void> _handleInitialNavigation() async {
    try {

      final isLoggedIn = await _sessionManager.isLoggedIn();

      String initialRoute;
      RouteArguments? arguments;

      if (isLoggedIn.$1) {
        initialRoute = AppRoutes.home;

        final token = isLoggedIn.$2;
        log('🔐 Current Token: $token');
      } else {
        initialRoute = AppRoutes.login;
      }

      log('🆕 Initial route: $initialRoute');

      if (isLoggedIn.$1) {
        final token = isLoggedIn.$2;
        log('🔐 Current Token: $token');
      }

      await NavigatorProvider.navigateAndRemoveUntil(
        initialRoute,
        arguments: arguments,
      );
    } catch (e, stackTrace) {
      log(
        '🚧 Erro ao determinar a tela inicial',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
