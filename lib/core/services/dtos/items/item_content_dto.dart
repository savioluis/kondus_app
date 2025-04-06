import 'package:json_annotation/json_annotation.dart';
import 'item_dto.dart';
import 'item_user_dto.dart';

part 'item_content_dto.g.dart';

@JsonSerializable()
class ItemContentDTO {
  final ItemDTO item;
  final ItemUserDTO user;

  ItemContentDTO({
    required this.item,
    required this.user,
  });

  factory ItemContentDTO.fromJson(Map<String, dynamic> json) =>
      _$ItemContentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ItemContentDTOToJson(this);
}
