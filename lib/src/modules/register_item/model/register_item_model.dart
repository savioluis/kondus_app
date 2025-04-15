// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'register_item_model.g.dart';

@JsonSerializable()
class RegisterItemModel {
  final String title;
  final String description;
  final String type;
  final double price;
  final int quantity;
  final List<int> categoriesIds;

  RegisterItemModel({
    required this.title,
    required this.description,
    required this.type,
    required this.price,
    required this.quantity,
    required this.categoriesIds,
  });

  factory RegisterItemModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterItemModelToJson(this);

  @override
  String toString() {
    return 'RegisterItemModel(title: $title, description: $description, type: $type, price: $price, quantity: $quantity, categoriesIds: $categoriesIds)';
  }
}
