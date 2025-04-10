import 'package:flutter/material.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';
import 'package:kondus/core/theme/app_theme.dart';

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
        leading: product.imageUrl.isNotEmpty
            ? Image.network(
                product.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: context.lightGreyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  Icons.hide_image_outlined,
                  color: context.onSurfaceColor.withOpacity(0.2),
                  size: 25,
                ),
              ),
        title: Text(product.name),
        subtitle: Text('${product.category} • ${product.actionType}'),
        onTap: onTap,
      ),
    );
  }
}
