import 'package:flutter/material.dart';
import 'package:kondus/src/modules/home/widgets/app_bar/header.dart';
import 'package:kondus/core/theme/app_theme.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    required this.username,
    this.height = 96,
    super.key,
  });

  final String username;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.surfaceColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 6,
            ),
            child: Header(username: username),
          ),
          const SizedBox(height: 12),
          Divider(
            thickness: 0.1,
            color: context.lightGreyColor,
            height: 2,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
