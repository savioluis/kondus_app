import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/header_section.dart';

class RegisterItemAppbarStep2 extends StatelessWidget
    implements PreferredSizeWidget {
  const RegisterItemAppbarStep2({
    required this.itemName,
    this.isOnlyItem = true,
    this.itemType,
    super.key,
  });

  final bool isOnlyItem;
  final ItemType? itemType;
  final String itemName;

  String _getContentTypeValue() {
    if (isOnlyItem) return 'item';
    if (itemType == null) return '';
    if (itemType == ItemType.servico) return 'serviço';
    return 'produto';
  }

  @override
  Widget build(BuildContext context) {
    final String contentTypeValue = _getContentTypeValue();

    return Material(
      color: context.surfaceColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: NavigatorProvider.goBack,
              icon: Icon(
                Icons.arrow_back,
                color: context.onSurfaceColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: HeaderSection(
                title: 'Insira os detalhes do seu $contentTypeValue',
                titleSize: 30,
                subtitle: const [
                  TextSpan(text: '🚀 Finalize os detalhes para '),
                  TextSpan(
                    text: 'anunciar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: context.blueColor.withOpacity(0.2),
                  border: Border.all(color: context.blueColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Text(
                  '✅$itemName',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: context.blueColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(216);
}
