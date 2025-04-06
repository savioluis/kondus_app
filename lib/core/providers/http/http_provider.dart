import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/providers/http/i_http_provider.dart';

class HttpProvider implements IHttpProvider {
  HttpProvider({
    required String baseUrl,
    Map<String, dynamic>? headers,
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
    List<Interceptor>? interceptors,
  }) {
    final defaultHeaders = {'Content-Type': 'application/json'};

    if (headers != null) {
      headers.addAll(defaultHeaders);
    } else {
      headers = defaultHeaders;
    }

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: connectTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout),
        headers: headers,
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  late final Dio _dio;

  @override
  void setupInterceptors(List<Interceptor> interceptors) {
    _dio.interceptors.addAll(interceptors);
  }

  @override
  Future<T?> get<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw HttpError.fromDioError(e);
    } catch (e, s) {
      throw HttpError(
        type: HttpErrorType.unknown,
        message: 'Erro inesperado ao realizar requisição GET',
        originalError: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<T?> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw HttpError.fromDioError(e);
    } catch (e, s) {
      throw HttpError(
        type: HttpErrorType.unknown,
        message: 'Erro inesperado ao realizar requisição POST',
        originalError: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<T?> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw HttpError.fromDioError(e);
    } catch (e, s) {
      throw HttpError(
        type: HttpErrorType.unknown,
        message: 'Erro inesperado ao realizar requisição PUT',
        originalError: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<T?> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw HttpError.fromDioError(e);
    } catch (e, s) {
      throw HttpError(
        type: HttpErrorType.unknown,
        message: 'Erro inesperado ao realizar requisição DELETE',
        originalError: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<T?> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw HttpError.fromDioError(e);
    } catch (e, s) {
      throw HttpError(
        type: HttpErrorType.unknown,
        message: 'Erro inesperado ao realizar requisição PATCH',
        originalError: e,
        stackTrace: s,
      );
    }
  }
}
