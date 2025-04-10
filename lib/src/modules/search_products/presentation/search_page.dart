import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';
import 'package:kondus/src/modules/search_products/presentation/search_controller.dart';
import 'package:kondus/src/modules/search_products/presentation/search_state.dart';
import 'package:kondus/src/modules/search_products/widgets/product_card.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';

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
      appBar: const KondusAppBar(
        title: 'Buscar Produtos ou Serviços',
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 5,
                      child: KondusTextFormField(
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: context.lightGreyColor,
                        hintText: 'Digite para pesquisar...',
                        controller: controller.searchController,
                        onChanged: controller.onSearchChanged,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      flex: 1,
                      child: Stack(
                        alignment: const Alignment(1.5, 1.5),
                        children: [
                          InkWell(
                            onTap: () async {
                              final resultOfFilterSelection =
                                  await NavigatorProvider.navigateTo(
                                AppRoutes.filter,
                                arguments: RouteArguments<List<CategoryModel>>(
                                    selectedCategories),
                              ) as RouteArguments<List<CategoryModel>?>?;

                              if (resultOfFilterSelection != null &&
                                  resultOfFilterSelection.data != null) {
                                controller.onFiltersChanged(
                                    resultOfFilterSelection.data!);
                              }
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Ink(
                              height: 56,
                              decoration: BoxDecoration(
                                color: context.blueColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.filter_list_sharp,
                                  color: context.whiteColor,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                          if (selectedCategories.isNotEmpty)
                            Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                color: context.surfaceColor,
                                border:
                                    Border.all(color: context.lightGreyColor),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  selectedCategories.length < 10
                                      ? '${selectedCategories.length}'
                                      : '9+',
                                  style: TextStyle(
                                    color: context.secondaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
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
        padding: const EdgeInsets.only(top: 24),
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
