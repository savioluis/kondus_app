import 'package:flutter/material.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/theme/app_theme.dart';

class KondusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KondusAppBar({
    this.title,
    this.titleWidget,
    this.onBackButtonPressed,
    this.backButtonColor,
    this.actions,
    this.backgroundColor,
    super.key,
  }) : assert(title == null || titleWidget == null,
            'Can not have both title and titleWidget in this Widget');

  final String? title;
  final Widget? titleWidget;
  final void Function()? onBackButtonPressed;
  final Color? backButtonColor;
  final List<Widget>? actions;
  final Color? backgroundColor;

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
      backgroundColor: backgroundColor ?? context.surfaceColor,
      surfaceTintColor: context.surfaceColor,
      title: title != null ? Text(title!) : titleWidget,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
