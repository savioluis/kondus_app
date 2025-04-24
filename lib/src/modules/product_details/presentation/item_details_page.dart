import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/theme/theme_data/colors/app_colors.dart';
import 'package:kondus/core/widgets/authenticated_image_widget.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/photo_view_page.dart';
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
              body: Column(
                children: [
                  Padding(
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
                                  color:
                                      context.lightGreyColor.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                height: 256,
                                width: double.infinity,
                                child: Icon(
                                  Icons.hide_image_outlined,
                                  color:
                                      context.onSurfaceColor.withOpacity(0.2),
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
                  const SizedBox(height: 36),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: context.lightGreyColor),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 36,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      data.name,
                                      style: context.headlineLarge!.copyWith(
                                        fontSize: 28,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: _buildActionTypeChip(data.type),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Divider(
                                  color: context.lightGreyColor,
                                  thickness: 0.5),
                              const SizedBox(height: 32),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: ItemDetailsOwnerBanner(
                                        owner: data.owner,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: context.blueColor
                                              .withOpacity(0.1)),
                                      padding: const EdgeInsets.all(18),
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
                              ),
                              const SizedBox(height: 32),
                              Divider(
                                  color: context.lightGreyColor,
                                  thickness: 0.5),
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
                                  color: context.lightGreyColor,
                                  thickness: 0.5),
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
    child: Flexible(
      child: Text(
        maxLines: 1,
        actionType.toUpperCase(),
        style: TextStyle(
          color: chipColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
