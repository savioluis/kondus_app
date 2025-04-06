// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final int id;
  final String name;
  final String houseName;

  UserModel({
    required this.id,
    required this.name,
    required this.houseName,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? houseName,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      houseName: houseName ?? this.houseName,
    );
  }

  @override
  String toString() => 'UserModel(id: $id, name: $name, houseName: $houseName)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.houseName == houseName;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ houseName.hashCode;
}
