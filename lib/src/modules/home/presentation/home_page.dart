import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/utils/snack_bar_helper.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';
import 'package:kondus/src/modules/home/presentation/home_controller.dart';
import 'package:kondus/src/modules/home/presentation/home_state.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_item_slider.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_title.dart';
import 'package:kondus/src/modules/home/widgets/app_bar/home_app_bar.dart';
import 'package:kondus/src/modules/home/widgets/product_card.dart';
import 'package:kondus/src/modules/home/widgets/search_bar_button.dart';
import 'package:kondus/core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  final controller = TextEditingController();
}

class _HomePageState extends State<HomePage> {
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

  late final HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController()..loadInitialData();
    controller.addListener(_controllerListener);
  }

  void _controllerListener() {
    final state = controller.state;
    if (state is HomeFailureState) {
      SnackBarHelper.showMessageSnackBar(
        message: state.error.failureMessage,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final state = controller.state;

        if (state is HomeLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is HomeFailureState) {
          return Scaffold(
            appBar: KondusAppBar(
                onBackButtonPressed: () async => controller.logout()),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.error.failureMessage,
                    style: context.labelLarge!.copyWith(fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  _buildErrorButton(state.error),
                ],
              ),
            ),
          );
        } else if (state is HomeSuccessState) {
          final currentState = state;
          return Scaffold(
            appBar: HomeAppBar(username: currentState.user.name),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ContactTitle(
                      onTap: () => NavigatorProvider.navigateTo(
                        AppRoutes.contactList,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ContactItemSlider(
                    contacts: contacts,
                    itemCount: contacts.length,
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SearchBarButton(
                      onTap: () => NavigatorProvider.navigateTo(
                        AppRoutes.searchProducts,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryChip('Todos'),
                        _buildCategoryChip('Comprar'),
                        _buildCategoryChip('Alugar'),
                        _buildCategoryChip('Contratar'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  state.isLoadingMoreItems
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: currentState.items.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: currentState.items.length,
                                  itemBuilder: (context, index) {
                                    final product = currentState.items[index];
                                    return ProductCard(
                                      imageUrl: product.imagesPaths.isNotEmpty
                                          ? product.imagesPaths.first
                                          : null,
                                      name: product.name,
                                      category: product.categories[0].name,
                                      actionType: product.type
                                          .toActionType(product.quantity),
                                      onTap: () {
                                        NavigatorProvider.navigateTo(
                                          AppRoutes.productDetails,
                                          arguments:
                                              RouteArguments<int>(product.id),
                                        );
                                      },
                                    );
                                  },
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: 24),
                                  child: Text('Nenhum produto encontrado'),
                                ),
                        ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildErrorButton(Exception error) {
    if (error is HttpError && error.type == HttpErrorType.unauthorized) {
      return KondusButton(
        label: 'Sair',
        onPressed: () async => controller.logout(),
      );
    }
    return KondusButton(
      label: 'Tentar novamente',
      onPressed: () async => controller.loadInitialData(),
    );
  }

  Widget _buildCategoryChip(String category) {
    bool isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedCategory = category;
        });
        await controller.loadItemsWithCategoryFilter(category);
      },
      child: Container(
        margin: category == 'Todos'
            ? const EdgeInsets.symmetric(horizontal: 12)
            : const EdgeInsets.only(right: 12),
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
