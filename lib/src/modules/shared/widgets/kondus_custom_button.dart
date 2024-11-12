import 'package:flutter/material.dart';

class KondusCustomButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final String label;
  final double? height;
  final double? width;
  final TextStyle? textStyle;

  const KondusCustomButton({
    required this.onPressed,
    this.label = '',
    this.height,
    this.width,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff05ACC1),
        ),
        child:  Text(
          label,
          style: textStyle ?? const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}