// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemUserDTO _$ItemUserDTOFromJson(Map<String, dynamic> json) => ItemUserDTO(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      house: json['house'] as String,
    );

Map<String, dynamic> _$ItemUserDTOToJson(ItemUserDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'house': instance.house,
    };
