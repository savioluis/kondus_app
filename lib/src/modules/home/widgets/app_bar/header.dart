import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/src/modules/home/widgets/notification_button.dart';
import 'package:kondus/core/theme/app_theme.dart';

class Header extends StatelessWidget {
  const Header({
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
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        children: [
          Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                NavigatorProvider.navigateTo(AppRoutes.profile);
              },
              child: CircleAvatar(
                radius: 28,
                backgroundColor: context.lightGreyColor.withOpacity(0.18),
                child: Text(
                  _getInitials(username),
                  style: TextStyle(
                    color: context.blueColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Bem-vindo,'),
              Text(
                username,
                style: TextStyle(
                  color: context.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
