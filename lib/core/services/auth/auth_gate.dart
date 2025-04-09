import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/auth/session_manager.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key, required this.child});
  final Widget child;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final StreamSubscription<bool> _sessionSubscription;
  final SessionManager _sessionManager = GetIt.instance<SessionManager>();

  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _sessionSubscription = _sessionManager.isLoggedInStream.listen((isLoggedIn) {
      if (!isLoggedIn && mounted && !_isNavigating) {
        _isNavigating = true;
        Future.microtask(() {
          if (mounted) {
            NavigatorProvider.navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoutes.login,
              (route) => false,
            );
          }
        }).whenComplete(() {
          _isNavigating = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _sessionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
