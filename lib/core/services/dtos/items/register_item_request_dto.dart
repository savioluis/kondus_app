import 'package:json_annotation/json_annotation.dart';

part 'register_item_request_dto.g.dart';

@JsonSerializable()
class RegisterItemRequestDTO {
  final String title;
  final String description;
  final String type;
  final double price;
  final int quantity;
  final List<int> categoriesIds;

  RegisterItemRequestDTO({
    required this.title,
    required this.description,
    required this.type,
    required this.price,
    required this.quantity,
    required this.categoriesIds,
  });

  factory RegisterItemRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$RegisterItemRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterItemRequestDTOToJson(this);
}
