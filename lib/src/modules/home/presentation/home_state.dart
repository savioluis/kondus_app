import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/src/modules/chat/contact_list/model/contact_model.dart';
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
    required this.contacts,
    required this.unreadMessagesCountForEachContactId,
  });

  final UserModel user;
  final List<ItemModel> items;
  final bool isLoadingMoreItems;

  final List<ContactModel> contacts;
  final Map<String, int> unreadMessagesCountForEachContactId;

  HomeSuccessState copyWith({
    UserModel? user,
    List<ItemModel>? items,
    bool? isLoadingMoreItems,
    List<ContactModel>? contacts,
    final Map<String, int>? unreadMessagesCountForEachContactId,
  }) {
    return HomeSuccessState(
      user: user ?? this.user,
      items: items ?? this.items,
      isLoadingMoreItems: isLoadingMoreItems ?? this.isLoadingMoreItems,
      contacts: contacts ?? this.contacts,
      unreadMessagesCountForEachContactId:
          unreadMessagesCountForEachContactId ??
              this.unreadMessagesCountForEachContactId,
    );
  }
}

class HomeFailureState extends HomeState {
  HomeFailureState({required this.error});
  final KondusFailure error;
}
