import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/app/envrionment_constants.dart';
import 'package:kondus/core/repositories/i_token_repository.dart';
import 'package:kondus/core/theme/app_theme.dart';

class AuthenticatedImage extends StatelessWidget {
  const AuthenticatedImage({
    required this.imagePath,
    this.size = 64,
    this.radius = 8,
    this.imageFit = BoxFit.cover,
    super.key,
  });

  final String imagePath;
  final double size;
  final double radius;
  final BoxFit? imageFit;

  String _getImageUrl(String imagePath) {
    const baseUrl = EnvrionmentConstants.baseUrl;
    return '$baseUrl/items/images/$imagePath';
  }

  @override
  Widget build(BuildContext context) {
    final tokenRepository = GetIt.instance<ITokenRepository>();

    return FutureBuilder<String?>(
      future: tokenRepository.getAccessToken(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            width: size,
            height: size,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final token = snapshot.data;

        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(
            _getImageUrl(imagePath),
            width: size,
            height: size,
            fit: imageFit,
            headers: {
              'Authorization': 'Bearer $token',
            },
            errorBuilder: (context, error, stackTrace) {
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
      },
    );
  }
}
