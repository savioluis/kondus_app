import 'package:kondus/core/services/dtos/user/user_info_response_dto.dart';

final class ProfileModel {
  final String owner;
  final String house;
  final String local;
  ProfileModel({
    required this.owner,
    required this.house,
    required this.local,
  });

  factory ProfileModel.fromDTO(UserInfoResponseDTO dto) {
    return ProfileModel(
      owner: dto.name,
      house: dto.house.name,
      local: dto.local.name,
    );
  }
}
