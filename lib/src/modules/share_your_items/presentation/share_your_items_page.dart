import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/src/modules/share_your_items/model/recommended_item.dart';
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
  RecommendedItem? selectedItem;
  final recommendedItems = RecommendedItem.items..shuffle();
  List<RecommendedItem> displayedItems = [];

  final TextEditingController _searchController = TextEditingController();

  bool showAllItems = false;

  final minimumDisplayQuantity = 9;

  @override
  void initState() {
    super.initState();
    displayedItems = recommendedItems.take(minimumDisplayQuantity).toList();
  }

  void _filterItems(String query) {
    setState(() {
      displayedItems = recommendedItems
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KondusAppBar(),
      bottomNavigationBar: ColoredBox(
        color: context.surfaceColor,
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 18, top: 36, left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
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
                    widget.onSkipPressed != null ? 'Pular Etapa' : 'Outro',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.blueColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                Flexible(
                  child: IntrinsicWidth(
                    child: KondusButton(
                      label: 'CONTINUAR',
                      onPressed: selectedItem != null
                          ? () {
                              final selectedItemName = selectedItem!.name;
        
                              final selectedItemType = selectedItem!.type;
        
                              final selectedItemDescription =
                                  selectedItem!.description;
        
                              final selectedItemCategoriesIds =
                                  selectedItem!.categoriesIds;
        
                              final selectedItemActionType =
                                  selectedItem!.actionType;
        
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
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(
              titleSize: widget.onSkipPressed != null ? 30 : 38,
              subTitleSize: 16,
              title: widget.onSkipPressed != null
                  ? 'Você possui algum desses itens para compartilhar com seus vizinhos?'
                  : 'Gostaria de anunciar algum desses itens?',
              subtitle: const [
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
            Visibility(
              visible: showAllItems,
              child: KondusTextFormField(
                controller: _searchController,
                onChanged: _filterItems,
                decoration: const InputDecoration(
                  hintText: 'Pesquise um item...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    ...displayedItems.map(
                      (item) {
                        final itemName = item.name;
                        return ItemChip(
                          isSelected: selectedItem?.name == itemName,
                          onTap: () {
                            setState(() {
                              if (selectedItem?.name == itemName) {
                                selectedItem = null;
                              } else {
                                selectedItem = item;
                              }
                            });
                          },
                          child: Text(itemName.toUpperCase()),
                        );
                      },
                    ),
                    if (!showAllItems &&
                        recommendedItems.length > minimumDisplayQuantity &&
                        _searchController.value.text.isEmpty)
                      ItemChip(
                        onTap: () {
                          setState(() {
                            showAllItems = true;
                            displayedItems = recommendedItems;
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('VER MAIS'),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.expand_more_rounded,
                              color: context.blueColor.withOpacity(0.5),
                            )
                          ],
                        ),
                      ),
                    if (showAllItems && _searchController.value.text.isEmpty)
                      ItemChip(
                        onTap: () {
                          setState(() {
                            showAllItems = false;
                            _searchController.clear();
                            displayedItems = recommendedItems
                                .take(minimumDisplayQuantity)
                                .toList();
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('VER MENOS'),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.expand_less,
                              color: context.blueColor.withOpacity(0.5),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
