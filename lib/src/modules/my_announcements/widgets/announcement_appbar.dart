import 'package:flutter/material.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/header_section.dart';

class AnnouncementAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const AnnouncementAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.surfaceColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: NavigatorProvider.goBack,
              icon: Icon(
                Icons.arrow_back,
                color: context.onSurfaceColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: HeaderSection(
                title: 'Seus anúncios',
                subtitle: [
                  TextSpan(
                    text: 'Gerencia seus itens anúncios ativos',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(128);
}
