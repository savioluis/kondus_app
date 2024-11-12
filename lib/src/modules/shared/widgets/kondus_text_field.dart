import 'package:flutter/material.dart';

class KondusTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final GlobalKey<FormState>? formKey;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final bool isObscure;
  final bool isEnabled;

  const KondusTextFormField({
    this.formKey,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.sufixIcon,
    this.isObscure = false,
    this.isEnabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      enabled: isEnabled,
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon,
        fillColor: Colors.transparent,
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(width: 1, color: Color(0xff05ACC1)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(width: 1, color: Colors.orange),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(width: 1, color: Color(0xffB0BEC5)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(width: 1, color: Colors.redAccent),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(width: 1, color: Colors.redAccent),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 16, color: Color(0xffB0BEC5)),
      ),
    );
  }
}
