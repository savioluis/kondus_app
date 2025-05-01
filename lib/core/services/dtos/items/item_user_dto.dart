// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'item_user_dto.g.dart';

@JsonSerializable()
class ItemUserDTO {
  final int id;
  final String name;
  final String house;
  // final String complement;

  ItemUserDTO({
    required this.id,
    required this.name,
    required this.house,
    // required this.complement,
  });

  factory ItemUserDTO.fromJson(Map<String, dynamic> json) =>
      _$ItemUserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ItemUserDTOToJson(this);

  @override
  String toString() => 'ItemUserDTO(id: $id, name: $name, house: $house)';
}
