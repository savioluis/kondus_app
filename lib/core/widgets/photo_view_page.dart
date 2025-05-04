import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_data/colors/app_colors.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:photo_view/photo_view.dart';

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

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(imagePath),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 1.8,
      initialScale: PhotoViewComputedScale.contained,
      loadingBuilder: (context, event) =>
          const Center(child: CircularProgressIndicator()),
      errorBuilder: (context, error, stackTrace) => const Center(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: 128,
          ),
          SizedBox(height: 12),
          Text('Erro ao carregar imagem')
        ],
      )),
    );
  }
}
