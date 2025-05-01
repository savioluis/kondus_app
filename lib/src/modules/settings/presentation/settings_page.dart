import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/src/modules/profile/widgets/profile_option_tile.dart';
import 'package:kondus/src/modules/settings/widgets/theme_section.dart';
import 'package:kondus/core/widgets/header_section.dart';

import '../widgets/notification_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KondusAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const HeaderSection(
            title: "Configurações",
            subtitle: [
              TextSpan(text: "Ajuste suas preferências e configurações")
            ],
          ),
          const SizedBox(height: 32),
          _SettingsOptionTile(
            iconData: HugeIcons.strokeRoundedStarSquare,
            title: "Aparência",
            subtitle: "Defina o tema da aplicação",
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const Padding(
                  padding: EdgeInsets.all(24),
                  child: ThemeSection(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _SettingsOptionTile(
            iconData: HugeIcons.strokeRoundedNotification03,
            title: "Notificações",
            subtitle: "Controle os alertas recebidos",
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const Padding(
                  padding: EdgeInsets.all(24),
                  child: NotificationSection(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsOptionTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsOptionTile({
    required this.iconData,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.lightGreyColor.withOpacity(0.08),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              Icon(iconData, size: 28, color: context.blueColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.labelMedium!.copyWith(fontSize: 16),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: context.labelSmall!.copyWith(fontSize: 13),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.expand_more,
                color: context.blueColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
