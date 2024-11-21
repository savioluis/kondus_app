import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

class NotificationButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final double? size;
  final Color? iconColor;
  final Color? borderColor;
  final double? borderWidth;
  final Color? backgroundColor;

  const NotificationButton({
    required this.icon,
    required this.onPressed,
    this.size = 40.0,
    this.iconColor,
    this.borderColor,
    this.borderWidth = 2,
    this.backgroundColor = Colors.transparent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? context.primaryColor.withOpacity(0.12),
          width: borderWidth!,
        ),
      ),
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Icon(
              icon,
              size: size! * 0.65,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
