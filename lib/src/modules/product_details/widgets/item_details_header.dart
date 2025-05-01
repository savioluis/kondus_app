import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_data/colors/app_colors.dart';

class ItemDetailsHeader extends StatelessWidget {
  const ItemDetailsHeader({
    required this.name,
    required this.type,
    required this.actionType,
    super.key,
  });

  final String name;
  final String type;
  final String actionType;

  static const _typeEmoji = {
    'serviço': '🤝',
    'produto': '📦',
  };

  String _getTypeEmoji() {
    return _typeEmoji[type.toLowerCase()] ?? '❓';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: context.headlineLarge!.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 8),
              Text(
                '${_getTypeEmoji()}${type[0].toUpperCase()}${type.substring(1)}',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: _buildActionTypeChip(context, actionType),
        ),
      ],
    );
  }
}

// Widget _buildActionTypeChip(String actionType) {
//   final colors = {
//     'Comprar': Colors.green,
//     'Alugar': Colors.orange,
//     'Contratar': Colors.blue,
//   };

//   final chipColor = colors[actionType] ?? AppColors.lightGrey;

//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     decoration: BoxDecoration(
//       color: chipColor.withOpacity(0.2),
//       border: Border.all(color: chipColor),
//       borderRadius: BorderRadius.circular(16),
//     ),
//     child: Text(
//       maxLines: 1,
//       actionType.toUpperCase(),
//       style: TextStyle(
//         color: chipColor,
//         fontSize: 14,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   );
// }

Widget _buildActionTypeChip(BuildContext context, String actionType) {
  final colors = {
    'Comprar': Colors.green,
    'Alugar': Colors.orange,
    'Contratar': Colors.blue,
  };

  final chipColor = colors[actionType] ?? AppColors.lightGrey;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: chipColor.withOpacity(0.15),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      actionType.toUpperCase(),
      style: context.labelSmall!.copyWith(
        color: chipColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    ),
  );
}
