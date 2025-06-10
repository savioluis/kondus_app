import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/repositories/welcome_slides/welcome_slides_repository.dart';
import 'package:kondus/core/theme/app_theme.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final slides = const WelcomeSlidesRepository().getWelcomeSlides()..shuffle();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < slides.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      NavigatorProvider.navigateTo(AppRoutes.login);
    }
  }

  void _skip() async {
    NavigatorProvider.navigateTo(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: context.lightGreyColor, width: 0.2),
          ),
        ),
        child: SafeArea(
          bottom: true,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _skip,
                  child: Text(
                    'Pular',
                    style: context.bodyMedium?.copyWith(
                        color: context.primaryColor.withOpacity(0.5)),
                  ),
                ),
                TextButton(
                  onPressed: _nextPage,
                  child: Text(
                    _currentIndex == slides.length - 1 ? 'Começar' : 'Próximo',
                    style: context.bodyLarge
                        ?.copyWith(color: context.blueColor, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: PageView.builder(
              controller: _controller,
              itemCount: slides.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final slide = slides[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.blueColor.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          slide.emoji,
                          style: const TextStyle(fontSize: 72),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Text(
                        slide.title,
                        style: context.titleLarge?.copyWith(
                          color: context.blueColor,
                          fontSize: 28,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        slide.subtitle,
                        style: context.bodyMedium?.copyWith(
                          fontSize: 20,
                          color: context.greyColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentIndex == index ? 12 : 8,
                  height: _currentIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: context.lightGreyColor, width: 1),
                    color: _currentIndex == index
                        ? context.blueColor
                        : context.lightGreyColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
