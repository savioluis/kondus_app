import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/src/modules/product_details/domain/item_details_viewmodel.dart';
import 'package:kondus/src/modules/product_details/widgets/item_details_image_carousel.dart';
import 'package:kondus/src/modules/product_details/widgets/item_details_owner_banner.dart';
import 'package:kondus/core/theme/app_theme.dart';
import '../../../../app/injections.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({required this.productId, super.key});

  final int productId;

  @override
  State<ItemDetailsPage> createState() => ItemtDetailsPageState();
}

class ItemtDetailsPageState extends State<ItemDetailsPage> {
  final viewmodel = getIt<ItemDetailsViewmodel>();

  @override
  void initState() {
    viewmodel.getItemDetails(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KondusAppBar(),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: viewmodel.state,
        builder: (context, state, widget) {
          return state is! ItemDetailsSuccessState
              ? const SizedBox()
              : FloatingActionButton.extended(
                  onPressed: () =>
                      NavigatorProvider.navigateTo(AppRoutes.contactChat),
                  backgroundColor: context.blueColor,
                  label: const Text("RESERVAR"),
                  icon: const Icon(Icons.chat),
                );
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: viewmodel.state,
        builder: (context, state, widget) {
          return switch (state) {
            ItemDetailsIdleState() => const SizedBox(),
            ItemDetailsLoadingState() =>
              const Center(child: CircularProgressIndicator()),
            ItemDetailsFailureState(message: final message) =>
              Center(child: Text(message, style: context.titleLarge)),
            ItemDetailsSuccessState(data: final data) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ItemDetailsImageCarousel(imageUrls: data.imageUrls),
                  ),
                  const SizedBox(height: 36),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.blueColor.withOpacity(
                          0.18,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 36),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    data.name,
                                    style: context.headlineLarge!.copyWith(
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Chip(label: Text(data.type)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Divider(
                                color: context.lightGreyColor, thickness: 0.5),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: ItemDetailsOwnerBanner(
                                    owner: data.owner,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color:
                                          context.blueColor.withOpacity(0.1)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Text(
                                    'R\$ ${data.price.toStringAsFixed(2)}',
                                    style: context.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: context.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Divider(
                                color: context.lightGreyColor, thickness: 0.5),
                            const SizedBox(height: 16),
                            Text(
                              "Descrição",
                              style: context.headlineMedium!.copyWith(
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              data.description,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: context.bodyMedium!.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 36),
                            Divider(
                                color: context.lightGreyColor, thickness: 0.5),
                            const SizedBox(height: 16),
                            Text(
                              "Categorias",
                              style: context.headlineMedium!.copyWith(
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              children: [
                                ...data.categories.map(
                                  (e) => Chip(label: Text(e.name)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
          };
        },
      ),
    );
  }
}
