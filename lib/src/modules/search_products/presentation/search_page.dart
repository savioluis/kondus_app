import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/src/modules/search_products/presentation/search_controller.dart';
import 'package:kondus/src/modules/search_products/presentation/search_state.dart';
import 'package:kondus/src/modules/search_products/widgets/product_card.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/src/modules/search_products/widgets/search_page_appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final SearchPageController controller;

  get selectedCategories => controller.selectedCategories;

  @override
  void initState() {
    super.initState();
    controller = SearchPageController()..fetchItems();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: controller.state is SearchSuccess
              ? SearchPageAppBar(
                  controller: controller,
                  title: 'Buscar produtos ou serviços',
                )
              : const KondusAppBar(),
          floatingActionButton: controller.state is SearchSuccess
              ? FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  label: Text(
                    'CADASTRAR',
                    style: context.headlineLarge!.copyWith(
                      color: context.whiteColor,
                      fontSize: 20,
                    ),
                  ),
                  icon: Icon(
                    Icons.add_business,
                    color: context.whiteColor,
                  ),
                  backgroundColor: context.blueColor,
                  onPressed: () =>
                      NavigatorProvider.navigateTo(AppRoutes.lendYourProducts),
                )
              : null,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildStateContent(controller.state),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStateContent(SearchState state) {
    if (state is SearchLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SearchSuccess) {
      return RefreshIndicator(
        onRefresh: () async => await controller.fetchItems(),
        backgroundColor: context.blueColor,
        color: context.whiteColor,
        child: state.products.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.only(top: 12),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductCard(
                    product: product,
                    onTap: () => NavigatorProvider.navigateTo(
                      AppRoutes.productDetails,
                      arguments: RouteArguments<int>(product.id),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 18),
              )
            : const Center(
                child: Text(
                  'Nenhum produto encontrado',
                  style: TextStyle(fontSize: 18),
                ),
              ),
      );
    } else if (state is SearchFailureState) {
      return ErrorStateWidget(
        error: state.error,
        onRetryPressed: controller.fetchItems,
      );
    }
    return const SizedBox.shrink();
  }
}
