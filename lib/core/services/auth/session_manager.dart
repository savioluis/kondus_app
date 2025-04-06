import 'dart:async';
import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/repositories/i_token_repository.dart';

class SessionManager {
  final ITokenRepository _tokenRepository = GetIt.instance<ITokenRepository>();

  final StreamController<bool> _isLoggedInController =
      StreamController<bool>.broadcast();

  Stream<bool> get isLoggedInStream => _isLoggedInController.stream;

  Future<(bool, String?)> isLoggedIn() async {
    final token = await _tokenRepository.getAccessToken();
    final accessToken = await _tokenRepository.getAccessToken();
    return (accessToken != null, token);
  }

  Future<void> logout() async {
    try {
      // Obtém o token FCM atual
      // final fcmToken = await FcmHandle.I.getToken();

      // Revoga o token FCM localmente
      // await FcmHandle.I.revokeToken();

      // Se o token FCM existir, revoga no servidor
      // if (fcmToken != null) {
      //   final pushTokenService = GetIt.instance<PushTokenService>();
      //   await pushTokenService.revokePushToken(token: fcmToken);
      // }

      await _tokenRepository.clearToken();

      _isLoggedInController.add(false);

      log('🔴 Usuário deslogado com sucesso e token revogado.');
    } catch (e) {
      log('🚧 Erro ao deslogar ou revogar token: $e');
    }
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    _isLoggedInController.add(isLoggedIn);
    log('🟢 Usuário logado com sucesso');
  }

  void dispose() {
    _isLoggedInController.close();
  }
}
