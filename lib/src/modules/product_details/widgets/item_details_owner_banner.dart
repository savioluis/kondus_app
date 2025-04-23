
import 'package:flutter/material.dart';
import 'package:kondus/src/modules/product_details/domain/item_details_model.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ItemDetailsOwnerBanner extends StatelessWidget {
  final ItemDetailsOwnerModel owner;
  const ItemDetailsOwnerBanner({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.lightGreyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(owner.name, style: context.titleMedium),
            Text(owner.complement, style: context.titleSmall)
          ],
        ),
      ),
    );
  }
}
