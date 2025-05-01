import 'package:json_annotation/json_annotation.dart';

part 'users_info_response_dto.g.dart';

@JsonSerializable()
class UsersInfoResponseDTO {
  final List<UserDTO> users;

  UsersInfoResponseDTO({
    required this.users,
  });

  factory UsersInfoResponseDTO.fromJson(List<dynamic> jsonList) {
    List<UserDTO> usersList =
        jsonList.map((json) => UserDTO.fromJson(json)).toList();
    return UsersInfoResponseDTO(users: usersList);
  }
  
  Map<String, dynamic> toJson() => _$UsersInfoResponseDTOToJson(this);
}

@JsonSerializable()
class UserDTO {
  final String name;
  final int id;
  final String houseName;

  UserDTO({
    required this.name,
    required this.id,
    required this.houseName,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
