import 'package:json_annotation/json_annotation.dart';

part 'user_id_response_dto.g.dart';

@JsonSerializable()
class UserIdResponseDTO {
  final int? id;

  UserIdResponseDTO({required this.id});

  factory UserIdResponseDTO.fromJson(Map<String, dynamic> json) => _$UserIdResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserIdResponseDTOToJson(this);
}
