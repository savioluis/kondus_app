final class ProductDetailsModel{
  final String name;
  final ProductDetailsOwnerModel owner;
  final List<String> imageUrls;
  final String description;

  ProductDetailsModel({required this.name, required this.owner, required this.imageUrls, required this.description});
}

final class ProductDetailsOwnerModel{
  final String name;
  final String complement;

  ProductDetailsOwnerModel({required this.name, required this.complement});
}