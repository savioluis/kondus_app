import 'package:json_annotation/json_annotation.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDTO {
  LoginRequestDTO({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory LoginRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestDTOToJson(this);
}
