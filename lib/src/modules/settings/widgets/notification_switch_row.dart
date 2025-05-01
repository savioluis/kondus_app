import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class NotificationSwitchRow extends StatelessWidget {
  final String text;
  final bool switchValue;
  final Function() onTap;

  const NotificationSwitchRow({
    super.key,
    required this.text,
    required this.switchValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                text,
                style: context.bodyLarge,
              ),
            ),
            Switch(
              value: switchValue,
              onChanged: (_) => onTap(),
              activeColor: context.blueColor,
            ),
          ],
        ),
      ),
    );
  }
}
