import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_extension.dart';

import '../../../../core/theme/theme_data/colors/app_colors.dart';

enum ActionType {
  comprar,
  alugar,
  contratar,
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.actionType,
    required this.onTap,
    required this.onButtonPressed,
    super.key,
  });

  final String imageUrl;
  final String name;
  final String category;
  final ActionType actionType;
  final VoidCallback onTap;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: context.primaryColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: context.labelLarge!.copyWith(
                      fontSize: 16,
                      color: context.primaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: context.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // SizedBox(
            //   width: 72,
            //   height: 36,
            //   child: _ActionButton(
            //     actionType: actionType,
            //     onPressed: onButtonPressed,
            //   ),
            // ),
            GestureDetector(
              onTap: onButtonPressed,
              child: Icon(Icons.keyboard_arrow_right, color: context.blueColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.onPressed,
    required this.actionType,
  });

  final ActionType actionType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final Map<ActionType, _ActionProperties> actionProperties = {
      ActionType.comprar: _ActionProperties(
        color: AppColors.lightGrey,
        text: 'Comprar',
      ),
      ActionType.alugar: _ActionProperties(
        color: context.blueColor,
        text: 'Alugar',
      ),
      ActionType.contratar: _ActionProperties(
        color: context.yellowColor,
        text: 'Contratar',
      ),
    };

    final properties = actionProperties[actionType]!;

    return ElevatedButton(
      onPressed: onPressed,
      style: context.buttonStyle.copyWith(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        ),
        minimumSize: const WidgetStatePropertyAll(Size.fromWidth(64)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )),
        backgroundColor:
            WidgetStatePropertyAll(properties.color.withOpacity(0.8)),
      ),
      child: Center(
        child: Text(
          properties.text.toUpperCase(),
          overflow: TextOverflow.fade,
          textAlign: TextAlign.center,
          style: context.textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 10,
            color: context.whiteColor,
          ),
        ),
      ),
    );
  }
}

class _ActionProperties {
  const _ActionProperties({
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;
}
