import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

class KondusTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final GlobalKey<FormState>? formKey;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final Color? prefixIconColor;
  final Color? sufixIconColor;
  final bool isObscure;
  final bool isEnabled;
  final bool? isFilled;
  final Color? fillColor;
  final Function(String)? onChanged;
  final InputDecoration? decoration;
  final int maxLines;

  const KondusTextFormField({
    this.formKey,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.sufixIcon,
    this.isObscure = false,
    this.isEnabled = true,
    this.isFilled,
    this.fillColor,
    this.prefixIconColor,
    this.sufixIconColor,
    this.onChanged,
    this.decoration,
    this.maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      enabled: isEnabled,
      controller: controller,
      obscureText: isObscure,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: decoration ?? context.textFieldDecoration.copyWith(
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor ?? context.secondaryColor,
        suffixIcon: sufixIcon,
        suffixIconColor: sufixIconColor ?? context.secondaryColor,
        hintText: hintText,
        hintStyle: context.titleMedium!
            .copyWith(color: context.lightGreyColor.withOpacity(0.5)),
        filled: isFilled,
        fillColor: fillColor,
        
      ),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
