import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/src/modules/lend_your_products/widgets/item_chip.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_extension.dart';
import 'package:kondus/core/widgets/header_section.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';

class LendYourProductsPage extends StatefulWidget {
  const LendYourProductsPage({super.key});

  @override
  State<LendYourProductsPage> createState() => _LendYourProductsPageState();
}

class _LendYourProductsPageState extends State<LendYourProductsPage> {
  List<String> selectedItems = [];

  final List<String> items = [
    'Furadeira',
    'Bicicleta',
    'Chave de Fenda',
    'Escada',
    'Aspirador',
    'Serra Elétrica',
    'Mangueira',
    'Cortador de Grama',
  ];

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
                onPressed: () => NavigatorProvider.navigateTo(AppRoutes.home),
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
                  label: 'FINALIZAR',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Produtos adicionados com sucesso !',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                    NavigatorProvider.replaceWith(AppRoutes.home);
                  },
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
                titleSize: 34,
                subTitleSize: 16,
                title:
                    'Você possui algum desses itens para compartilhar com seus vizinhos?',
                subtitle: [
                  TextSpan(text: 'Compartilhe seus '),
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
                  ...items.map(
                    (item) {
                      return ItemChip(
                        text: item,
                        isSelected: selectedItems.contains(item),
                        onTap: () {
                          setState(() {
                            if (selectedItems.contains(item)) {
                              selectedItems.remove(item);
                            } else if (selectedItems.length < 9) {
                              selectedItems.add(item);
                            }
                          });
                        },
                      );
                    },
                  ),
                  // Chip de adicionar mais
                  GestureDetector(
                    onTap: () =>
                        NavigatorProvider.navigateTo(AppRoutes.registerItem),
                    child: Chip(
                      padding: const EdgeInsets.all(6),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            size: 16,
                            color: context.primaryColor,
                          ),
                          const SizedBox(width: 4),
                          const Text('NOVO'),
                        ],
                      ),
                      backgroundColor: context.surfaceColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: context.lightGreyColor.withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelStyle: TextStyle(
                        color: context.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
