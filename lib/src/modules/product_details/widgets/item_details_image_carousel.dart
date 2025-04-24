import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/authenticated_image_widget.dart';
import 'package:kondus/core/widgets/photo_view_page.dart';

class ItemDetailsImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double size;
  final double radius;
  final double spaceBetweenImages;

  const ItemDetailsImageCarousel({
    required this.imageUrls,
    this.size = 256,
    this.radius = 8,
    this.spaceBetweenImages = 1.25,
    super.key,
  });

  @override
  State<ItemDetailsImageCarousel> createState() =>
      _ItemDetailsImageCarouselState();
}

class _ItemDetailsImageCarouselState extends State<ItemDetailsImageCarousel> {
  late final PageController _carouselController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _carouselController =
        PageController(viewportFraction: widget.spaceBetweenImages);
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  @override
  Widget build(BuildContext context) {
    final imageUrls = widget.imageUrls;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.size,
          width: double.infinity,
          child: PageView.builder(
            controller: _carouselController,
            itemCount: imageUrls.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final url = imageUrls[index];
              return FractionallySizedBox(
                widthFactor: 1 / _carouselController.viewportFraction,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoViewPage(
                          isFromNetwork: true,
                          imagePath: url,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.radius),
                    child: AuthenticatedImage(
                      imagePath: url,
                      size: widget.size,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageUrls.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 12 : 10,
              height: _currentPage == index ? 12 : 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? context.blueColor
                      : context.lightGreyColor,
                  border: Border.all(color: context.lightGreyColor, width: 1)),
            ),
          ),
        ),
      ],
    );
  }
}
