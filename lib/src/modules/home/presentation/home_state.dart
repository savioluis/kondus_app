import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';
import 'package:kondus/src/modules/home/models/user_model.dart';

sealed class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  HomeSuccessState({
    required this.user,
    required this.items,
    this.isLoadingMoreItems = false,
  });

  final UserModel user;
  final List<ItemModel> items;
  final bool isLoadingMoreItems;

  HomeSuccessState copyWith({
    UserModel? user,
    List<ItemModel>? items,
    bool? isLoadingMoreItems,
  }) {
    return HomeSuccessState(
      user: user ?? this.user,
      items: items ?? this.items,
      isLoadingMoreItems: isLoadingMoreItems ?? this.isLoadingMoreItems,
    );
  }
}

class HomeFailureState extends HomeState {
  HomeFailureState({required this.error});
  final KondusFailure error;
}
