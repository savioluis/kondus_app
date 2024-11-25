class ProductDTO {
  final String name;
  final String category;
  final String actionType;
  final String imageUrl;

  ProductDTO({
    required this.name,
    required this.category,
    required this.actionType,
    required this.imageUrl,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      name: json['name'],
      category: json['category'],
      actionType: json['actionType'],
      imageUrl: json['imageUrl'],
    );
  }
}
