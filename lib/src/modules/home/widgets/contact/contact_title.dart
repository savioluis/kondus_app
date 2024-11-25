import 'package:flutter/material.dart';

class ContactTitle extends StatelessWidget {
  const ContactTitle({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Ultimas conversas',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.subdirectory_arrow_right,
            size: 14,
          )
        ],
      ),
    );
  }
}
