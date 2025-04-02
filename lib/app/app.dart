import 'package:flutter/material.dart';
import 'package:kondus/app/routers/app_routers.dart';
import 'package:kondus/core/providers/navigator/navigator_observer_provider.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/providers/theme/theme_provider.dart';
import 'package:kondus/src/modules/login/presentation/login_page.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:get_it/get_it.dart';

class KondusApp extends StatefulWidget {
  const KondusApp({super.key});

  @override
  State<KondusApp> createState() => _KondusAppState();
}

class _KondusAppState extends State<KondusApp> {
  final ThemeProvider themeProvider = GetIt.instance<ThemeProvider>();

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
          onGenerateRoute: AppRoutes.generateRoute,
          navigatorObservers: [AppNavigatorObserver()],
          navigatorKey: NavigatorProvider.navigatorKey,
          title: 'Kondus',
          home: const LoginPage(),
        );
      },
    );
  }
}
