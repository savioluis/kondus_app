import 'package:flutter/material.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_data/colors/app_colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.onTap,
    super.key,
  });

  final ProductDTO product;
  final VoidCallback onTap;

  Widget _buildActionTypeChip() {
    final actionType = product.actionType;

    final colors = {
      'Comprar': Colors.green,
      'Alugar': Colors.orange,
      'Contratar': Colors.blue,
    };

    final chipColor = colors[actionType] ?? AppColors.lightGrey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.2),
        border: Border.all(color: chipColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        actionType.toUpperCase(),
        style: TextStyle(
          color: chipColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: context.whiteColor,
            border: Border.all(color: context.lightGreyColor)),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            product.imageUrl.isNotEmpty
                ? Image.network(
                    product.imageUrl,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 72,
                    height: 72,
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
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Flexible(child: _buildActionTypeChip())
                    ],
                  ),
                  Text(
                    product.category,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
