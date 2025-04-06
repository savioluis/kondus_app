// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'item_user_dto.g.dart';

@JsonSerializable()
class ItemUserDTO {
  final String name;
  final String house;

  ItemUserDTO({
    required this.name,
    required this.house,
  });

  factory ItemUserDTO.fromJson(Map<String, dynamic> json) =>
      _$ItemUserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ItemUserDTOToJson(this);

  @override
  String toString() => 'ItemUserDTO(name: $name, house: $house)';
}
