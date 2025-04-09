import 'package:kondus/core/services/dtos/items/item_content_dto.dart';

final class ProductDetailsModel{
  final String name;
  final ProductDetailsOwnerModel owner;
  final List<String> imageUrls;
  final String description;

  ProductDetailsModel({required this.name, required this.owner, required this.imageUrls, required this.description});

  factory ProductDetailsModel.fromDTO(ItemContentDTO dto) {
    return ProductDetailsModel(
      name: dto.item.title,
      description: dto.item.description,
      imageUrls: dto.item.imagesPaths,
      owner: ProductDetailsOwnerModel(
        name: dto.user.name,
        complement: dto.user.house,
      ),
    );
  }
}

final class ProductDetailsOwnerModel{
  final String name;
  final String complement;

  ProductDetailsOwnerModel({required this.name, required this.complement});
}