import 'package:kondus/core/error/kondus_error.dart';

sealed class RegisterItemState {}

class RegisterItemInitialState extends RegisterItemState {}

class RegisterItemLoadingState extends RegisterItemState {}

class RegisterItemSuccessState extends RegisterItemState {}

class RegisterItemFailureState extends RegisterItemState {
  RegisterItemFailureState({required this.error});
  final KondusFailure error;
}