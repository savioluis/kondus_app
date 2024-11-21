import 'package:flutter/material.dart';
import 'package:kondus/app/routers/app_routers.dart';
import 'package:kondus/core/providers/navigator/navigator_observer_provider.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/src/modules/login/presentation/login_page.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

class KondusApp extends StatefulWidget {
  const KondusApp({super.key});

  @override
  State<KondusApp> createState() => _KondusAppState();
}

class _KondusAppState extends State<KondusApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      onGenerateRoute: AppRoutes.generateRoute,
      navigatorObservers: [AppNavigatorObserver()],
      navigatorKey: NavigatorProvider.navigatorKey,
      title: 'Kondus',
      home: const LoginPage(),
    );
  }
}
