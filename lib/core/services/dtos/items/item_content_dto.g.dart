// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_content_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemContentDTO _$ItemContentDTOFromJson(Map<String, dynamic> json) =>
    ItemContentDTO(
      item: ItemDTO.fromJson(json['item'] as Map<String, dynamic>),
      user: ItemUserDTO.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemContentDTOToJson(ItemContentDTO instance) =>
    <String, dynamic>{
      'item': instance.item,
      'user': instance.user,
    };
