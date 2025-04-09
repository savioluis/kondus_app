import 'package:kondus/core/services/dtos/items/items_response_dto.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  @override
  String toString() => 'CategoryModel(id: $id, name: $name)';
}

class UserOwnerModel {
  // final int id;
  final String name;
  final String house;

  UserOwnerModel({
    required this.name,
    required this.house,
  });

  @override
  String toString() => 'UserOwnerModel(name: $name, house: $house)';
}

class ItemModel {
  final int id;
  final String name;
  final String description;
  final ItemType type;
  final int quantity;
  final List<CategoryModel> categories;
  final List<String> imagesPaths;
  final UserOwnerModel userOwner;

  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.quantity,
    required this.categories,
    required this.imagesPaths,
    required this.userOwner,
  });

  static List<ItemModel> getItemsfromDTO(ItemsResponseDTO dto) {
    return dto.items.map((itemContent) {
      final item = itemContent.item;
      final user = itemContent.user;

      return ItemModel(
        id: item.id,
        name: item.title,
        description: item.description,
        type: switch (item.type) {
          'produto' => ItemType.produto,
          'serviço' => ItemType.servico,
          'aluguel' => ItemType.aluguel,
          _ => ItemType.produto,
        },
        quantity: item.quantity,
        categories: item.categories
            .map(
              (cat) => CategoryModel(
                id: cat.id,
                name: cat.name,
              ),
            )
            .toList(),
        imagesPaths: item.imagesPaths,
        userOwner: UserOwnerModel(
          name: user.name,
          house: user.house,
        ),
      );
    }).toList();
  }

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, description: $description, type: $type, quantity: $quantity, categories: $categories, imagesPaths: $imagesPaths, userOwner: $userOwner)';
  }
}
