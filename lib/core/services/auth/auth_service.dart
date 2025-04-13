import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/providers/http/i_http_provider.dart';
import 'package:kondus/core/repositories/i_token_repository.dart';
import 'package:kondus/core/services/auth/session_manager.dart';
import 'package:kondus/core/services/dtos/login/login_request_dto.dart';
import 'package:kondus/core/services/dtos/login/login_response_dto.dart';
import 'package:kondus/core/services/dtos/user/user_info_response_dto.dart';

class AuthService {
  AuthService({
    required IHttpProvider httpProvider,
    required ITokenRepository tokenRepository,
    required SessionManager sessionManager,
  })  : _httpProvider = httpProvider,
        _tokenRepository = tokenRepository,
        _sessionManager = sessionManager;

  final IHttpProvider _httpProvider;
  final ITokenRepository _tokenRepository;
  final SessionManager _sessionManager;

  Future<LoginResponseDTO?> login(LoginRequestDTO request) async {
    try {
      final response = await _httpProvider.get<Map<String, dynamic>>(
        '/users/login',
        data: request.toJson(),
      );

      if (response == null) {
        throw const HttpError(
          type: HttpErrorType.unknown,
          message: 'Não foi possível realizar o login. Tente novamente.',
        );
      }

      final loginResponse = LoginResponseDTO.fromJson(response);

      await _tokenRepository.saveAccessToken(loginResponse.token);

      _sessionManager.setLoggedIn(true);

      return loginResponse;
    } on HttpError catch (e) {
      if (e.isValidationError) {
        throw HttpError(
          type: HttpErrorType.validation,
          message: 'Email ou senha inválidos',
          data: e.data,
        );
      }

      if (e.isAuthError) {
        throw const HttpError(
          type: HttpErrorType.unauthorized,
          message: 'Email ou senha incorretos',
        );
      }

      if (e.isNetworkError) {
        throw const HttpError(
          type: HttpErrorType.network,
          message: 'Verifique sua conexão com a internet',
        );
      }

      if (e.isServerError) {
        throw const HttpError(
          type: HttpErrorType.serverError,
          message: 'Houve um problema com nosso servidor. Tente novamente.',
        );
      }

      throw const HttpError(
        type: HttpErrorType.unknown,
        message:
            'E-mail ou senha incorretos. Verifique suas credenciais e tente novamente.',
      );
    }
  }

  Future<int?> getUserId() async {
    try {
      final token = await _tokenRepository.getAccessToken();

      final response = await _httpProvider.get<int?>(
        '/users/id',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response == null) {
        throw const HttpError(
          type: HttpErrorType.unknown,
          message:
              'Não foi possível recuperar o id do usuario. Tente novamente.',
        );
      }

      final userId = response;

      return userId;
    } on HttpError catch (e) {
      if (e.isAuthError) {
        throw const HttpError(
          type: HttpErrorType.unauthorized,
          message: 'Não autorizado. Autentifique-se novamente.',
        );
      }

      if (e.isNetworkError) {
        throw const HttpError(
          type: HttpErrorType.network,
          message: 'Verifique sua conexão com a internet',
        );
      }

      throw const HttpError(
        type: HttpErrorType.unknown,
        message: 'Ocorreu um erro ao recuperar o id. Tente novamente.',
      );
    }
  }

  Future<UserInfoResponseDTO?> getLoggedUserInfo() async {
    try {
      final token = await _tokenRepository.getAccessToken();

      final response = await _httpProvider.get(
        '/users/info',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response == null) {
        throw const HttpError(
          type: HttpErrorType.unknown,
          message:
              'Não foi possível recuperar o id do usuario. Tente novamente.',
        );
      }

      final userInfo = UserInfoResponseDTO.fromJson(response);

      return userInfo;
    } on HttpError catch (e) {
      if (e.isAuthError) {
        throw const HttpError(
          type: HttpErrorType.unauthorized,
          message: 'Não autorizado. Autentifique-se novamente.',
        );
      }

      if (e.isNetworkError) {
        throw const HttpError(
          type: HttpErrorType.network,
          message: 'Verifique sua conexão com a internet',
        );
      }

      throw const HttpError(
        type: HttpErrorType.unknown,
        message:
            'Ocorreu um erro ao recuperar as informações do usuário. Tente novamente.',
      );
    }
  }
}
