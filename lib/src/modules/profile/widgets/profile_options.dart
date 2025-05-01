import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/auth/session_manager.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      _OptionData(
        icon: HugeIcons.strokeRoundedTags,
        title: 'Seus anúncios',
        subtitle: 'Gerencie seus anúncios ativos',
        onTap: () => NavigatorProvider.navigateTo(AppRoutes.myAnnouncements),
      ),
      _OptionData(
        icon: HugeIcons.strokeRoundedSettings03,
        title: 'Configurações',
        subtitle: 'Ajuste suas preferências',
        onTap: () => NavigatorProvider.navigateTo(AppRoutes.appSettings),
      ),
      _OptionData(
        icon: HugeIcons.strokeRoundedLogout05,
        title: 'Sair',
        subtitle: null,
        onTap: () async {
          final sessionManager = GetIt.instance<SessionManager>();
          await sessionManager.logout();
        },
      ),
    ];

    return Column(
      children: List.generate(options.length, (index) {
        final opt = options[index];
        return Column(
          children: [
            ListTile(
              leading: Icon(opt.icon, color: context.blueColor, size: 24),
              title: Text(
                opt.title,
                style: context.labelMedium!.copyWith(fontSize: 16),
              ),
              subtitle: opt.subtitle != null
                  ? Text(
                      opt.subtitle!,
                      style: context.labelSmall!.copyWith(fontSize: 13),
                    )
                  : null,
              trailing: Icon(
                Icons.chevron_right,
                color: context.blueColor,
              ),
              onTap: opt.onTap,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: context.lightGreyColor.withOpacity(0.07),
            ),
            const SizedBox(height: 12),
          ],
        );
      }),
    );
  }
}

class _OptionData {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  _OptionData({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
  });
}
