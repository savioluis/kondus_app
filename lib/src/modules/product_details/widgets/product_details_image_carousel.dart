import 'package:flutter/material.dart';

class ProductDetailsImageCarousel extends StatelessWidget {
  final List<String> imageUrls;
  const ProductDetailsImageCarousel({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: CarouselView(
        itemExtent: double.infinity,
        children: [
          for (final url in imageUrls)
            Image.network(
              url,
              fit: BoxFit.cover,
            )
        ],
      ),
    );
  }
}
