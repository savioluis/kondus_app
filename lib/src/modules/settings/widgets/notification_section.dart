import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

import 'notification_switch_row.dart';

class NotificationSection extends StatefulWidget {
  const NotificationSection({super.key});

  @override
  State<NotificationSection> createState() => _NotificationSectionState();
}

class _NotificationSectionState extends State<NotificationSection> {
  var _switchChat = false;
  var _switchProduct = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Notificações", style: context.titleLarge),
        const SizedBox(height: 10),
        NotificationSwitchRow(
          text: "Chat",
          switchValue: _switchChat,
          onTap: () => setState(() => _switchChat = !_switchChat),
        ),
        const SizedBox(height: 10),
        NotificationSwitchRow(
          text: "Produtos",
          switchValue: _switchProduct,
          onTap: () => setState(() => _switchProduct = !_switchProduct),
        )
      ],
    );
  }
}