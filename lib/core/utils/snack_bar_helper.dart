import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class SnackBarHelper {
  static void showMessageSnackBar({
    required String message,
    required BuildContext context,
    Duration duration = const Duration(seconds: 2),
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: textStyle ??
            TextStyle(
              color: context.onPrimaryColor,
              fontSize: 18,
            ),
      ),
      duration: duration,
      backgroundColor: backgroundColor ?? context.primaryColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
