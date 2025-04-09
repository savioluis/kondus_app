import 'package:get_it/get_it.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/src/modules/product_details/domain/product_details_model.dart';
import 'package:kondus/src/modules/product_details/domain/product_details_viewmodel.dart';

final class GetProductDetailsUsecase {
  Future<ProductDetailsState> call({required int productId}) async {
    final itemsService = GetIt.instance<ItemsService>();

    try {
      final itemContent = await itemsService.getItemById(id: productId);

      if (itemContent == null) {
        return ProductDetailsFailureState(message: 'Erro ao obter o produto');
      }

      final model = ProductDetailsModel.fromDTO(itemContent);

      return ProductDetailsSuccessState(data: model);
    } on HttpError catch (e) {
      return ProductDetailsFailureState(message: e.message);
    } catch (e) {
      return ProductDetailsFailureState(message: e.toString());
    }
  }
}
