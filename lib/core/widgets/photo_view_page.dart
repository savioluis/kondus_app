import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kondus/app/envrionment_constants.dart';
import 'package:kondus/core/repositories/i_token_repository.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_data/colors/app_colors.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get_it/get_it.dart';

class PhotoViewPage extends StatelessWidget {
  final File? imageFile;
  final String? imagePath;
  final bool isFromNetwork;

  const PhotoViewPage({
    super.key,
    required this.isFromNetwork,
    this.imageFile,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: KondusAppBar(
        backButtonColor: context.whiteColor,
        backgroundColor: AppColors.primary,
      ),
      body: isFromNetwork
          ? _NetworkPhotoViewer(imagePath: imagePath!)
          : PhotoView(
              imageProvider: FileImage(imageFile!),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 1.8,
              initialScale: PhotoViewComputedScale.contained,
            ),
    );
  }
}

class _NetworkPhotoViewer extends StatelessWidget {
  const _NetworkPhotoViewer({required this.imagePath});

  final String imagePath;

  String _getImageUrl(String imagePath) {
    const baseUrl = EnvrionmentConstants.baseUrl;
    return '$baseUrl/items/images/$imagePath';
  }

  @override
  Widget build(BuildContext context) {
    final tokenRepository = GetIt.I<ITokenRepository>();

    return FutureBuilder<String?>(
      future: tokenRepository.getAccessToken(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final token = snapshot.data;

        return PhotoView(
          imageProvider: NetworkImage(
            _getImageUrl(imagePath),
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
          initialScale: PhotoViewComputedScale.contained,
          loadingBuilder: (context, event) =>
              const Center(child: CircularProgressIndicator()),
          errorBuilder: (context, error, stackTrace) =>
              const Center(child: Icon(Icons.broken_image)),
        );
      },
    );
  }
}
