import 'package:flutter/material.dart';

class KondusChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  const KondusChipWidget({
    required this.label,
    required this.onPressed,
    this.textStyle,
    this.buttonStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
      style: ElevatedButton.styleFrom(),
    );
  }
}
