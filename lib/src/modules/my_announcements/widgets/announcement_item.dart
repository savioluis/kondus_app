import 'package:flutter/material.dart';
import 'package:kondus/core/services/dtos/items/item_dto.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';
import 'package:kondus/core/theme/app_theme.dart';

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
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: context.surfaceColor,
            border: Border.all(color: context.lightGreyColor.withOpacity(0.5))),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            item.imagesPaths.isNotEmpty
                ? Image.network(
                    item.imagesPaths[0],
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
                      size: 36,
                    ),
                  ),
            const SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: context.labelLarge!.copyWith(
                      fontSize: 16,
                      color: context.primaryColor,
                    ),
                  ),
                  Text(
                    item.categories[0].name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: context.bodyMedium!.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {},
                customBorder: const CircleBorder(),
                child: Ink(
                  child: Icon(
                    Icons.cancel,
                    color: context.errorColor,
                    size: 48,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
