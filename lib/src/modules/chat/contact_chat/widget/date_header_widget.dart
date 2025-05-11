import 'package:flutter/material.dart';

class DateHeaderWidget extends StatelessWidget {
  final DateTime date;

  const DateHeaderWidget({required this.date, super.key});

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final target = DateTime(date.year, date.month, date.day);

    if (target == today) return 'Hoje';
    if (target == yesterday) return 'Ontem';

    final months = [
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];

    final day = target.day;
    final month = months[target.month - 1];
    final year = target.year;

    return '$day de $month de $year';
  }

  @override
  Widget build(BuildContext context) {
    final label = _formatDate(date);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
