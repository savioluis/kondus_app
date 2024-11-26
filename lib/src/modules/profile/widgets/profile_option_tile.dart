import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';
import 'package:kondus/src/modules/shared/widgets/header_section.dart';

class ProfileOptionTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subTitle;
  final Function() onTap;
  const ProfileOptionTile(
      {super.key,
      required this.iconData,
      required this.title,
      required this.subTitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(
          children: [
            Icon(
              iconData,
              color: context.blueColor,
              size: 48,
            ),
            const SizedBox(width: 10),
            HeaderSection(
              title: title,
              titleSize: 22,
              subTitleSize: 14,
              subtitle: [
                TextSpan(text: subTitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
