import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_data/colors/color_utils.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key});

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  late final PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  final _banners = [
    _BannerData(
      emoji: "🔍",
      title: "Encontre o que precisa!",
      text:
          "Busque produtos e serviços no condomínio de forma rápida e fácil.",
      onPressed: () => NavigatorProvider.navigateTo(AppRoutes.searchProducts),
    ),
    _BannerData(
      emoji: "📢",
      title: "Anuncie agora!",
      text:
          "Contribua para o seu condomínio anunciando produtos ou serviços e ajude seus vizinhos.",
      onPressed: () => NavigatorProvider.navigateTo(
        AppRoutes.shareYourItems,
        arguments: RouteArguments<VoidCallback?>(null),
      ),
    ),
    _BannerData(
      emoji: "✏️",
      title: "Gerencie seus anúncios",
      text: "Acompanhe o que você publicou e remova quando quiser.",
      onPressed: () => NavigatorProvider.navigateTo(AppRoutes.myAnnouncements),
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.89);

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 12), (timer) {
      final nextPage = (_currentPage + 1) % _banners.length;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        final emojiFontSize = maxWidth * 0.06;
        final titleFontSize = maxWidth * 0.05;
        final contentFontSize = maxWidth * 0.035;
        final bannerHeight = maxWidth * 0.55;

        final selectedDotIndicatorSize = maxWidth * 0.025;
        final unselectedDotIndicatorSize = maxWidth * 0.020;

        return Column(
          children: [
            SizedBox(
              height: bannerHeight,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _banners.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final banner = _banners[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorUtils.generateTonalColors(
                            count: _banners.length,
                            saturationRange: 0.01,
                            baseColor: context.lightGreyColor,
                          )[index]
                              .withOpacity(0.09),
                          border: Border.all(
                            color: context.lightGreyColor.withOpacity(0.36),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: InkWell(
                          onTap: banner.onPressed,
                          borderRadius: BorderRadius.circular(18),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(banner.emoji,
                                    style: TextStyle(fontSize: emojiFontSize)),
                                const SizedBox(height: 8),
                                Text(
                                  banner.title,
                                  style: context.titleMedium!.copyWith(
                                    fontSize: titleFontSize,
                                    color: context.blueColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  banner.text,
                                  style: context.labelSmall!.copyWith(
                                    fontSize: contentFontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                _banners.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index
                      ? selectedDotIndicatorSize
                      : unselectedDotIndicatorSize,
                  height: _currentPage == index
                      ? selectedDotIndicatorSize
                      : unselectedDotIndicatorSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? context.blueColor
                        : context.lightGreyColor,
                    border: Border.all(color: context.lightGreyColor, width: 1),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BannerData {
  final String emoji;
  final String title;
  final String text;
  final VoidCallback? onPressed;

  const _BannerData({
    required this.emoji,
    required this.title,
    required this.text,
    this.onPressed,
  });
}
