import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    required this.name,
    super.key,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 25,
              backgroundColor: context.primaryColor.withOpacity(0.08),
              child: Text('P'),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(name)
      ],
    );
  }
}
