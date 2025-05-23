import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/utils/input_validator.dart';
import 'package:kondus/core/utils/overlay_helper.dart';
import 'package:kondus/core/utils/snack_bar_helper.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_controller.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_state.dart';
import 'package:kondus/src/modules/register_item/widgets/register_item_step_2_appbar.dart';
import 'package:kondus/src/modules/register_item/widgets/category_selector_field.dart';
import 'package:kondus/src/modules/register_item/widgets/custom_dropdown_field.dart';

class RegisterItemStep2Page extends StatefulWidget {
  const RegisterItemStep2Page({
    this.itemType,
    super.key,
    required this.name,
    required this.description,
    this.imagesPaths,
    this.categoriesIds,
    this.actionType,
  });

  final ItemType? itemType;
  final String name;
  final String description;
  final List<String>? imagesPaths;

  final List<int>? categoriesIds;
  final String? actionType;

  @override
  State<RegisterItemStep2Page> createState() => _RegisterItemStep2PageState();
}

class _RegisterItemStep2PageState extends State<RegisterItemStep2Page> {
  late final RegisterItemController controller;

  @override
  void initState() {
    super.initState();
    controller = RegisterItemController()..loadCategories();
    controller.addListener(_controllerListener);
    controller.applyFieldsIfExistsStep2(
      categoriesIds: widget.categoriesIds,
      actionType: widget.actionType,
    );
  }

  @override
  dispose() {
    controller.removeListener(_controllerListener);
    controller.dispose();
    super.dispose();
  }

  _controllerListener() {
    final state = controller.state;

    if (state is RegisterItemSuccessState &&
        state.validationErrorMessage != null) {
      SnackBarHelper.showMessageSnackBar(
        message: state.validationErrorMessage!,
        context: context,
      );
    } else if (state is RegisteredItemWithSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        NavigatorProvider.navigateAndRemoveUntil(AppRoutes.home);
        OverlayHelper.showSuccessOverlay(
          context: context,
          duration: const Duration(milliseconds: 1500),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final state = controller.state;
        if (state is RegisterItemLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is RegisterItemFailureState) {
          return ErrorStateWidget(
            error: state.error,
            onRetryPressed: () async {
              await controller.loadCategories();
            },
          );
        } else if (state is RegisterItemSuccessState) {
          return Scaffold(
            appBar: RegisterItemAppbarStep2(
              isOnlyItem: widget.itemType == null,
              itemType: widget.itemType,
              itemName: widget.name,
            ),
            bottomNavigationBar: ColoredBox(
              color: context.surfaceColor,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 18,
                    top: 18,
                    left: 24,
                    right: 24,
                  ),
                  child: KondusButton(
                    label: 'Anunciar',
                    isLoading: state.isSubmitting,
                    onPressed: () async {
                      await controller.registerItem(
                        name: widget.name,
                        description: widget.description,
                        imagesFilesPaths: widget.imagesPaths,
                      );
                    },
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildSectionTitle('Preço'),
                    KondusTextFormField(
                      hintText: 'Digite o preço de ${widget.name}....',
                      controller: controller.priceEC,
                      inputFormatters: [ProgressiveNumberInputFormatter()],
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: true),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Categorias'),
                    CategorySelectorField(
                      selectedCategories: controller.selectedCategories,
                      allCategories: state.categories,
                      onSelectionChanged: (newCategories) =>
                          controller.updateCategories(newCategories),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Tipo'),
                    CustomDropdownField(
                      hint: 'Selecione o tipo do item',
                      items: const ['Venda', 'Aluguel', 'Serviço'],
                      value: controller.selectedType,
                      enabled: !controller.isAutoFilledType,
                      onChanged: (value) {
                        setState(() {
                          controller.selectedType = value;
                        });
                      },
                    ),
                    if (controller.selectedType != 'Aluguel') ...[
                      const SizedBox(height: 24),
                      _buildSectionTitle('Quantidade'),
                      KondusTextFormField(
                        hintText: 'Digite a quantidade a oferecer...',
                        controller: controller.quantityEC,
                      ),
                      const SizedBox(height: 24),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
    ],
  );
}
