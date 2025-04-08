import 'package:json_annotation/json_annotation.dart';
import 'package:kondus/src/modules/home/models/user_model.dart';

part 'user_info_response_dto.g.dart';

@JsonSerializable()
class UserInfoResponseDTO {
  final int id;
  final String name;
  final House house;
  final Local local;

  UserInfoResponseDTO({
    required this.id,
    required this.name,
    required this.house,
    required this.local,
  });

  factory UserInfoResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoResponseDTOToJson(this);

  UserModel toModel() {
    return UserModel(
      id: id,
      name: name,
      house: HouseModel(
        id: house.id,
        name: house.name,
      ),
      local: LocalModel(
        id: local.id,
        stree: local.street,
        number: local.number,
        postal: local.postal,
        name: local.name,
        description: local.description,
      ),
    );
  }
}

@JsonSerializable()
class House {
  final int id;
  final String name;

  House({
    required this.id,
    required this.name,
  });

  factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);

  Map<String, dynamic> toJson() => _$HouseToJson(this);
}

@JsonSerializable()
class Local {
  final int id;
  final String street;
  final int number;
  final String postal;
  final String name;
  final String description;

  Local({
    required this.id,
    required this.street,
    required this.number,
    required this.postal,
    required this.name,
    required this.description,
  });

  factory Local.fromJson(Map<String, dynamic> json) => _$LocalFromJson(json);

  Map<String, dynamic> toJson() => _$LocalToJson(this);
}
