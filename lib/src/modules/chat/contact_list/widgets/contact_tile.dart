import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';
import 'package:kondus/src/modules/shared/widgets/circle_avatar_with_initial_letter.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final String apartment;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const ContactTile({
    required this.name,
    required this.apartment,
    required this.onTap,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatarWithInitialLetter(username: name),
          title: Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          contentPadding: const EdgeInsets.only(right: 8),
          subtitle: Text(apartment),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: context.blueColor,
          ),
          onTap: onTap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        Divider(
          thickness: 0.1,
          color: context.lightGreyColor,
        ),
      ],
    );
  }
}
