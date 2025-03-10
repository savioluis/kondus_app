import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_data/colors/app_colors.dart';

class KondusButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final bool? isPrimary;
  final TextStyle? textStyle;

  const KondusButton({
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.textStyle,
    super.key,
  });

  Color _getColor(Set<WidgetState> states, Color enabledColor, Color disabledColor) {
    return states.contains(WidgetState.disabled) ? disabledColor : enabledColor;
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = context.buttonStyle;
    final backgroundColor = isPrimary! ? context.blueColor : context.yellowColor;
    final foregroundColor = isPrimary! ? context.onPrimaryColor : context.onSecondaryColor;
    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle.copyWith(
        backgroundColor: WidgetStateProperty.resolveWith(
            (states) => _getColor(states, backgroundColor, AppColors.grey.withOpacity(0.12))),
        foregroundColor: WidgetStateProperty.resolveWith(
            (states) => _getColor(states, foregroundColor, AppColors.grey.withOpacity(0.38))),
        overlayColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.pressed) ? AppColors.lightGrey.withOpacity(0.38) : null),
      ),
      child: Text(
        label,
        style: textStyle ??
            TextStyle(
              color: context.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
      ),
    );
  }
}
