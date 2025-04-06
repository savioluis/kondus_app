// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsResponseDTO _$ItemsResponseDTOFromJson(Map<String, dynamic> json) =>
    ItemsResponseDTO(
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemContentDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemsResponseDTOToJson(ItemsResponseDTO instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
