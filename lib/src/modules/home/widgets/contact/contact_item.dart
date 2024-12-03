import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    required this.name,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.maxNameLength = 12,
    super.key,
  });

  final void Function()? onPressed;
  final String name;
  final Color? backgroundColor;
  final Color? iconColor;
  final int maxNameLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: CircleAvatar(
              radius: 38,
              backgroundColor: backgroundColor,
              child: Icon(
                Icons.person,
                size: 48,
                color: iconColor,
              ),
            ),
          ),
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
