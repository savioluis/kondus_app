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
  final SearchPageController controller = SearchPageController();

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
                      flex: 6,
                      child: KondusTextFormField(
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: context.lightGreyColor,
                        hintText: 'Digite para pesquisar...',
                        controller: controller.searchController,
                        onChanged: controller.onSearchChanged,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          final resultOfFilterSelection =
                              await NavigatorProvider.navigateTo(
                            AppRoutes.filter,
                            arguments: RouteArguments<List<CategoryModel>>(
                                controller.selectedCategories),
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
                            color: context.blueColor,
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
                    ),
                  ],
                ),
                if (controller.selectedCategories.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: controller.selectedCategories
                        .map((cat) => Chip(
                              label: Text(cat.name),
                            ))
                        .toList(),
                  ),
                if (controller.searchController.text.isNotEmpty)
                  const SizedBox(height: 24),
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
    if (state is SearchInitial || controller.searchController.text.isEmpty) {
      return const Center(
        child: Text(
          'Digite algo para começar a busca. 😎\nOu cadastre um novo item',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    } else if (state is SearchLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SearchSuccess) {
      return ListView.builder(
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
