import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kondus/src/modules/profile/domain/profile_model.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ProfileBanner extends StatelessWidget {
  final ProfileModel model;
  const ProfileBanner({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double nameSize = model.owner.length > 10 ? 30 : 36;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: context.lightGreyColor.withOpacity(0.18),
                child: Text(
                  _getInitials(model.owner),
                  style: TextStyle(
                    color: context.blueColor,
                    fontSize: 35,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.owner,
                      style: context.bodyLarge!.copyWith(fontSize: nameSize),
                    ),
                    Text(
                      'Morador(a)',
                      style: context.bodyMedium!.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Row(
            children: [
              Icon(
                HugeIcons.strokeRoundedLocation04,
                size: 18,
                color: context.blueColor,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  model.local,
                  style: context.labelSmall!.copyWith(
                    fontSize: 15,
                  ),
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
                  model.house,
                  style: context.labelSmall!.copyWith(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

String _getInitials(String username) {
  return username
      .split(' ')
      .where((name) => name.isNotEmpty)
      .take(2)
      .map((name) => name[0].toUpperCase())
      .join();
}
