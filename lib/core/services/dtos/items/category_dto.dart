import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDTO {
  final int id;
  final String name;

  CategoryDTO({
    required this.id,
    required this.name,
  });

  factory CategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CategoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDTOToJson(this);

  static List<CategoryDTO> parseCategoriesResponse(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CategoryDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
