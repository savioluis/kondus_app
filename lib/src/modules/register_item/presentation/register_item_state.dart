// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/services/dtos/items/category_dto.dart';

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
  RegisterItemSuccessState(
      {required this.categories, this.validationErrorMessage});
  final List<CategoryDTO> categories;
  final String? validationErrorMessage;

  RegisterItemSuccessState copyWith({
    List<CategoryDTO>? categories,
    String? validationErrorMessage,
  }) {
    return RegisterItemSuccessState(
      categories: categories ?? this.categories,
      validationErrorMessage: validationErrorMessage,
    );
  }
}

class RegisterItemFailureState extends RegisterItemState {
  RegisterItemFailureState({required this.error});
  final KondusFailure error;
}
