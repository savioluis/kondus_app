import 'package:flutter/material.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/theme/app_theme.dart';

class KondusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KondusAppBar({
    this.title,
    this.onBackButtonPressed,
    this.backButtonColor,
    this.actions,
    super.key,
  });

  final String? title;
  final void Function()? onBackButtonPressed;
  final Color? backButtonColor;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: onBackButtonPressed ?? NavigatorProvider.goBack,
        icon: Icon(
          Icons.arrow_back,
          color: backButtonColor ?? context.onSurfaceColor,
        ),
      ),
      elevation: 0,
      backgroundColor: context.surfaceColor,
      surfaceTintColor: context.surfaceColor,
      title: title != null ? Text(title!) : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
