import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/authenticated_image_widget.dart';

enum ActionType {
  comprar,
  alugar,
  contratar,
}

extension ActionTypeExtension on ActionType {
  String toJsonValue() {
    return switch (this) {
      ActionType.comprar => 'comprar',
      ActionType.alugar => 'alugar',
      ActionType.contratar => 'contratar',
    };
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.actionType,
    required this.onTap,
    super.key,
  });

  final String? imageUrl;
  final String name;
  final String category;
  final ActionType actionType;
  final VoidCallback onTap;

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
              color: context.primaryColor.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl != null
                  ? AuthenticatedImage(
                      imagePath: imageUrl!,
                      size: 72,
                    )
                  : Container(
                      width: 72,
                      height: 72,
                      color: context.lightGreyColor.withOpacity(0.1),
                      child: Icon(
                        Icons.hide_image_outlined,
                        color: context.onSurfaceColor.withOpacity(0.2),
                        size: 36,
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: context.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: context.labelSmall!.copyWith(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: context.blueColor,
            ),
          ],
        ),
      ),
    );
  }
}
