// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'category_dto.dart';

part 'item_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemDTO {
  final int id;
  final String title;
  final String description;
  final String type;
  final double price;
  final int quantity;
  final List<CategoryDTO> categories;
  final List<String> imagesPaths;

  ItemDTO({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.price,
    required this.quantity,
    required this.categories,
    required this.imagesPaths,
  });

  static List<ItemDTO> fromList(List<dynamic> list) {
    return list
        .map((json) => ItemDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  factory ItemDTO.fromJson(Map<String, dynamic> json) =>
      _$ItemDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDTOToJson(this);

  @override
  String toString() {
    return 'ItemDTO(id: $id, title: $title, description: $description, type: $type, price: $price, quantity: $quantity, categories: $categories, imagesPaths: $imagesPaths)';
  }
}
