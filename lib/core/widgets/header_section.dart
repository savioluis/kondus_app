import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class HeaderSection extends StatelessWidget {
  final String title;
  final List<TextSpan>? subtitle;
  final double? titleSize;
  final double? subTitleSize;
  final double? spaceBetween;

  const HeaderSection({
    required this.title,
    this.subtitle,
    this.titleSize,
    this.subTitleSize,
    this.spaceBetween,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: titleSize ?? 34,
              color: context.primaryColor,
            ),
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: spaceBetween ?? 2),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: subTitleSize ?? 16,
                color: context.secondaryColor,
              ),
              children: subtitle,
            ),
          ),
        ]
      ],
    );
  }
}
