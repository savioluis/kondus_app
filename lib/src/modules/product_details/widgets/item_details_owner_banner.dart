import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ItemDetailsOwnerBanner extends StatelessWidget {
  const ItemDetailsOwnerBanner({
    required this.ownerName,
    required this.ownerComplement,
    super.key,
  });

  final String ownerName;
  final String ownerComplement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.lightGreyColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: context.lightGreyColor.withOpacity(0.2),
            radius: 32,
            child: Text(
              ownerName[0].toUpperCase(),
              style: TextStyle(
                color: context.blueColor,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(width: 18),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ownerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ownerComplement,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
