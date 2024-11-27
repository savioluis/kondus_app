import 'package:flutter/material.dart';
import 'package:kondus/src/modules/product_details/domain/product_details_viewmodel.dart';
import 'package:kondus/src/modules/product_details/widgets/product_details_image_carousel.dart';
import 'package:kondus/src/modules/product_details/widgets/product_details_owner_banner.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';
import '../../../../app/injections.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final viewmodel = getIt<ProductDetailsViewmodel>();

  @override
  void initState() {
    viewmodel.getProductDetails(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: viewmodel.state,
        builder: (context, state, widget) {
          return state is! ProductDetailsSuccessState
              ? const SizedBox()
              : FloatingActionButton.extended(
                  onPressed: () {},
                  backgroundColor: context.blueColor,
                  label: const Text("RESERVAR"),
                );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: ValueListenableBuilder(
          valueListenable: viewmodel.state,
          builder: (context, state, widget) {
            return switch (state) {
              ProductDetailsIdleState() => const SizedBox(),
              ProductDetailsLoadingState() =>
                const Center(child: CircularProgressIndicator()),
              ProductDetailsFailureState(message: final message) =>
                Center(child: Text(message, style: context.titleLarge)),
              ProductDetailsSuccessState(data: final data) =>
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.name, style: context.headlineLarge),
                      const SizedBox(height: 20),
                      ProductDetailsOwnerBanner(owner: data.owner),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 25),
                        child: ProductDetailsImageCarousel(
                            imageUrls: data.imageUrls),
                      ),
                      Text("Descrição", style: context.headlineMedium),
                      const SizedBox(height: 10),
                      Text(data.description, style: context.labelLarge),
                      const SizedBox(height: 100)
                    ],
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
