import 'package:get_it/get_it.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/src/modules/product_details/domain/item_details_model.dart';
import 'package:kondus/src/modules/product_details/domain/item_details_viewmodel.dart';

final class GetItemDetailsUsecase {
  Future<ItemDetailsState> call({required int productId}) async {
    final itemsService = GetIt.instance<ItemsService>();

    try {
      final itemContent = await itemsService.getItemById(id: productId);

      if (itemContent == null) {
        return ItemDetailsFailureState(
          error: KondusError(
            message: 'Erro ao obter o item',
            type: KondusErrorType.unknown,
          ),
        );
      }

      final model = ItemDetailsModel.fromDTO(itemContent);

      return ItemDetailsSuccessState(data: model);
    } on HttpError catch (e) {
      return ItemDetailsFailureState(error: e);
    } catch (e) {
      return ItemDetailsFailureState(
        error: KondusError(
          message: e.toString(),
          type: KondusErrorType.unknown,
        ),
      );
    }
  }
}
