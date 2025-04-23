import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/authenticated_image_widget.dart';
import 'package:kondus/core/widgets/photo_view_page.dart';

class ItemDetailsImageCarousel extends StatelessWidget {
  final List<String> imageUrls;
  const ItemDetailsImageCarousel({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return imageUrls.isNotEmpty
        ? SizedBox(
            height: 250,
            width: double.infinity,
            child: CarouselView(
              itemExtent: double.infinity,
              itemSnapping: true,
              onTap: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoViewPage(
                      isFromNetwork: true,
                      imagePath: imageUrls[value],
                    ),
                  ),
                );
              },
              children: [
                for (final url in imageUrls)
                  AuthenticatedImage(
                    imagePath: url,
                  ),
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
