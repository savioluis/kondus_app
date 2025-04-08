// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoResponseDTO _$UserInfoResponseDTOFromJson(Map<String, dynamic> json) =>
    UserInfoResponseDTO(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      house: House.fromJson(json['house'] as Map<String, dynamic>),
      local: Local.fromJson(json['local'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoResponseDTOToJson(
        UserInfoResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'house': instance.house,
      'local': instance.local,
    };

House _$HouseFromJson(Map<String, dynamic> json) => House(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$HouseToJson(House instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Local _$LocalFromJson(Map<String, dynamic> json) => Local(
      id: (json['id'] as num).toInt(),
      street: json['street'] as String,
      number: (json['number'] as num).toInt(),
      postal: json['postal'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$LocalToJson(Local instance) => <String, dynamic>{
      'id': instance.id,
      'street': instance.street,
      'number': instance.number,
      'postal': instance.postal,
      'name': instance.name,
      'description': instance.description,
    };
