import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/src/modules/chat/contact_list/model/contact_model.dart';
import 'package:kondus/src/modules/home/presentation/home_controller.dart';
import 'package:kondus/src/modules/home/presentation/home_state.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_item_slider.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_title.dart';
import 'package:kondus/src/modules/home/widgets/app_bar/home_app_bar.dart';
import 'package:kondus/src/modules/home/widgets/home_banner_carousel.dart';
import 'package:kondus/src/modules/home/widgets/item_card.dart';
import 'package:kondus/src/modules/home/widgets/search_bar_button.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  final controller = TextEditingController();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Todos';

  late final HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController()..loadInitialData();
  }

  @override
  void dispose() {
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
          return ErrorStateWidget(
            error: state.error,
            onRetryPressed: () => controller.loadInitialData(),
            onBackButtonPressed: () => controller.logout(),
          );
        } else if (state is HomeSuccessState) {
          final currentState = state;
          return Scaffold(
            appBar: HomeAppBar(username: currentState.user.name),
            body: RefreshIndicator(
              onRefresh: () async => await controller.loadInitialData(),
              backgroundColor: context.blueColor,
              color: context.whiteColor,
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),

                  const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        HomeBannerCarousel(),
                        SizedBox(height: 36),
                      ],
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Divider(
                      thickness: 0.1,
                      color: context.lightGreyColor,
                      height: 2,
                    ),
                  ),

                  if (state.contacts.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 36),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: ContactTitle(
                              onTap: () => NavigatorProvider.navigateTo(
                                AppRoutes.contactList,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ContactItemSlider(
                            contacts: state.contacts,
                            itemCount: state.contacts.length,
                          ),
                          const SizedBox(height: 36),
                        ],
                      ),
                    ),

                  SliverToBoxAdapter(
                    child: Divider(
                      thickness: 0.1,
                      color: context.lightGreyColor,
                      height: 2,
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 36),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: SearchBarButton(
                            onTap: () => NavigatorProvider.navigateTo(
                              AppRoutes.searchProducts,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),

                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _PinnedCategoryHeader(
                      minExtent: 60,
                      maxExtent: 60,
                      child: Container(
                        color: context.surfaceColor,
                        alignment: Alignment.centerLeft,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildCategoryChip('Todos'),
                            _buildCategoryChip('Comprar'),
                            _buildCategoryChip('Alugar'),
                            _buildCategoryChip('Contratar'),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 12)),

                  // LISTA DE PRODUTOS
                  if (state.isLoadingMoreItems)
                    const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (currentState.items.isNotEmpty)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: currentState.items.length,
                        (context, index) {
                          final item = currentState.items[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                              bottom: 18,
                            ),
                            child: ItemCard(
                              imageUrl: item.imagesPaths.isNotEmpty
                                  ? item.imagesPaths.first
                                  : null,
                              name: item.name,
                              category: item.categories[0].name,
                              actionType: item.type.toActionType(item.quantity),
                              onTap: () {
                                NavigatorProvider.navigateTo(
                                  AppRoutes.itemDetails,
                                  arguments: RouteArguments<List<dynamic>>([
                                    item.id,
                                    false,
                                  ]),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  else
                    const SliverToBoxAdapter(
                      child: Center(child: Text('Nenhum produto encontrado')),
                    ),

                  const SliverToBoxAdapter(child: SizedBox(height: 96)),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
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

class _PinnedCategoryHeader extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;

  @override
  final double maxExtent;

  final Widget child;

  _PinnedCategoryHeader({
    required this.child,
    required this.minExtent,
    required this.maxExtent,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: context.surfaceColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedCategoryHeader oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent;
  }
}
