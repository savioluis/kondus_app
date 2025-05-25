import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class OverlayHelper {
  static void showSuccessOverlay({
    required BuildContext context,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onFinish,
  }) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    late final OverlayEntry overlayEntry;
    late final AnimationController controller;

    controller = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    );

    overlayEntry = OverlayEntry(
      builder: (context) => FadeTransition(
        opacity: CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
        child: const Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: Center(child: _CenteredSuccessWidget()),
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(overlayEntry);
    controller.forward();

    Future.delayed(duration, () async {
      await controller.reverse();
      overlayEntry.remove();
      controller.dispose();
      if (onFinish != null) {
        onFinish();
      }
    });
  }
}

class _CenteredSuccessWidget extends StatelessWidget {
  const _CenteredSuccessWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.blueColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.check_circle,
            size: 96,
            color: context.whiteColor,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: context.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'ANUNCIADO COM SUCESSO',
              textAlign: TextAlign.center,
              style: context.displayLarge!.copyWith(
                fontSize: 28,
                color: context.blueColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
