import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_switch_row.dart';

class NotificationSection extends StatefulWidget {
  const NotificationSection({super.key});

  @override
  State<NotificationSection> createState() => _NotificationSectionState();
}

class _NotificationSectionState extends State<NotificationSection> {
  static const _isChatNotificationsEnabledKey = 'is_chat_notifications_enabled';
  late bool _isChatNotificationsEnabledValue;

  bool _isInitialized = false;

  Future<void> _loadChatPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isChatNotificationsEnabledValue =
        prefs.getBool(_isChatNotificationsEnabledKey) ?? false;

    setState(() => _isInitialized = true);
  }

  Future<void> _toggleChatNotification() async {
    final newValue = !_isChatNotificationsEnabledValue;

    setState(() => _isChatNotificationsEnabledValue = newValue);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isChatNotificationsEnabledKey, newValue);
  }

  @override
  void initState() {
    super.initState();
    _loadChatPreference();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Notificações", style: context.titleLarge),
          const SizedBox(height: 16),
          NotificationSwitchRow(
            text: "Chat",
            switchValue: _isChatNotificationsEnabledValue,
            onTap: _toggleChatNotification,
          ),
        ],
      ),
    );
  }
}
