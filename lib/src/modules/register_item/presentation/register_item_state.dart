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
  RegisterItemSuccessState({
    required this.categories,
    this.validationErrorMessage,
    this.isSubmitting = false,
  });

  final List<CategoryDTO> categories;
  final String? validationErrorMessage;
  final bool isSubmitting;

  RegisterItemSuccessState copyWith({
    List<CategoryDTO>? categories,
    String? validationErrorMessage,
    bool? isSubmitting,
  }) {
    return RegisterItemSuccessState(
      categories: categories ?? this.categories,
      validationErrorMessage: validationErrorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class RegisterItemFailureState extends RegisterItemState {
  RegisterItemFailureState({required this.error});
  final KondusFailure error;
}

class RegisteredItemWithSuccess extends RegisterItemState {
  RegisteredItemWithSuccess({required this.itemName});
  final String itemName;
}
