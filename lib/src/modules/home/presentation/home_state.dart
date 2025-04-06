import 'package:kondus/src/modules/home/models/user_model.dart';

sealed class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  HomeSuccessState({
    required this.user,
  });
  
  final UserModel user;
}

class HomeFailureState extends HomeState {
  HomeFailureState({required this.message});
  final String message;
}
