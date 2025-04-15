import 'package:flutter/material.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/header_section.dart';

class RegisterItemAppbarStep2 extends StatelessWidget
    implements PreferredSizeWidget {
  const RegisterItemAppbarStep2({this.isOnlyItem = true, this.itemType, super.key});

  final bool isOnlyItem;
  final ItemType? itemType;

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
                subtitle: [
                  const TextSpan(text: '🚀 Finalize os detalhes para '),
                  TextSpan(
                    text: 'anunciar',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(164);
}
