import 'package:flutter/material.dart';
import 'package:kondus/app/routers/app_routers.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_item_slider.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_title.dart';
import 'package:kondus/src/modules/home/widgets/header.dart';
import 'package:kondus/src/modules/home/widgets/product_card.dart';
import 'package:kondus/src/modules/home/widgets/search_bar_button.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  final controller = TextEditingController();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'https://placehold.co/150.png',
      'name': 'Furadeira X200',
      'category': 'Ferramentas',
      'actionType': ActionType.comprar,
    },
    {
      'imageUrl': 'https://placehold.co/150.png',
      'name': 'Bolo de Chocolate',
      'category': 'Alimentos',
      'actionType': ActionType.comprar,
    },
    {
      'imageUrl': 'https://placehold.co/150.png',
      'name': 'Curso de Inglês Online',
      'category': 'Serviços',
      'actionType': ActionType.contratar,
    },
    {
      'imageUrl': 'https://placehold.co/150.png',
      'name': 'Apartamento Temporário',
      'category': 'Imóveis',
      'actionType': ActionType.alugar,
    },
    {
      'imageUrl': 'https://placehold.co/150.png',
      'name': 'Apartamento Temporário',
      'category': 'Imóveis',
      'actionType': ActionType.alugar,
    },
  ];

  final contacts = [
    {'uid': '1', 'name': 'Alice', 'apartment': 'Apartamento 1 - Bloco A'},
    {'uid': '2', 'name': 'Bob', 'apartment': 'Apartamento 2 - Bloco D'},
    {'uid': '3', 'name': 'Charlie', 'apartment': 'Apartamento 105 - Bloco B'},
    {'uid': '4', 'name': 'David', 'apartment': 'Apartamento 309 - Bloco J'},
    {'uid': '5', 'name': 'Elias', 'apartment': 'Apartamento  - Bloco H'},
    {'uid': '6', 'name': 'Filipe', 'apartment': 'Casa 3'},
    {'uid': '7', 'name': 'Greg', 'apartment': 'Casa 06'},
    {'uid': '8', 'name': 'Heitor', 'apartment': 'Casa 06'},
    {'uid': '9', 'name': 'Isabel', 'apartment': 'Casa 27'},
    {
      'uid': '10',
      'name': 'Jay',
      'apartment': 'Apartamento 48 - Torre 3 - Bloco 1'
    },
  ];

  String selectedCategory = 'Todos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Header(username: 'Sávio'),
            ),
            const SizedBox(height: 18),
            Divider(thickness: 0.1, color: context.lightGreyColor),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ContactTitle(
                  onTap: () =>
                      NavigatorProvider.navigateTo(AppRoutes.contactList)),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ContactItemSlider(
                contacts: contacts,
                itemCount: contacts.length,
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SearchBarButton(
                  onTap: () =>
                      NavigatorProvider.navigateTo(AppRoutes.searchProducts)),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip('Todos'),
                    _buildCategoryChip('Compra'),
                    _buildCategoryChip('Alugar'),
                    _buildCategoryChip('Contratar'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView.builder(
                  itemCount: _getFilteredProducts().length,
                  itemBuilder: (context, index) {
                    final product = _getFilteredProducts()[index];
                    return ProductCard(
                      imageUrl: product['imageUrl']!,
                      name: product['name']!,
                      category: product['category']!,
                      actionType: product['actionType'] as ActionType,
                      onTap: () {
                        NavigatorProvider.navigateTo(AppRoutes.productDetails);
                      },
                      onButtonPressed: () {
                        NavigatorProvider.navigateTo(AppRoutes.productDetails);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredProducts() {
    if (selectedCategory == 'Todos') {
      return products;
    }
    return products.where((product) {
      return _getActionTypeString(product['actionType']) == selectedCategory;
    }).toList();
  }

  String _getActionTypeString(ActionType actionType) {
    switch (actionType) {
      case ActionType.comprar:
        return 'Compra';
      case ActionType.alugar:
        return 'Alugar';
      case ActionType.contratar:
        return 'Contratar';
      default:
        return '';
    }
  }

  Widget _buildCategoryChip(String category) {
    bool isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(category.toUpperCase()),
          backgroundColor:
              isSelected ? context.blueColor : context.surfaceColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: context.lightGreyColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          labelStyle: TextStyle(
            color: isSelected ? context.whiteColor : context.primaryColor,
          ),
        ),
      ),
    );
  }
}
