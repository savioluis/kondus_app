enum ItemType {
  produto,
  servico,
  aluguel,
}

extension ItemTypeExtension on ItemType {
  String toJsonValue() {
    return switch (this) {
      ItemType.produto => 'produto',
      ItemType.servico => 'servico',
      ItemType.aluguel => 'aluguel',
    };
  }
}

class ItemsFiltersModel {
  final List<int> categoriesIds;
  final List<ItemType> types;

  const ItemsFiltersModel({
    required this.categoriesIds,
    required this.types,
  });

  Map<String, dynamic> toJson() {
    return {
      'search': 'br',
      'categoriesIds': categoriesIds,
      'types': types.map((type) => type.toJsonValue()).toList(),
    };
  }
}
