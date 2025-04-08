import 'package:kondus/src/modules/home/widgets/product_card.dart';

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
}

extension ItemTypeToActionType on ItemType {
  ActionType toActionType() {
    switch (this) {
      case ItemType.produto:
        return ActionType.comprar;
      case ItemType.servico:
        return ActionType.contratar;
      case ItemType.aluguel:
        return ActionType.alugar;
    }
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
