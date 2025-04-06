import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/services/auth/auth_service.dart';
import 'package:kondus/core/services/dtos/login/login_request_dto.dart';
import 'package:kondus/core/utils/input_validator.dart';
import 'package:kondus/src/modules/login/presentation/login_state.dart';

class LoginController extends ChangeNotifier {
  final AuthService _authService = GetIt.instance<AuthService>();

  LoginState _state = LoginInitialState();

  LoginState get state => _state;

  final TextEditingController emailEC = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _emitState(LoginLoadingState());

    final validationError = _validateFields(email: email, password: password);

    if (validationError != null) {
      _emitState(LoginFailureState(message: validationError));
      return;
    }

    try {
      final loginResponse = await _authService.login(
        LoginRequestDTO(
          email: email.trim().toLowerCase(),
          password: password.trim(),
        ),
      );

      final accessToken = loginResponse.token;

      _emitState(LoginSuccessState(authToken: accessToken));
    } on HttpError catch (e) {
      _emitState(LoginFailureState(message: e.message));
    }
  }

  void _emitState(LoginState newState) {
    _state = newState;
    notifyListeners();
  }

  String? _validateFields({required String email, required String password}) {
    final emailValidationError = InputValidator.validateEmail(email: email);
    if (emailValidationError != null) return emailValidationError;

    final passwordValidationError =
        InputValidator.validatePasswordOnly(password: password);
    if (passwordValidationError != null) return passwordValidationError;

    return null;
  }
}
