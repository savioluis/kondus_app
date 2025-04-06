import 'package:json_annotation/json_annotation.dart';
import 'item_content_dto.dart';

part 'items_response_dto.g.dart';

@JsonSerializable()
class ItemsResponseDTO {
  final List<ItemContentDTO> items;

  ItemsResponseDTO({required this.items});

  factory ItemsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ItemsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsResponseDTOToJson(this);

  static ItemsResponseDTO fromList(List<dynamic> list) {
    final items = list
        .map((e) => ItemContentDTO.fromJson(e as Map<String, dynamic>))
        .toList();

    return ItemsResponseDTO(items: items);
  }
}
