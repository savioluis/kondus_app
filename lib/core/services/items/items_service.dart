import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/providers/http/i_http_provider.dart';
import 'package:kondus/core/repositories/i_token_repository.dart';
import 'package:kondus/core/services/auth/session_manager.dart';
import 'package:kondus/core/services/dtos/items/item_content_dto.dart';
import 'package:kondus/core/services/dtos/items/items_response_dto.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';

class ItemsService {
  ItemsService({
    required IHttpProvider httpProvider,
    required ITokenRepository tokenRepository,
    required SessionManager sessionManager,
  })  : _httpProvider = httpProvider,
        _tokenRepository = tokenRepository,
        _sessionManager = sessionManager;

  final IHttpProvider _httpProvider;
  final ITokenRepository _tokenRepository;
  final SessionManager _sessionManager;

  Future<ItemsResponseDTO?> getAllItems({ItemsFiltersModel? filters}) async {
    try {
      final token = await _tokenRepository.getAccessToken();

      final response = await _httpProvider.get<List>(
        '/items',
        data: filters != null
            ? filters.toJson()
            : {
                "search": "",
                "categoriesIds": [],
                "types": [],
              },
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response == null) {
        throw const HttpError(
          type: HttpErrorType.unknown,
          message: 'Não foi possível recuperar os items. Tente novamente.',
        );
      }

      final items = ItemsResponseDTO.fromList(response);

      return items;
    } on HttpError catch (e) {
      if (e.isAuthError) {
        throw const HttpError(
          type: HttpErrorType.unauthorized,
          message: 'Sua sessão expirou. Autentifique-se novamente.',
        );
      }

      if (e.isNetworkError) {
        throw const HttpError(
          type: HttpErrorType.network,
          message: 'Verifique sua conexão com a internet.',
        );
      }

      throw const HttpError(
        type: HttpErrorType.unknown,
        message: 'Ocorreu um erro ao recuperar os itens. Tente novamente.',
      );
    }
  }

  Future<ItemContentDTO?> getItemById({required int id}) async {
    try {
      final token = await _tokenRepository.getAccessToken();

      final response = await _httpProvider.get<Map<String, dynamic>>(
        '/items/$id',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response == null) {
        throw const HttpError(
          type: HttpErrorType.unknown,
          message: 'Não foi possível recuperar o item. Tente novamente.',
        );
      }

      final item = ItemContentDTO.fromJson(response);

      return item;
    } on HttpError catch (e) {
      if (e.isAuthError) {
        throw const HttpError(
          type: HttpErrorType.unauthorized,
          message: 'Sua sessão expirou. Autentifique-se novamente.',
        );
      }

      if (e.isNetworkError) {
        throw const HttpError(
          type: HttpErrorType.network,
          message: 'Verifique sua conexão com a internet.',
        );
      }

      throw const HttpError(
        type: HttpErrorType.unknown,
        message: 'Ocorreu um erro ao recuperar o item. Tente novamente.',
      );
    }
  }
}
