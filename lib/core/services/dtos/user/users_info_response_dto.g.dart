// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_info_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersInfoResponseDTO _$UsersInfoResponseDTOFromJson(
        Map<String, dynamic> json) =>
    UsersInfoResponseDTO(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsersInfoResponseDTOToJson(
        UsersInfoResponseDTO instance) =>
    <String, dynamic>{
      'users': instance.users,
    };

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      name: json['name'] as String,
      id: (json['id'] as num).toInt(),
      houseName: json['houseName'] as String,
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'houseName': instance.houseName,
    };
