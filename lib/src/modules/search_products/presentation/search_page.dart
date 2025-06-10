import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/src/modules/search_products/presentation/search_controller.dart';
import 'package:kondus/src/modules/search_products/presentation/search_state.dart';
import 'package:kondus/src/modules/search_products/widgets/item_card.dart';
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
    controller = SearchPageController()..loadInitialData();
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
        final currentState = controller.state;
        return Scaffold(
          appBar: currentState is SearchSuccess
              ? SearchPageAppBar(
                  controller: controller,
                  title: 'Buscar produtos ou serviços',
                )
              : const KondusAppBar(),
          floatingActionButton: currentState is SearchSuccess
              ? controller.searchController.value.text.isEmpty &&
                      currentState.products.isEmpty &&
                      controller.isFirstItemsLoaded &&
                      controller.selectedCategories.isEmpty
                  ? null
                  : FloatingActionButton.extended(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      label: Text(
                        'ANUNCIAR',
                        style: context.headlineLarge!.copyWith(
                          color: context.whiteColor,
                          fontSize: 16,
                        ),
                      ),
                      icon: Icon(
                        HugeIcons.strokeRoundedAdd01,
                        color: context.whiteColor,
                      ),
                      backgroundColor: context.blueColor,
                      onPressed: () => NavigatorProvider.navigateTo(
                        AppRoutes.shareYourItems,
                        arguments: RouteArguments<VoidCallback?>(null),
                      ),
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
            ? state.isLoadingMoreItems
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    padding: const EdgeInsets.only(top: 12, bottom: 96),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ItemCard(
                        item: product,
                        onTap: () => NavigatorProvider.navigateTo(
                          AppRoutes.itemDetails,
                          arguments: RouteArguments<List<dynamic>>(
                            [
                              product.id,
                              false,
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 18),
                  )
            : controller.searchController.value.text.isEmpty &&
                    controller.selectedCategories.isEmpty &&
                    controller.isFirstItemsLoaded
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, bottom: 48),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedPackage,
                          size: 64,
                          color: context.blueColor.withOpacity(0.8),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nada por aqui ainda',
                          style: context.titleLarge!.copyWith(
                            fontSize: 24,
                            color: context.primaryColor.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Seja um dos primeiros a anunciar um item no seu condomínio!',
                          style: context.labelMedium!.copyWith(
                            fontSize: 18,
                            color: context.primaryColor.withOpacity(0.3),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36),
                          child: KondusButton(
                            label: 'ANUNCIAR',
                            backgroundColor: context.blueColor.withOpacity(0.8),
                            onPressed: () => NavigatorProvider.navigateTo(
                              AppRoutes.shareYourItems,
                              arguments: RouteArguments<VoidCallback?>(null),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, bottom: 96),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.search_off_outlined,
                          size: 64,
                          color: context.blueColor.withOpacity(0.8),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhum resultado encontrado',
                          style: context.titleLarge!.copyWith(
                            fontSize: 24,
                            color: context.primaryColor.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tente ajustar os filtros ou palavras da busca para encontrar mais itens.',
                          style: context.labelMedium!.copyWith(
                            fontSize: 16,
                            color: context.primaryColor.withOpacity(0.3),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
