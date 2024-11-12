import 'dart:developer';
import 'package:flutter/material.dart';

class AppNavigatorObserver extends NavigatorObserver {
  // Esse método é chamado quando uma nova rota é empurrada para a stack de navegação
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    log('PUSH: ${route.settings.name}');
    // Aqui você pode fazer algo quando uma nova rota é acessada
  }

  // Esse método é chamado quando uma rota existente é removida
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    log('POP: ${route.settings.name}');
    // Aqui você pode fazer algo quando o usuário volta para uma página anterior
  }

  // Esse método é chamado quando uma rota é substituída por uma nova
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    log('REPLACE: ${oldRoute?.settings.name} por ${newRoute?.settings.name}');
    // Aqui você pode fazer algo quando uma rota é substituída por outra
  }

  // Esse método é chamado quando todas as rotas anteriores são removidas
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    log('DID REMOVE: ${route.settings.name}');
    // Aqui você pode fazer algo quando uma rota é removida permanentemente
  }
}
