import 'package:flutter/cupertino.dart';
import 'package:kondus/src/modules/product_details/domain/get_product_details_usecase.dart';
import 'package:kondus/src/modules/product_details/domain/product_details_model.dart';

final class ProductDetailsViewmodel {
  final GetProductDetailsUsecase _getUsecase;

  ProductDetailsViewmodel(this._getUsecase);

  final ValueNotifier<ProductDetailsState> state =
      ValueNotifier(ProductDetailsIdleState());

  Future getProductDetails(int productId) async {
    state.value = ProductDetailsLoadingState();
    state.value = await _getUsecase.call(productId: productId);
  }
}

sealed class ProductDetailsState {}

final class ProductDetailsIdleState implements ProductDetailsState {}

final class ProductDetailsLoadingState implements ProductDetailsState {}

final class ProductDetailsSuccessState implements ProductDetailsState {
  final ProductDetailsModel data;

  ProductDetailsSuccessState({required this.data});
}

final class ProductDetailsFailureState implements ProductDetailsState {
  final String message;

  ProductDetailsFailureState({required this.message});
}
