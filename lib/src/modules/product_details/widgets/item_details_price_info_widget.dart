import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/src/modules/home/widgets/item_card.dart';

class ItemDetailsPriceInfoWidget extends StatelessWidget {
  const ItemDetailsPriceInfoWidget({
    required this.price,
    required this.quantity,
    required this.actionType,
    super.key,
  });

  final double price;
  final int quantity;
  final String actionType;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: context.lightGreyColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.lightGreyColor.withOpacity(0.4))
              ),
              child: Column(
                children: [
                  if (quantity > 0) ...[
                    Text(
                      quantity.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      quantity > 1 ? 'disponíveis' : 'disponível',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ] else ...[
                    if (actionType.toLowerCase() !=
                        ActionType.alugar.toJsonValue())
                      const Text(
                        'ESGOTADO',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else
                      const Text(
                        'DISPONÍVEL',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ]
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: context.blueColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.blueColor.withOpacity(0.4))
            ),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: context.primaryColor),
                children: [
                  TextSpan(
                    text: 'R\$ ',
                    style: context.displayMedium!.copyWith(fontSize: 12),
                  ),
                  TextSpan(
                    text: price.toStringAsFixed(2),
                    style: context.headlineMedium!.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}