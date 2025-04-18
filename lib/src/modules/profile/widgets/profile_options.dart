import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/services/auth/session_manager.dart';
import 'package:kondus/src/modules/profile/widgets/profile_option_tile.dart';
import 'package:kondus/core/theme/app_theme.dart';

import '../../../../core/providers/navigator/navigator_provider.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 0.5, color: context.lightGreyColor),
        ProfileOptionTile(
          iconData: Icons.shopping_bag_outlined,
          title: "Seus anúncios",
          subTitle: "Gerencie seus anúncios ativos no app",
          onTap: () {
            NavigatorProvider.navigateTo(AppRoutes.myAnnouncements);
          },
        ),
        Divider(thickness: 0.5, color: context.lightGreyColor),
        ProfileOptionTile(
          iconData: Icons.settings_outlined,
          title: "Configurações",
          subTitle: "Ajuste suas preferências e configurações",
          onTap: () {
            NavigatorProvider.navigateTo(AppRoutes.appSettings);
          },
        ),
        Divider(thickness: 0.5, color: context.lightGreyColor),
        ProfileOptionTile(
          iconData: Icons.logout_outlined,
          title: "Sair",
          onTap: () async {
            final sessionManager = GetIt.instance<SessionManager>();
            await sessionManager.logout();
          },
        ),
        Divider(thickness: 0.5, color: context.lightGreyColor),
      ],
    );
  }
}
