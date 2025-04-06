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

    setupInterceptors(interceptors);
  }

  late final Dio _dio;

  @override
  void setupInterceptors(List<Interceptor>? interceptors) {
    bool hasLogInterceptor =
        interceptors?.any((i) => i is LogInterceptor) ?? false;

    if (interceptors != null) {
      hasLogInterceptor
          ? _dio.interceptors.addAll(interceptors)
          : _dio.interceptors.addAll(
              [
                ...interceptors,
                LogInterceptor(
                  requestBody: true,
                  responseBody: true,
                  error: true,
                ),
              ],
            );
    }
  }

  @override
  Future<T?> get<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw HttpError.fromDioError(e);
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
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw HttpError.fromDioError(e);
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
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw HttpError.fromDioError(e);
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
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw HttpError.fromDioError(e);
    }
  }
}
