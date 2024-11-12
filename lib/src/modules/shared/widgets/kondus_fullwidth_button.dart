import 'package:flutter/material.dart';

class KondusFillWidthButton extends StatelessWidget {

  final String label;
  final double height;
  final TextStyle? textStyle;

  const KondusFillWidthButton({
    this.label = '',
    this.height = 48,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff05ACC1),
        ),
        child:  Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}