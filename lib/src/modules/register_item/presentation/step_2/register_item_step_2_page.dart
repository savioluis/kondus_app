import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/utils/input_validator.dart';
import 'package:kondus/core/utils/snack_bar_helper.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_controller.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_state.dart';
import 'package:kondus/src/modules/register_item/widgets/register_item_step_2_appbar.dart';
import 'package:kondus/src/modules/register_item/widgets/category_selector_field.dart';
import 'package:kondus/src/modules/register_item/widgets/custom_dropdown_field.dart';
import 'package:kondus/src/modules/register_item/widgets/register_item_step_1_appbar.dart';

class RegisterItemStep2Page extends StatefulWidget {
  const RegisterItemStep2Page({
    this.itemType,
    super.key,
    required this.name,
    required this.description,
  });

  final ItemType? itemType;
  final String name;
  final String description;

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
  }

  _controllerListener() {
    final state = controller.state;

    if (state is RegisterItemSuccessState &&
        state.validationErrorMessage != null) {
      SnackBarHelper.showMessageSnackBar(
        message: state.validationErrorMessage!,
        context: context,
      );
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
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                child: KondusButton(
                  label: 'Próximo',
                  onPressed: () {
                    controller.registerItem(
                      name: widget.name,
                      description: widget.description,
                    );
                  },
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
                    _buildSectionTitle('Preço'),
                    KondusTextFormField(
                      hintText: 'Digite o nome do produto',
                      controller: controller.priceEC,
                      inputFormatters: [
                        ProgressiveNumberInputFormatter()
                      ],
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
                        hintText: 'Digite a quantidade',
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
