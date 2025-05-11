import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/utils/overlay_helper.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/src/modules/home/presentation/home_controller.dart';
import 'package:kondus/src/modules/home/presentation/home_state.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_item_slider.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_title.dart';
import 'package:kondus/src/modules/home/widgets/app_bar/home_app_bar.dart';
import 'package:kondus/src/modules/home/widgets/home_banner_carousel.dart';
import 'package:kondus/src/modules/home/widgets/item_card.dart';
import 'package:kondus/src/modules/home/widgets/search_bar_button.dart';
import 'package:kondus/core/theme/app_theme.dart';

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
                  const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        HomeBannerCarousel(),
                        SizedBox(height: 24),
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
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: ContactTitle(
                              onTap: () => NavigatorProvider.navigateTo(
                                AppRoutes.contactList,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          ContactItemSlider(
                            unreadMessagesCountForEachContactId:
                                state.unreadMessagesCountForEachContactId,
                            contacts: state.contacts,
                            itemCount: state.contacts.length,
                          ),
                          const SizedBox(height: 24),
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

                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _PinnedSearchAndCategoryHeader(
                      minExtent: 166,
                      maxExtent: 166,
                      child: Container(
                        color: context.surfaceColor,
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: SearchBarButton(
                                onTap: () => NavigatorProvider.navigateTo(
                                  AppRoutes.searchProducts,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 36,
                              child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
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
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 12)),

                  // LISTA DE PRODUTOS
                  if (state.isLoadingMoreItems)
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: (72.0 * state.items.length).clamp(100, 300),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: context.lightGreyColor.withOpacity(0.4),
                          ),
                        ),
                      ),
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
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 48, horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedPackage,
                              size: 36,
                              color: context.blueColor.withOpacity(0.6),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 82),
                              child: Text(
                                'Nenhum item em destaque no momento',
                                style: context.bodyMedium?.copyWith(
                                  color: context.primaryColor.withOpacity(0.7),
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
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
        if (selectedCategory == category) return;
        selectedCategory = category;
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

class _PinnedSearchAndCategoryHeader extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;

  @override
  final double maxExtent;

  final Widget child;

  _PinnedSearchAndCategoryHeader({
    required this.minExtent,
    required this.maxExtent,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
