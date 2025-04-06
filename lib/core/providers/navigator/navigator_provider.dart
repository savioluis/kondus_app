import 'package:flutter/material.dart';

class NavigatorProvider {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> replaceWith(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateAndRemoveUntil(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false, 
      arguments: arguments,
    );
  }

  static void goBack() {
    return navigatorKey.currentState!.pop();
  }

  static void goBackWithResult(dynamic result) {
    return navigatorKey.currentState!.pop(result);
  }
}
