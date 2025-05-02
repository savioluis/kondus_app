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
  const ShareYourItemsPage({super.key, required this.onSkipPressed});

  final VoidCallback? onSkipPressed;

  @override
  State<ShareYourItemsPage> createState() => _ShareYourItemsPageState();
}

class _ShareYourItemsPageState extends State<ShareYourItemsPage> {
  final items = [
    {
      "name": "Reparo de ar condicionado",
      "type": ItemType.servico,
      "description":
          "Serviço de manutenção, limpeza e conserto de ar-condicionado. Atendo modelos do tipo [split/janela/inverter]. Com garantia e agendamento flexível.",
      "categoriesIds": [1, 3],
      "actionType": "Serviço",
    },
    {
      "name": "Aspirador",
      "type": ItemType.produto,
      "description":
          "Aspirador portátil ideal para limpeza doméstica ou automotiva. Equipamento em [digite aqui a condição]. Fácil de usar e com bom desempenho.",
      "categoriesIds": [2, 4],
      "actionType": 'Aluguel',
    },
    {
      "name": "Chave de Fenda",
      "type": ItemType.produto,
      "description":
          "Kit básico de chave de fenda para pequenos reparos. Ferramenta em [digite aqui a condição]. Ideal para uso esporádico.",
      "categoriesIds": [2, 5],
      "actionType": 'Aluguel',
    },
    {
      "name": "Personal Trainer",
      "type": ItemType.servico,
      "description":
          "Acompanhamento personalizado para treinos com foco em [condicionamento, emagrecimento ou hipertrofia]. Atendimento em casa ou online.",
      "categoriesIds": [6],
      "actionType": "Serviço",
    },
    {
      "name": "Aula Particular",
      "type": ItemType.servico,
      "description":
          "Aulas em domicílio ou online nas áreas de [matemática, inglês, reforço escolar, etc.]. Flexível e focado em resultados.",
      "categoriesIds": [7],
      "actionType": "Serviço",
    },
    {
      "name": "Cortador de Grama",
      "type": ItemType.produto,
      "description":
          "Cortador de grama em [digite aqui a condição]. Perfeito para manter jardins e quintais bem cuidados sem precisar comprar um equipamento próprio.",
      "categoriesIds": [2, 8],
      "actionType": "Aluguel",
    },
    {
      "name": "Escada",
      "type": ItemType.produto,
      "description":
          "Escada dobrável multiuso ideal para pequenos reparos ou manutenção doméstica. Está em [digite aqui a condição]. Leve, segura e fácil de transportar.",
      "categoriesIds": [2, 5],
      "actionType": "Aluguel",
    },
    {
      "name": "Furadeira",
      "type": ItemType.produto,
      "description":
          "Furadeira elétrica portátil com brocas inclusas. Ótima para instalações simples e reparos. Está em [digite aqui a condição].",
      "categoriesIds": [2, 5],
      "actionType": "Aluguel",
    },
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
                onPressed: widget.onSkipPressed ??
                    () => NavigatorProvider.navigateTo(
                          AppRoutes.registerItemStep1,
                          arguments: RouteArguments<List<dynamic>>(
                            [
                                null,
                                null,
                                null,
                                null,
                                null,
                              ],
                          ),
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
                width: 158,
                child: KondusButton(
                  label: 'CONTINUAR',
                  onPressed: selectedItem != null
                      ? () {
                          final selectedItemName =
                              selectedItem!['name'] as String;

                          final selectedItemType =
                              selectedItem!['type'] as ItemType;

                          final selectedItemDescription =
                              selectedItem!['description'] as String;

                          final selectedItemCategoriesIds =
                              selectedItem!['categoriesIds'] as List<int>;

                          final selectedItemActionType =
                              selectedItem!['actionType'] as String?;

                          NavigatorProvider.navigateTo(
                            AppRoutes.registerItemStep1,
                            arguments: RouteArguments<List<dynamic>>(
                              [
                                selectedItemType,
                                selectedItemName,
                                selectedItemDescription,
                                selectedItemCategoriesIds,
                                selectedItemActionType,
                              ],
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
