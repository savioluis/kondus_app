// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestDTO _$LoginRequestDTOFromJson(Map<String, dynamic> json) =>
    LoginRequestDTO(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestDTOToJson(LoginRequestDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
