import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/theme/theme_data/colors/app_colors.dart';
import 'package:kondus/core/widgets/authenticated_image_widget.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/photo_view_page.dart';
import 'package:kondus/src/modules/home/widgets/product_card.dart';
import 'package:kondus/src/modules/product_details/domain/item_details_model.dart';
import 'package:kondus/src/modules/product_details/domain/item_details_viewmodel.dart';
import 'package:kondus/src/modules/product_details/widgets/item_details_image_carousel.dart';
import 'package:kondus/src/modules/product_details/widgets/item_details_owner_banner.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/src/modules/product_details/widgets/item_details_price_info_widget.dart';
import 'package:kondus/src/modules/share_your_items/widgets/item_chip.dart';
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
    return ValueListenableBuilder(
      valueListenable: viewmodel.state,
      builder: (context, state, _) {
        return switch (state) {
          ItemDetailsIdleState() => const SizedBox.shrink(),
          ItemDetailsLoadingState() => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ItemDetailsFailureState(error: final error) => ErrorStateWidget(
              error: error,
              onRetryPressed: () async {
                await viewmodel.getItemDetails(widget.productId);
              },
            ),
          ItemDetailsSuccessState(data: final data) => Scaffold(
              appBar: const KondusAppBar(),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () =>
                    NavigatorProvider.navigateTo(AppRoutes.contactChat),
                backgroundColor: context.blueColor,
                label: const Text("RESERVAR"),
                icon: const Icon(Icons.chat),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: data.imageUrls.length > 1
                          ? ItemDetailsImageCarousel(
                              imageUrls: data.imageUrls,
                              size: 256,
                              radius: 16,
                              spaceBetweenImages: 1.75,
                            )
                          : data.imageUrls.isEmpty
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: context.lightGreyColor
                                        .withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  height: 256,
                                  width: double.infinity,
                                  child: Icon(
                                    Icons.hide_image_outlined,
                                    color: context.onSurfaceColor
                                        .withOpacity(0.2),
                                    size: 96,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhotoViewPage(
                                          isFromNetwork: true,
                                          imagePath: data.imageUrls.first,
                                        ),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: AuthenticatedImage(
                                      imagePath: data.imageUrls.first,
                                      size: 256,
                                      radius: 16,
                                    ),
                                  ),
                                ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 36)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 24,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: context.lightGreyColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(32)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 36),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.name,
                                          style: context.headlineLarge!
                                              .copyWith(fontSize: 28),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${data.type[0].toUpperCase()}${data.type.substring(1)}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  _buildActionTypeChip(data.actionType),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Divider(
                                  color: context.lightGreyColor,
                                  thickness: 0.5),
                              const SizedBox(height: 24),
                              ItemDetailsPriceInfoWidget(
                                actionType: data.actionType,
                                price: data.price,
                                quantity: data.quantity,
                              ),
                              const SizedBox(height: 24),
                              Divider(
                                  color: context.lightGreyColor,
                                  thickness: 0.5),
                              const SizedBox(height: 24),
                              Text(
                                "Descrição",
                                style: context.headlineMedium!
                                    .copyWith(fontSize: 24),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                data.description,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: context.bodyMedium!
                                    .copyWith(fontSize: 18),
                              ),
                              const SizedBox(height: 24),
                              Divider(
                                color: context.lightGreyColor,
                                thickness: 0.5,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "Fornecedor",
                                style: context.headlineMedium!
                                    .copyWith(fontSize: 24),
                              ),
                              const SizedBox(height: 24),
                              ItemDetailsOwnerBanner(
                                ownerName: data.owner.name,
                                ownerComplement: data.owner.complement,
                              ),
                              const SizedBox(height: 24),
                              Divider(
                                color: context.lightGreyColor,
                                thickness: 0.5,
                              ),
                              Text(
                                "Categorias",
                                style: context.headlineMedium!
                                    .copyWith(fontSize: 24),
                              ),
                              const SizedBox(height: 24),
                              Wrap(
                                spacing: 6,
                                runSpacing: 10,
                                alignment: WrapAlignment.start,
                                children: [
                                  ...data.categories.map(
                                    (e) => Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: context.blueColor
                                                .withOpacity(0.5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 6,
                                      ),
                                      child: Text(
                                        e.name,
                                        style: context.bodyMedium!.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 96),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        };
      },
    );
  }
}

Widget _buildActionTypeChip(String actionType) {
  final colors = {
    'Comprar': Colors.green,
    'Alugar': Colors.orange,
    'Contratar': Colors.blue,
  };

  final chipColor = colors[actionType] ?? AppColors.lightGrey;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: chipColor.withOpacity(0.2),
      border: Border.all(color: chipColor),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      maxLines: 1,
      actionType.toUpperCase(),
      style: TextStyle(
        color: chipColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
