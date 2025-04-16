import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_data/colors/app_colors.dart';
import 'package:kondus/core/utils/snack_bar_helper.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  final File imageFile;
  const PhotoViewPage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: KondusAppBar(
        backButtonColor: context.whiteColor,
        backgroundColor: AppColors.primary,
      ),
      body: PhotoView(
        imageProvider: FileImage(imageFile),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 1.8,
        initialScale: PhotoViewComputedScale.contained,
        
      ),
    );
  }
}
