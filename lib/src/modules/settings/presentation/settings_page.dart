import 'package:flutter/material.dart';
import 'package:kondus/src/modules/settings/widgets/theme_section.dart';
import 'package:kondus/core/widgets/header_section.dart';

import '../widgets/notification_section.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(
              title: "Configurações",
              subtitle: [
                TextSpan(text: "Ajuste suas preferências e configurações")
              ],
            ),
            SizedBox(height: 40),
            ThemeSection(),
            SizedBox(height: 25),
            NotificationSection()
          ],
        ),
      ),
    );
  }
}