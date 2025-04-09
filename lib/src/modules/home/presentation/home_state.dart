import 'package:kondus/src/modules/home/models/item_model.dart';
import 'package:kondus/src/modules/home/models/user_model.dart';

sealed class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  HomeSuccessState({
    required this.user,
    required this.items,
  });
  
  final UserModel user;
  final List<ItemModel> items;
}

class HomeFailureState extends HomeState {
  HomeFailureState({required this.message, this.isLoggedIn = false});
  final String message;
  bool isLoggedIn;
}
