import 'package:flutter/material.dart';
import 'package:kondus/app/routers/app_routers.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/src/modules/home/widgets/notification_button.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: kToolbarHeight,
          child: Row(
            children: [
              Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    NavigatorProvider.navigateTo('');
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: context.primaryColor.withOpacity(0.08),
                    child: Text(
                      _getInitials(username),
                      style: TextStyle(
                        color: context.blueColor,
                        fontSize: 24,
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
        ),
        NotificationButton(
          icon: Icons.notifications,
          size: 48,
          iconColor: context.primaryColor.withOpacity(0.5),
          onPressed: () =>
              NavigatorProvider.navigateTo(AppRoutes.notifications),
        )
      ],
    );
  }
}
