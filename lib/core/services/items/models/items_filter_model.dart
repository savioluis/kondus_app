import 'package:kondus/src/modules/home/widgets/item_card.dart';

enum ItemType {
  produto,
  servico,
  aluguel,
}

extension ItemTypeExtension on ItemType {
  String toJsonValue() {
    return switch (this) {
      ItemType.produto => 'produto',
      ItemType.servico => 'serviço',
      ItemType.aluguel => 'aluguel',
    };
  }

  static ItemType fromJsonValue(String category) {
    return switch (category.toLowerCase()) {
      'comprar' => ItemType.produto,
      'contratar' => ItemType.servico,
      'alugar' => ItemType.aluguel,
      _ => ItemType.produto,
    };
  }

  static ItemType fromRegisterItemType(String type) {
    return switch (type.toLowerCase()) {
      'venda' => ItemType.produto,
      'aluguel' => ItemType.produto,
      'serviço' => ItemType.servico,
      _ => ItemType.produto,
    };
  }

  ActionType toActionType(int quantity) {
    if (this == ItemType.produto) {
      if (quantity > 0) {
        return ActionType.comprar;
      }
      return ActionType.alugar;
    }
    return ActionType.contratar;
  }
}

class ItemsFiltersModel {
  final List<int> categoriesIds;
  final List<ItemType> types;
  final String query;

  const ItemsFiltersModel({
    required this.categoriesIds,
    required this.types,
    required this.query,
  });

  Map<String, dynamic> toJson() {
    return {
      'search': query,
      'categoriesIds': categoriesIds,
      'types': types.map((type) => type.toJsonValue()).toList(),
    };
  }
}
