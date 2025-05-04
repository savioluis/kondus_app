import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class AuthenticatedImage extends StatelessWidget {
  const AuthenticatedImage({
    required this.imageUrl,
    this.size = 64,
    this.radius = 8,
    this.imageFit = BoxFit.cover,
    super.key,
  });

  final String imageUrl;
  final double size;
  final double radius;
  final BoxFit? imageFit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: imageFit,
        fadeInDuration: const Duration(milliseconds: 1200),
        fadeOutDuration: const Duration(milliseconds: 800),
        placeholderFadeInDuration: const Duration(milliseconds: 800),
        placeholder: (context, url) => Center(
          child: Container(
            height: size * 2,
            width: size * 2,
            decoration: BoxDecoration(
              color: context.lightGreyColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: context.lightGreyColor.withOpacity(0.018),
              ),
            ),
            child: Center(
              child: SizedBox(
                height: size / 3,
                width: size / 3,
                child: CircularProgressIndicator(
                  strokeWidth: size >= 72 ? 4 : 2,
                  color: context.primaryColor.withOpacity(0.2),
                ),
              ),
            ),
          ),
        ),
        errorWidget: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: context.lightGreyColor.withOpacity(0.2),
            ),
            child: Icon(
              Icons.hide_image_outlined,
              color: context.onSurfaceColor.withOpacity(0.2),
              size: 0.5625 * size,
            ),
          );
        },
      ),
    );
  }
}
