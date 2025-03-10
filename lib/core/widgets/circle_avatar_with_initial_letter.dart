import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class CircleAvatarWithInitialLetter extends StatelessWidget {
  const CircleAvatarWithInitialLetter({
    required this.username,
    super.key,
  });

  final String username;

  String _getInitials(String username) {
    return username
        .split(' ')
        .where((name) => name.isNotEmpty)
        .take(2)
        .map((name) => name[0].toUpperCase())
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: context.primaryColor.withOpacity(0.08),
      child: Text(
        _getInitials(username),
        style: TextStyle(
          color: context.blueColor,
          fontSize: 24,
        ),
      ),
    );
  }
}
