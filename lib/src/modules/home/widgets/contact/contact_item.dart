import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    required this.name,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.maxNameLength = 12,
    required this.unreadMessagesCount,
    super.key,
  });

  final void Function()? onPressed;
  final String name;
  final Color? backgroundColor;
  final Color? iconColor;
  final int maxNameLength;
  final int unreadMessagesCount;  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onPressed,
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: backgroundColor,
                  child: Icon(
                    Icons.person,
                    size: 44,
                    color: iconColor,
                  ),
                ),
              ),
            ),
            if (unreadMessagesCount > 0)
              Container(
                width: 22,
                height: 22,
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  border: Border.all(color: context.lightGreyColor),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  unreadMessagesCount > 9 ? '9+' : '$unreadMessagesCount',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          name.length > maxNameLength
              ? '${name.substring(0, maxNameLength)}…'
              : name,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
