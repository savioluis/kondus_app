import 'package:flutter/material.dart';
import 'package:kondus/src/modules/profile/widgets/profile_option_tile.dart';
import 'package:kondus/core/theme/app_theme.dart';

import '../../../../app/routers/app_routers.dart';
import '../../../../core/providers/navigator/navigator_provider.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 0.5, color: context.lightGreyColor),
        ProfileOptionTile(
          iconData: Icons.apartment,
          title: "Seu condomínio",
          subTitle: "Veja as informações do seu condomínio",
          onTap: () {},
        ),
        Divider(thickness: 0.5, color: context.lightGreyColor),
        ProfileOptionTile(
          iconData: Icons.shopping_bag_outlined,
          title: "Histórico",
          subTitle: "Veja o registro do seu histórico",
          onTap: () {
            NavigatorProvider.navigateTo(AppRoutes.history);
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
      ],
    );
  }
}
