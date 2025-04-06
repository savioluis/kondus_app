
import 'dart:developer';

import 'package:dio/dio.dart';

part 'http_error_type.dart';

class HttpError implements Exception {
  factory HttpError.fromDioError(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;

    log('🚧 HttpError: ${error.type} / Code: ${error.response?.statusCode}');

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return HttpError(
          type: HttpErrorType.timeout,
          message: 'A conexão expirou. Verifique sua internet.',
          statusCode: statusCode,
          originalError: error,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.badResponse:
        return _handleResponseError(error, statusCode, response?.data);

      case DioExceptionType.connectionError:
        return HttpError(
          type: HttpErrorType.network,
          message: 'Sem conexão com a internet.',
          originalError: error,
          stackTrace: error.stackTrace,
        );

      default:
        return HttpError(
          type: HttpErrorType.unknown,
          message: 'Ocorreu um erro inesperado.',
          originalError: error,
          stackTrace: error.stackTrace,
        );
    }
  }

  const HttpError({
    required this.type,
    required this.message,
    this.statusCode,
    this.data,
    this.originalError,
    this.stackTrace,
  });

  final HttpErrorType type;
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? data;
  final Object? originalError;
  final StackTrace? stackTrace;

  bool get isNetworkError => type == HttpErrorType.network;
  bool get isServerError => type == HttpErrorType.serverError;
  bool get isAuthError =>
      type == HttpErrorType.unauthorized || type == HttpErrorType.forbidden;
  bool get isValidationError => type == HttpErrorType.validation;

  static HttpError _handleResponseError(
    DioException error,
    int? statusCode,
    dynamic responseData,
  ) {
    switch (statusCode) {
      case 400:
        return HttpError(
          type: HttpErrorType.badRequest,
          message: 'Requisição inválida.',
          statusCode: statusCode,
          data: responseData,
          originalError: error,
        );
      case 401:
        return HttpError(
          type: HttpErrorType.unauthorized,
          message: 'Não autorizado. Faça login novamente.',
          statusCode: statusCode,
          data: responseData,
          originalError: error,
        );
      case 403:
        return HttpError(
          type: HttpErrorType.forbidden,
          message: 'Acesso negado.',
          statusCode: statusCode,
          data: responseData,
          originalError: error,
        );
      case 404:
        return HttpError(
          type: HttpErrorType.notFound,
          message: 'Recurso não encontrado.',
          statusCode: statusCode,
          data: responseData,
          originalError: error,
        );
      case 409:
        return HttpError(
          type: HttpErrorType.conflict,
          message: 'Conflito de dados.',
          statusCode: statusCode,
          data: responseData,
          originalError: error,
        );
      case 422:
        return HttpError(
          type: HttpErrorType.validation,
          message: _parseValidationErrors(responseData),
          statusCode: statusCode,
          data: responseData,
          originalError: error,
        );
      default:
        if (statusCode != null && statusCode >= 500) {
          return HttpError(
            type: HttpErrorType.serverError,
            message: 'Erro no servidor.',
            statusCode: statusCode,
            data: responseData,
            originalError: error,
          );
        }
        return HttpError(
          type: HttpErrorType.unknown,
          message: 'Erro desconhecido.',
          statusCode: statusCode,
          data: responseData,
          originalError: error,
        );
    }
  }

  static String _parseValidationErrors(Map<String, dynamic>? data) {
    if (data == null) return 'Dados inválidos.';

    final errors = data['errors'] as Map<String, dynamic>?;
    if (errors == null) return 'Dados inválidos.';

    return errors.entries
        .map((e) => '${e.key}: ${(e.value as List).join(', ')}')
        .join('\n');
  }

  @override
  String toString() {
    final buffer = StringBuffer()
      ..writeln('HttpError {')
      ..writeln('  type: $type')
      ..writeln('  message: $message')
      ..writeln('  statusCode: $statusCode');

    if (data != null) {
      buffer.writeln('  data: $data');
    }

    if (originalError != null) {
      buffer.writeln('  originalError: $originalError');
    }

    if (stackTrace != null) {
      buffer.writeln('  stackTrace: $stackTrace');
    }

    buffer.writeln('}');

    return buffer.toString();
  }
}
