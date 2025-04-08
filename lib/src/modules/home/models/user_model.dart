class HouseModel {
  final int id;
  final String name;

  HouseModel({
    required this.id,
    required this.name,
  });

  @override
  String toString() => 'HouseModel(id: $id, name: $name)';
}

class LocalModel {
  final int id;
  final String stree;
  final int number;
  final String postal;
  final String name;
  final String description;

  LocalModel({
    required this.id,
    required this.stree,
    required this.number,
    required this.postal,
    required this.name,
    required this.description,
  });

  @override
  String toString() {
    return 'LocalModel(id: $id, stree: $stree, number: $number, postal: $postal, name: $name, description: $description)';
  }
}

class UserModel {
  final int id;
  final String name;
  final HouseModel house;
  final LocalModel local;

  UserModel({
    required this.id,
    required this.name,
    required this.house,
    required this.local,
  });

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, house: $house, local: $local)';
  }
}
