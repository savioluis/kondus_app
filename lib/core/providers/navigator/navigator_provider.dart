import 'package:flutter/material.dart';

class NavigatorProvider {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Método para navegação simples com nome da rota
  static Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  // Método para substituir a rota atual com uma nova rota
  static Future<dynamic> replaceWith(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  // Método para remover todas as rotas anteriores e navegar para a nova
  static Future<dynamic> navigateAndRemoveUntil(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false, // Remove todas as rotas anteriores
      arguments: arguments,
    );
  }

  // Método para voltar para a página anterior
  static void goBack() {
    return navigatorKey.currentState!.pop();
  }

  // Método para voltar com um resultado
  static void goBackWithResult(dynamic result) {
    return navigatorKey.currentState!.pop(result);
  }
}
