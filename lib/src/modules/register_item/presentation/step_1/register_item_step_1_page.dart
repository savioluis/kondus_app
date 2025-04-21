import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
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
  const RegisterItemPage({this.itemType, this.itemName, super.key});

  final ItemType? itemType;
  final String? itemName;

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

    _applyItemNameIfExists();
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

  _applyItemNameIfExists() {
    if (widget.itemName != null) {
      controller.nameEC.text = widget.itemName!;
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
                  const SizedBox(height: 24),
                  _buildSectionTitle('Imagens'),
                  if (controller.imagesFiles.isNotEmpty) ...{
                    SizedBox(
                      height: 156,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == controller.imagesFiles.length) {
                            return InkWell(
                              onTap: () async {
                                final picker = ImagePicker();
                                final result = await picker.pickMultiImage();

                                if (result.isNotEmpty) {
                                  final files = result
                                      .map((xfile) => File(xfile.path))
                                      .toList();

                                  controller.addImages(files);
                                }
                              },
                              borderRadius: BorderRadius.circular(18),
                              child: Ink(
                                height: 156,
                                width: 156,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color:
                                        context.lightGreyColor.withOpacity(0),
                                    border: Border.all(
                                        color: context.lightGreyColor)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      HugeIcons.strokeRoundedImageAdd02,
                                      size: 82,
                                      color: context.lightGreyColor,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Enviar mais imagens',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          final currentImageFile =
                              controller.imagesFiles[index];
                          return _buildImageTile(context, currentImageFile);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemCount: controller.imagesFiles.length + 1,
                      ),
                    ),
                  } else
                    InkWell(
                      onTap: () async {
                        final picker = ImagePicker();
                        final result = await picker.pickMultiImage();

                        if (result.isNotEmpty) {
                          final files =
                              result.map((xfile) => File(xfile.path)).toList();
                          setState(() {
                            controller.imagesFiles.addAll(files);
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(18),
                      child: Ink(
                        height: 156,
                        width: 156,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: context.lightGreyColor.withOpacity(0),
                            border: Border.all(color: context.lightGreyColor)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedImageAdd02,
                              size: 82,
                              color: context.lightGreyColor,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Enviar imagens',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildImageTile(BuildContext context, File imageFile) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoViewPage(
                isFromNetwork: false,
                imageFile: imageFile,
              ),
            ),
          );
        },
        onLongPress: () {},
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          width: 156,
          height: 156,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: FileImage(imageFile),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
