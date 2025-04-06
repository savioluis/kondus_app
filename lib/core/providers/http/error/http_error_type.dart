part of 'http_error.dart';

enum HttpErrorType {
  network,
  timeout,
  serverError,
  unauthorized,
  forbidden,
  notFound,
  validation,
  badRequest,
  conflict,
  unknown
}