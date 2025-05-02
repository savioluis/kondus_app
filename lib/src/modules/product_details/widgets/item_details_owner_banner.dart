import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ItemDetailsOwnerBanner extends StatelessWidget {
  const ItemDetailsOwnerBanner({
    required this.name,
    required this.house,
    required this.local,
    super.key,
  });

  final String name;
  final String house;
  final String local;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: context.lightGreyColor.withOpacity(0.2),
              radius: 20,
              child: Text(
                name[0].toUpperCase(),
                style: TextStyle(
                  color: context.blueColor,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 18),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    'Morador(a)',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    HugeIcons.strokeRoundedLocation04,
                    size: 18,
                    color: context.blueColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    local,
                    style: context.labelSmall!.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    HugeIcons.strokeRoundedPinLocation03,
                    size: 18,
                    color: context.blueColor,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      house,
                      style: context.labelSmall!.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
