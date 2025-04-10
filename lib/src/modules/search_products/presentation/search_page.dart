import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
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
  final SearchPageController controller = SearchPageController()..fetchItems();

  get selectedCategories => controller.selectedCategories;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchPageAppBar(
        controller: controller,
        title: 'Buscar produtos ou serviços',
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
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
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final state = controller.state;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildStateContent(state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStateContent(SearchState state) {
    if (state is SearchLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SearchSuccess) {
      return ListView.separated(
        padding: const EdgeInsets.only(top: 12),
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          final product = state.products[index];
          return ProductCard(
            product: product,
            onTap: () => NavigatorProvider.navigateTo(
              AppRoutes.productDetails,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 18),
      );
    } else if (state is SearchFailure) {
      return Center(
        child: Text(
          state.errorMessage,
          style: const TextStyle(fontSize: 18),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
