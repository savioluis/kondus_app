import 'package:kondus/core/services/dtos/user/users_info_response_dto.dart';

class ContactModel {
  final String id;
  final String name;
  final String location;

  ContactModel({
    required this.id,
    required this.name,
    required this.location,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
    };
  }

  static List<ContactModel> fromUserDTOList(List<UserDTO> userDTOList) {
    return userDTOList.map((userDTO) {
      return ContactModel(
        id: userDTO.id.toString(),
        name: userDTO.name,
        location: userDTO.houseName,
      );
    }).toList();
  }
}
