import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ItemChip extends StatelessWidget {
  const ItemChip({
    required this.child,
    required this.onTap,
    this.isSelected = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    super.key,
  });

  final Widget child;

  final VoidCallback onTap;
  final bool isSelected;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: child,
        backgroundColor: isSelected
            ? context.blueColor.withOpacity(0.5)
            : backgroundColor ?? context.surfaceColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor ?? context.lightGreyColor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 2),
        labelStyle: TextStyle(
          color: isSelected ? context.whiteColor : textColor ?? context.primaryColor,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
    );
  }
}
