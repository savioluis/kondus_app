import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

class RegisterTextWidget extends StatelessWidget {
  const RegisterTextWidget({
    required this.message,
    required this.buttonMessage,
    this.onPressed,
    super.key,
  });

  final String message;
  final String buttonMessage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: TextStyle(color: context.primaryColor.withOpacity(0.5)),
        ),
        const SizedBox(width: 2),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Text(
              buttonMessage,
              style: TextStyle(color: context.blueColor),
            ),
          ),
        ),
      ],
    );
  }
}
