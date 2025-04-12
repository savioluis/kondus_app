import 'package:kondus/core/services/dtos/items/items_response_dto.dart';

class ProductDTO {
  final String name;
  final String category;
  final String actionType;
  final String imageUrl;

  ProductDTO({
    required this.name,
    required this.category,
    required this.actionType,
    required this.imageUrl,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      name: json['name'],
      category: json['category'],
      actionType: json['actionType'],
      imageUrl: json['imageUrl'],
    );
  }

  static String _getActionType({required int quantity, required String type}) {
    if (type == 'produto') {
      if (quantity == 0) return 'Alugar';
      return 'Comprar';
    }
    return 'Contratar';
  }

  static List<ProductDTO> fromItemResponseDTO(ItemsResponseDTO dto) {
    return dto.items.map((itemContent) {
      final item = itemContent.item;
      return ProductDTO(
        name: item.title,
        category: item.categories.first.name,
        actionType: _getActionType(quantity: item.quantity, type: item.type),
        imageUrl: item.imagesPaths.isNotEmpty ? item.imagesPaths.first : '',
      );
    }).toList();
  }
}
