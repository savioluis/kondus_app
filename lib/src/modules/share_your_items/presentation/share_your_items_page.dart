import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/src/modules/share_your_items/widgets/item_chip.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_extension.dart';
import 'package:kondus/core/widgets/header_section.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';

class ShareYourItemsPage extends StatefulWidget {
  const ShareYourItemsPage({super.key});

  @override
  State<ShareYourItemsPage> createState() => _ShareYourItemsPageState();
}

class _ShareYourItemsPageState extends State<ShareYourItemsPage> {
  final items = [
    {"name": "Reparo de ar condicionado", "type": ItemType.servico},
    {"name": "Aspirador", "type": ItemType.produto},
    {"name": "Chave de Fenda", "type": ItemType.produto},
    {"name": "Personal Trainer", "type": ItemType.servico},
    {"name": "Aula Particular", "type": ItemType.servico},
    {"name": "Cortador de Grama", "type": ItemType.produto},
    {"name": "Escada", "type": ItemType.produto},
    {"name": "Furadeira", "type": ItemType.produto}
  ]..shuffle();

  Map<String, Object>? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KondusAppBar(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextButton(
                onPressed: () => NavigatorProvider.navigateTo(
                  AppRoutes.registerItemStep1,
                  arguments: RouteArguments<List<dynamic>>([null, null]),
                ),
                child: Text(
                  'Pular Etapa',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.lightGreyColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: 148,
                child: KondusButton(
                  label: 'ANUNCIAR',
                  onPressed: selectedItem != null
                      ? () {
                          final selectedItemName =
                              selectedItem!['name'] as String;
                          final selectedItemType =
                              selectedItem!['type'] as ItemType;

                          NavigatorProvider.navigateTo(
                            AppRoutes.registerItemStep1,
                            arguments: RouteArguments<List<dynamic>>(
                              [selectedItemType, selectedItemName],
                            ),
                          );
                        }
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(
                titleSize: 32,
                subTitleSize: 16,
                title:
                    'Você possui algum desses itens para compartilhar com seus vizinhos?',
                subtitle: [
                  TextSpan(text: '🎁 Compartilhe seus '),
                  TextSpan(
                    text: 'serviços ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: 'e '),
                  TextSpan(
                    text: 'produtos',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  ...items.map((item) {
                    final itemName = item['name']! as String;
                    return ItemChip(
                      text: itemName,
                      isSelected:
                          selectedItem?.containsValue(itemName) ?? false,
                      onTap: () {
                        setState(() {
                          if (selectedItem?.containsValue(itemName) ?? false) {
                            selectedItem = null;
                          } else {
                            selectedItem = item;
                          }
                        });
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
