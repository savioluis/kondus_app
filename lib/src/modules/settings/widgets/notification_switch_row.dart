import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class NotificationSwitchRow extends StatelessWidget {
  final String text;
  final bool switchValue;
  final Function() onTap;
  const NotificationSwitchRow(
      {super.key,
        required this.text,
        required this.switchValue,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: context.titleMedium,
          ),
          Switch(
            value: switchValue,
            onChanged: (_) => onTap(),
          ),
        ],
      ),
    );
  }
}
