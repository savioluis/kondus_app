import 'package:flutter/material.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_data/colors/app_colors.dart';
import 'package:kondus/core/widgets/authenticated_image_widget.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.item,
    required this.onTap,
    super.key,
  });

  final ProductDTO item;
  final VoidCallback onTap;

  Widget _buildActionTypeChip(BuildContext context) {
    final actionType = item.actionType;

    final colors = {
      'Comprar': Colors.green,
      'Alugar': Colors.orange,
      'Contratar': Colors.blue,
    };

    final chipColor = colors[actionType] ?? AppColors.lightGrey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        actionType.toUpperCase(),
        style: context.labelSmall!.copyWith(
          color: chipColor,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.lightGreyColor.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: context.primaryColor.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: item.imageUrl.isNotEmpty
                  ? AuthenticatedImage(
                      imagePath: item.imageUrl,
                      size: 72,
                    )
                  : Container(
                      width: 72,
                      height: 72,
                      color: context.lightGreyColor.withOpacity(0.1),
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: context.onSurfaceColor.withOpacity(0.3),
                        size: 32,
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.labelLarge!.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildActionTypeChip(context),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyMedium!.copyWith(
                      fontSize: 13,
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
