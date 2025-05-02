import 'package:kondus/core/services/dtos/items/category_dto.dart';
import 'package:kondus/core/services/dtos/items/item_content_dto.dart';

final class ItemDetailsModel {
  final String name;
  final ItemDetailsOwnerModel owner;
  final List<String> imageUrls;
  final String description;
  final double price;
  final List<CategoryDTO> categories;
  final String type;
  final String actionType;
  final int quantity;

  ItemDetailsModel({
    required this.name,
    required this.owner,
    required this.imageUrls,
    required this.description,
    required this.price,
    required this.categories,
    required this.type,
    required this.actionType,
    required this.quantity,
  });

  static String _getActionType({required int quantity, required String type}) {
    if (type == 'produto') {
      if (quantity == 0) return 'Alugar';
      return 'Comprar';
    }
    return 'Contratar';
  }

  factory ItemDetailsModel.fromDTO(ItemContentDTO dto) {
    return ItemDetailsModel(
      name: dto.item.title,
      description: dto.item.description,
      imageUrls: dto.item.imagesPaths,
      owner: ItemDetailsOwnerModel(
        id: dto.user.id.toString(),
        name: dto.user.name,
        house: dto.user.house,
        local: dto.user.local,
      ),
      price: dto.item.price,
      categories: dto.item.categories,
      type: dto.item.type,
      actionType:
          _getActionType(quantity: dto.item.quantity, type: dto.item.type),
      quantity: dto.item.quantity,
    );
  }
}

final class ItemDetailsOwnerModel {
  final String id;
  final String name;
  final String house;
  final String local;

  ItemDetailsOwnerModel({
    required this.id,
    required this.name,
    required this.house,
    required this.local,
  });
}
