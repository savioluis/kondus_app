import 'package:kondus/core/error/kondus_error.dart';

sealed class RegisterItemState {}

class RegisterItemLoadingState extends RegisterItemState {}

class RegisterItemInitialState extends RegisterItemState {}

class RegisterItemValidationErrorState extends RegisterItemState {
  RegisterItemValidationErrorState({this.validationErrorMessage});
  final String? validationErrorMessage;

  RegisterItemValidationErrorState copyWith({
    String? validationErrorMessage,
  }) {
    return RegisterItemValidationErrorState(
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
