import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _LoginClipPath(),
      child: Container(
        decoration: BoxDecoration(color: context.blueColor),
        padding: const EdgeInsets.only(left: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: context.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: context.whiteColor,
                fontWeight: FontWeight.normal,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(196);
}

class _LoginClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.6, size.height * 1.2, 0, size.height * 0.9);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
