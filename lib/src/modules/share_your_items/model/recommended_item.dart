import 'package:kondus/core/services/items/models/items_filter_model.dart';

class RecommendedItem {
  final String name;
  final ItemType type;
  final String description;
  final List<int> categoriesIds;
  final String actionType;

  RecommendedItem({
    required this.name,
    required this.type,
    required this.description,
    required this.categoriesIds,
    required this.actionType,
  });

}
