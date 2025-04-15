import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ItemChip extends StatelessWidget {
  const ItemChip({
    required this.text,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(text.toUpperCase()),
        backgroundColor: isSelected ? context.blueColor : context.surfaceColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: context.lightGreyColor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        labelStyle: TextStyle(
          color: isSelected ? context.whiteColor : context.primaryColor,
        ),
      ),
    );
  }
}
