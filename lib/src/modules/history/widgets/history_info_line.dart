import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class HistoryInfoLine extends StatelessWidget {
  final Icon icon;
  final String text;
  const HistoryInfoLine({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.5,bottom: 2.5),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 10),
          Text(text, style: context.titleSmall),
        ],
      ),
    );
  }
}
