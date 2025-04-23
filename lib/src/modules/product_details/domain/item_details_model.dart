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

  ItemDetailsModel({
    required this.name,
    required this.owner,
    required this.imageUrls,
    required this.description,
    required this.price,
    required this.categories,
    required this.type,
  });

  factory ItemDetailsModel.fromDTO(ItemContentDTO dto) {
    return ItemDetailsModel(
      name: dto.item.title,
      description: dto.item.description,
      imageUrls: dto.item.imagesPaths,
      owner: ItemDetailsOwnerModel(
        name: dto.user.name,
        complement: dto.user.house,
      ),
      price: dto.item.price,
      categories: dto.item.categories,
      type: dto.item.type,
    );
  }
}

final class ItemDetailsOwnerModel {
  final String name;
  final String complement;

  ItemDetailsOwnerModel({required this.name, required this.complement});
}
