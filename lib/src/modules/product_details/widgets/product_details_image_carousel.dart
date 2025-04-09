import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/src/modules/product_details/presentation/product_details_page.dart';

class ProductDetailsImageCarousel extends StatelessWidget {
  final List<String> imageUrls;
  const ProductDetailsImageCarousel({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return imageUrls.isNotEmpty
        ? SizedBox(
            height: 250,
            width: double.infinity,
            child: CarouselView(
              itemExtent: double.infinity,
              itemSnapping: true,
              children: [
                for (final url in imageUrls)
                  Image.network(
                    url,
                    fit: BoxFit.cover,
                  )
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: context.lightGreyColor.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            height: 250,
            width: double.infinity,
            child: Icon(
              Icons.hide_image_outlined,
              color: context.onSurfaceColor.withOpacity(0.2),
              size: 96,
            ),
          );
  }
}
