import 'package:flutter/material.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.onTap,
    super.key,
  });

  final ProductDTO product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          product.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.name),
        subtitle: Text('${product.category} • ${product.actionType}'),
        onTap: onTap,
      ),
    );
  }
}
