import 'package:flutter/material.dart';
import 'package:kondus/src/modules/home/widgets/app_bar/header.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    required this.username,
    this.height = 86,
    super.key,
  });

  final String username;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 64),
          child: Header(username: username),
        ),
        const SizedBox(height: 12),
        Divider(
          thickness: 0.1,
          color: context.lightGreyColor,
          height: 2,
        ),
      
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
