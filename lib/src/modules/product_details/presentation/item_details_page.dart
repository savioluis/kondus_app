import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/widgets/authenticated_image_widget.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/photo_view_page.dart';
import 'package:kondus/src/modules/product_details/domain/item_details_viewmodel.dart';
import 'package:kondus/src/modules/product_details/widgets/item_details_header.dart';
import 'package:kondus/src/modules/product_details/widgets/item_details_image_carousel.dart';
import 'package:kondus/src/modules/product_details/widgets/item_details_owner_banner.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/src/modules/product_details/widgets/item_details_price_info_widget.dart';
import '../../../../app/injections.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({
    required this.productId,
    this.isOwnerAcessing = false,
    super.key,
  });

  final int productId;
  final bool isOwnerAcessing;

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
              floatingActionButton: widget.isOwnerAcessing
                  ? null
                  : FloatingActionButton.extended(
                      onPressed: () => NavigatorProvider.navigateTo(
                        AppRoutes.contactChat,
                        arguments: RouteArguments<List<String>>(
                          [data.owner.id, data.owner.name],
                        ),
                      ),
                      backgroundColor: context.blueColor,
                      label: const Text("RESERVAR"),
                      icon: const Icon(Icons.chat),
                    ),
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: false,
                    expandedHeight: data.imageUrls.length > 1 ? 280 : 260,
                    backgroundColor: context.surfaceColor,
                    flexibleSpace: FlexibleSpaceBar(
                      background: data.imageUrls.length > 1
                          ? ItemDetailsImageCarousel(
                              imageUrls: data.imageUrls,
                              size: 256,
                              radius: 16,
                              spaceBetweenImages: 0.89,
                            )
                          : data.imageUrls.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: Container(
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
                                  ),
                                )
                              : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18),
                                child: GestureDetector(
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
                                    child: AuthenticatedImage(
                                      imageUrl: data.imageUrls.first,
                                      size: 256,
                                      radius: 16,
                                      imageFit: BoxFit.cover,
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
                              const BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 36,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ItemDetailsHeader(
                                name: data.name,
                                type: data.type,
                                actionType: data.actionType,
                              ),
                              const SizedBox(height: 8),
                              Divider(
                                color: context.lightGreyColor,
                                thickness: 0.5,
                              ),
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
                                style:
                                    context.bodyMedium!.copyWith(fontSize: 18),
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
                                name: data.owner.name,
                                local: data.owner.local,
                                house: data.owner.house,
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
                                spacing: 8,
                                runSpacing: 12,
                                children: data.categories
                                    .map(
                                      (e) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: context.blueColor
                                              .withOpacity(0.08),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: context.blueColor
                                                .withOpacity(0.4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              HugeIcons
                                                  .strokeRoundedLabelImportant,
                                              size: 14,
                                              color: context.blueColor
                                                  .withOpacity(0.7),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              e.name,
                                              style:
                                                  context.labelSmall!.copyWith(
                                                fontSize: 13,
                                                color: context.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 48),
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
