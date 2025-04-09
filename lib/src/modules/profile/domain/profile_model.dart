import 'package:kondus/core/services/dtos/user/user_info_response_dto.dart';

final class ProfileModel{
  final String owner;
  final String address;
  final String complement;
  ProfileModel({required this.owner, required this.address, required this.complement});

    factory ProfileModel.fromDTO(UserInfoResponseDTO dto) {
    return ProfileModel(
      owner: dto.name,
      address: dto.local.name,
      complement: dto.house.name,
    );
  }
}