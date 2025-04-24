import 'package:flutter/cupertino.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/src/modules/product_details/domain/get_item_details_usecase.dart';
import 'package:kondus/src/modules/product_details/domain/item_details_model.dart';

final class ItemDetailsViewmodel {
  final GetItemDetailsUsecase _getUsecase;

  ItemDetailsViewmodel(this._getUsecase);

  final ValueNotifier<ItemDetailsState> state =
      ValueNotifier(ItemDetailsIdleState());

  Future getItemDetails(int productId) async {
    state.value = ItemDetailsLoadingState();
    state.value = await _getUsecase.call(productId: productId);
  }
}

sealed class ItemDetailsState {}

final class ItemDetailsIdleState implements ItemDetailsState {}

final class ItemDetailsLoadingState implements ItemDetailsState {}

final class ItemDetailsSuccessState implements ItemDetailsState {
  final ItemDetailsModel data;

  ItemDetailsSuccessState({required this.data});
}

final class ItemDetailsFailureState implements ItemDetailsState {
  final KondusFailure error;

  ItemDetailsFailureState({required this.error});
}
