
import 'package:flutter/material.dart';
import 'package:kondus/src/modules/product_details/domain/product_details_model.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

class ProductDetailsOwnerBanner extends StatelessWidget {
  final ProductDetailsOwnerModel owner;
  const ProductDetailsOwnerBanner({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200),
      decoration: BoxDecoration(
        color: context.lightGreyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
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
