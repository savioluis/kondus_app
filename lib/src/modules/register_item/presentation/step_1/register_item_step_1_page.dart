import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/utils/snack_bar_helper.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/header_section.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/core/widgets/photo_view_page.dart';
import 'package:kondus/src/modules/home/widgets/product_card.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_controller.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_state.dart';
import 'package:kondus/src/modules/register_item/widgets/custom_dropdown_field.dart';
import 'package:kondus/src/modules/register_item/widgets/register_item_step_1_appbar.dart';

class RegisterItemPage extends StatefulWidget {
  const RegisterItemPage({this.itemType, super.key});

  final ItemType? itemType;

  @override
  _RegisterItemPageState createState() => _RegisterItemPageState();
}

class _RegisterItemPageState extends State<RegisterItemPage> {
  late final RegisterItemController controller;

  @override
  void initState() {
    super.initState();
    controller = RegisterItemController();
    controller.addListener(_controllerListener);
  }

  _controllerListener() {
    final state = controller.state;

    if (state is RegisterItemValidationErrorState &&
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
        return Scaffold(
          appBar: RegisterItemAppbar(
            isOnlyItem: widget.itemType == null,
            itemType: widget.itemType,
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: KondusButton(
                label: 'Próximo',
                onPressed: () {
                  controller.goToStep2(widget.itemType);
                },
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Nome'),
                  KondusTextFormField(
                    hintText: 'Digite o nome do produto',
                    controller: controller.nameEC,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Descrição'),
                  KondusTextFormField(
                    hintText: 'Digite a descrição do produto',
                    controller: controller.descriptionEC,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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

  Widget _buildImageTile(BuildContext context, String imageUrl) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoViewPage(imageUrl: imageUrl),
              ),
            );
          },
          onLongPress: () {},
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
