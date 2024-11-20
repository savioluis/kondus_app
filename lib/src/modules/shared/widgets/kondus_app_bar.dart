import 'package:flutter/material.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

class KondusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KondusAppBar({
    this.title,
    this.onBackButtonPressed,
    super.key,
  });

  final String? title;
  final void Function()? onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: onBackButtonPressed ?? NavigatorProvider.goBack,
        icon: Icon(
          Icons.arrow_back,
          color: context.onSurfaceColor,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: title != null ? Text(title!) : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}