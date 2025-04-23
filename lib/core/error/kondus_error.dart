abstract class KondusFailure<T> implements Exception {
  final String failureMessage = '';
}

class KondusError implements KondusFailure<KondusError> {
  final String message;
  final KondusErrorType type;

  KondusError({
    required this.message,
    required this.type,
  });

  @override
  String get failureMessage => message;
}

enum KondusErrorType {
  empty,
  failedToLoad,
  validation,
  upload,
  unknown,
}
