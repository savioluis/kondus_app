import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/services/dtos/items/item_dto.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';

sealed class MyAnnouncementsState {}

class MyAnnouncementsInitialState extends MyAnnouncementsState {}

class MyAnnouncementsLoadingState extends MyAnnouncementsState {}

class MyAnnouncementsSuccessState extends MyAnnouncementsState {
  MyAnnouncementsSuccessState(
      {required this.items, this.hasRemovedItem = false});
  final List<ItemDTO> items;
  final bool hasRemovedItem;

  MyAnnouncementsSuccessState copyWith({
    List<ItemDTO>? items,
    bool? hasRemovedItem,
  }) {
    return MyAnnouncementsSuccessState(
      items: items ?? this.items,
      hasRemovedItem: hasRemovedItem ?? this.hasRemovedItem,
    );
  }
}

class MyAnnouncementsFailureState extends MyAnnouncementsState {
  final KondusFailure error;
  MyAnnouncementsFailureState({required this.error});
}
