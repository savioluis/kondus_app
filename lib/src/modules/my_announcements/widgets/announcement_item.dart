import 'package:flutter/material.dart';
import 'package:kondus/core/services/dtos/items/item_dto.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/authenticated_image_widget.dart';

class AnnouncementItem extends StatelessWidget {
  const AnnouncementItem({
    required this.item,
    required this.onTap,
    required this.onRemove,
    super.key,
  });

  final ItemDTO item;
  final VoidCallback onTap;
  final VoidCallback onRemove;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: item.imagesPaths.isNotEmpty
                  ? AuthenticatedImage(
                      imagePath: item.imagesPaths.first,
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
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleMedium!.copyWith(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.categories.first.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.labelSmall!.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(24),
              child: Icon(
                Icons.cancel_rounded,
                color: context.errorColor,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
