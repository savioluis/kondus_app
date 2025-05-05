import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/providers/http/i_http_provider.dart';
import 'package:kondus/core/repositories/i_token_repository.dart';
import 'package:kondus/core/services/auth/session_manager.dart';
import 'package:kondus/core/services/dtos/items/category_dto.dart';
import 'package:kondus/core/services/dtos/items/item_content_dto.dart';
import 'package:kondus/core/services/dtos/items/item_dto.dart';
import 'package:kondus/core/services/dtos/items/items_response_dto.dart';
import 'package:kondus/core/services/dtos/items/register_item_request_dto.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';

class ItemsService {
  ItemsService({
    required IHttpProvider httpProvider,
    required ITokenRepository tokenRepository,
    required SessionManager sessionManager,
  })  : _httpProvider = httpProvider,
        _tokenRepository = tokenRepository;

  final IHttpProvider _httpProvider;
  final ITokenRepository _tokenRepository;

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

  Future<List<CategoryDTO>> getAllCategories() async {
    try {
      final token = await _tokenRepository.getAccessToken();

      final response = await _httpProvider.get<List>(
        '/items/categories',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response == null) {
        throw const HttpError(
          type: HttpErrorType.unknown,
          message: 'Não foi possível recuperar as categorias. Tente novamente.',
        );
      }

      final categories = CategoryDTO.parseCategoriesResponse(response);

      return categories;
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
        message: 'Ocorreu um erro ao recuperar as categorias. Tente novamente.',
      );
    }
  }

  Future<List<ItemDTO>?> getMyItems() async {
    try {
      final token = await _tokenRepository.getAccessToken();

      final response = await _httpProvider.get<List>(
        '/items/my',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response == null) {
        throw const HttpError(
          type: HttpErrorType.unknown,
          message:
              'Não foi possível recuperar os seus anúncios. Tente novamente.',
        );
      }

      final items = ItemDTO.fromList(response);

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
        message:
            'Ocorreu um erro ao recuperar os seus anúncios. Tente novamente.',
      );
    }
  }

  Future<void> removeItem({required int id}) async {
    try {
      final token = await _tokenRepository.getAccessToken();

      final response = await _httpProvider.delete(
        '/items/$id',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response == null) {
        throw const HttpError(
          type: HttpErrorType.unknown,
          message:
              'Não foi possível recuperar os seus anúncios. Tente novamente.',
        );
      }
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
        message: 'Ocorreu um erro ao remover o seu anúncio. Tente novamente.',
      );
    }
  }

  Future<int> registerItem({required RegisterItemRequestDTO request}) async {
    try {
      final token = await _tokenRepository.getAccessToken();

      final response = await _httpProvider.post(
        '/items',
        headers: {'Authorization': 'Bearer $token'},
        data: request.toJson(),
      );

      if (response == null) {
        throw const HttpError(
          type: HttpErrorType.unknown,
          message: 'Não foi possível reegistrar o seu item. Tente novamente.',
        );
      }

      return response;
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
        message: 'Ocorreu um erro ao registrar o seu item.',
      );
    }
  }

  Future<void> uploadImagesForItem({
    required List<String> imagesFilesPaths,
    required int itemId,
  }) async {
    try {
      final token = await _tokenRepository.getAccessToken();

      final List<MultipartFile> imageFiles = [];

      for (final path in imagesFilesPaths) {
        final imageFile = File(path);
        if (!imageFile.existsSync()) {
          log('Arquivo de Imagem não existe: $path');
          return;
        }

        final fileExtension = path.split('.').last.toLowerCase();
        String subtype = 'jpeg';
        if (fileExtension == 'png') subtype = 'png';

        final multipartFile = await MultipartFile.fromFile(
          path,
          filename: path.split('/').last,
          contentType: MediaType('image', subtype),
        );

        imageFiles.add(multipartFile);
      }

      final body = FormData.fromMap({
        "image": imageFiles,
        "itemId": itemId.toString(),
      });

      final response = await _httpProvider.post(
        '/items/images',
        data: body,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response == null) {
        throw const HttpError(
          type: HttpErrorType.unknown,
          message:
              'Não foi possível fazer o upload das imagens. Tente novamente.',
        );
      }

      return response;
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
        message: 'Ocorreu um erro ao enviar as imagens. Tente novamente.',
      );
    }
  }
}
