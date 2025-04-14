// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:kondus/core/error/kondus_error.dart';

sealed class RegisterItemState {}

class RegisterItemLoadingState extends RegisterItemState {}

class RegisterItemStep1State extends RegisterItemState {
  RegisterItemStep1State({this.validationErrorMessage});
  final String? validationErrorMessage;

  RegisterItemStep1State copyWith({
    String? validationErrorMessage,
  }) {
    return RegisterItemStep1State(
      validationErrorMessage:
          validationErrorMessage ?? this.validationErrorMessage,
    );
  }
}

class RegisterItemSuccessState extends RegisterItemState {
  RegisterItemSuccessState({required this.categories});
  final List<String> categories;
}

class RegisterItemFailureState extends RegisterItemState {
  RegisterItemFailureState({required this.error});
  final KondusFailure error;
}
