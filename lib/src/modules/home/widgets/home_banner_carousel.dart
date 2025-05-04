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
    const _BannerData(
      emoji: "🤝",
      title: "Combine tudo pelo chat!",
      text:
          "Converse com o vizinho sobre retirada, entrega e horário ideal. Tudo direto no app.",
    ),
    const _BannerData(
      emoji: "🛠️",
      title: "Evite compras desnecessárias!",
      text:
          "Alugue ou peça emprestado de quem mora perto. Mais econômico e sustentável.",
    ),
    const _BannerData(
      emoji: "🍰",
      title: "Bolos, docinhos e mais!",
      text:
          "Encontre vizinhos que vendem delícias caseiras no app e compre direto deles.",
    ),
    const _BannerData(
      emoji: "💬",
      title: "Negociação sem complicação",
      text:
          "Use o chat para ajustar preços, entrega ou dúvidas antes da contratação.",
    ),
    const _BannerData(
      emoji: "📍",
      title: "Retire ou receba em casa!",
      text:
          "Combine com o vizinho a forma de entrega mais prática pra vocês dois.",
    ),
  ]
    ..shuffle()
    ..insert(
      0,
      _BannerData(
        emoji: "📢",
        title: "Tem algo pra oferecer?",
        text:
            "Anuncie seu produto ou serviço e ganhe visibilidade no condomínio!",
        onPressed: () => NavigatorProvider.navigateTo(
          AppRoutes.shareYourItems,
          arguments: RouteArguments<VoidCallback?>(null),
        ),
      ),
    );
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.89);

    // _autoScrollTimer = Timer.periodic(const Duration(seconds: 7), (timer) {
    //   final nextPage = (_currentPage + 1) % _banners.length;

    //   _pageController.animateToPage(
    //     nextPage,
    //     duration: const Duration(milliseconds: 800),
    //     curve: Curves.easeInOut,
    //   );
    // });

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
    return Column(
      children: [
        SizedBox(
          height: 196,
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
                          color: context.lightGreyColor.withOpacity(0.18)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: InkWell(
                      onTap: banner.onPressed,
                      borderRadius: BorderRadius.circular(18),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              banner.emoji,
                              style: const TextStyle(fontSize: 28),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              banner.title,
                              style: context.titleMedium!.copyWith(
                                fontSize: 21,
                                color: context.blueColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              banner.text,
                              style: context.labelSmall!.copyWith(fontSize: 14),
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
              width: _currentPage == index ? 10 : 8,
              height: _currentPage == index ? 10 : 8,
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
