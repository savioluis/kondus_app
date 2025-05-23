import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/utils/snack_bar_helper.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/core/widgets/photo_view_page.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_controller.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_state.dart';
import 'package:kondus/src/modules/register_item/widgets/register_item_step_1_appbar.dart';

class RegisterItemStep1Page extends StatefulWidget {
  const RegisterItemStep1Page({
    this.itemType,
    this.itemName,
    this.description,
    this.categoriesIds,
    this.actionType,
    super.key,
  });

  final ItemType? itemType;
  final String? itemName;
  final String? description;
  final List<int>? categoriesIds;
  final String? actionType;

  @override
  State<RegisterItemStep1Page> createState() => _RegisterItemPageSStep1tate();
}

class _RegisterItemPageSStep1tate extends State<RegisterItemStep1Page> {
  late final RegisterItemController controller;

  @override
  void initState() {
    super.initState();
    controller = RegisterItemController();
    controller.addListener(_controllerListener);
    controller.applyFieldsIfExistsStep1(
      itemName: widget.itemName,
      description: widget.description,
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

    if (state is RegisterItemValidationErrorState &&
        state.validationErrorMessage != null) {
      SnackBarHelper.showMessageSnackBar(
        message: state.validationErrorMessage!,
        context: context,
      );
    }
  }

  String _getContentTypeValue() {
    if (widget.itemType == null) return 'item';
    if (widget.itemType == ItemType.servico) return 'serviço';
    return 'produto';
  }

  @override
  Widget build(BuildContext context) {
    final contentTypeValue = _getContentTypeValue();

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: RegisterItemAppbar(
            isOnlyItem: widget.itemType == null,
            itemType: widget.itemType,
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
                  label: 'Próximo',
                  onPressed: () {
                    controller.goToStep2(
                      itemType: widget.itemType,
                      categoriesIds: widget.categoriesIds,
                      actionType: widget.actionType,
                    );
                  },
                ),
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
                    hintText: 'Digite o nome do $contentTypeValue...',
                    controller: controller.nameEC,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Descrição'),
                  KondusTextFormField(
                    hintText: 'Digite a descrição do $contentTypeValue...',
                    controller: controller.descriptionEC,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Imagens'),
                  if (controller.imagesFiles.isNotEmpty) ...{
                    SizedBox(
                      height: 132,
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
                                height: 132,
                                width: 132,
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
                                      size: 50,
                                      color: context.lightGreyColor,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Enviar mais imagens',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12.5),
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
                        height: 132,
                        width: 132,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: context.lightGreyColor.withOpacity(0),
                            border: Border.all(color: context.lightGreyColor)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedImageAdd02,
                              size: 56,
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
          width: 132,
          height: 132,
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
