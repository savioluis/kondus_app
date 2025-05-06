import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_data/colors/app_colors.dart';

class KondusButton extends StatelessWidget {
  final String? label;
  final void Function()? onPressed;
  final bool? isPrimary;
  final TextStyle? textStyle;
  final bool isLoading;
  
  final Icon? icon;
  final double? spaceFromIcon;

  final Color? backgroundColor;

  const KondusButton({
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.textStyle,
    this.isLoading = false,
    this.icon,
    this.spaceFromIcon = 12,
    this.backgroundColor,
    super.key,
  });

  const KondusButton.loading({super.key})
      : label = null,
        onPressed = null,
        isPrimary = true,
        textStyle = null,
        icon = null,
        spaceFromIcon = null,
        backgroundColor = null,
        isLoading = true;

  Color _getColor(
      Set<WidgetState> states, Color enabledColor, Color disabledColor) {
    return states.contains(WidgetState.disabled) ? disabledColor : enabledColor;
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = context.buttonStyle;
    final backgroundColor = this.backgroundColor ??
        (isPrimary! ? context.blueColor : context.yellowColor);
    final foregroundColor =
        isPrimary! ? context.onPrimaryColor : context.onSecondaryColor;
    final hasIcon = icon != null;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle.copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) => _getColor(
            states, backgroundColor, AppColors.grey.withOpacity(0.12))),
        foregroundColor: WidgetStateProperty.resolveWith((states) => _getColor(
            states, foregroundColor, AppColors.grey.withOpacity(0.38))),
        overlayColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.pressed)
                ? AppColors.lightGrey.withOpacity(0.38)
                : null),
      ),
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : hasIcon
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon!,
                    SizedBox(width: spaceFromIcon),
                    Text(
                      label ?? '',
                      style: textStyle ??
                          TextStyle(
                            color: context.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                  ],
                )
              : Text(
                  label ?? '',
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
