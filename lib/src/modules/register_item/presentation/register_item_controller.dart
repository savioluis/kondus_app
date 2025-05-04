import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/dtos/items/category_dto.dart';
import 'package:kondus/core/services/dtos/items/register_item_request_dto.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/utils/input_validator.dart';
import 'package:kondus/src/modules/register_item/model/register_item_model.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_state.dart';

class RegisterItemController extends ChangeNotifier {
  final ItemsService _itemsService = GetIt.instance<ItemsService>();

  RegisterItemState _state = RegisterItemInitialState();

  RegisterItemState get state => _state;

  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final priceEC = TextEditingController();

  String? selectedType;
  bool isAutoFilledType = false;
  List<CategoryDTO> selectedCategories = [];

  final quantityEC = TextEditingController();
  final List<File> imagesFiles = [];

  int? createdItemId;

  Future<void> loadCategories() async {
    _emitState(RegisterItemLoadingState());
    try {
      final response = await _itemsService.getAllCategories();

      if (response.isEmpty) {
        _emitState(
          RegisterItemFailureState(
            error: KondusError(
              message: 'Nenhuma categoria encontrada.',
              type: KondusErrorType.empty,
            ),
          ),
        );
      }

      final categories = response;

      _emitState(RegisterItemSuccessState(categories: categories));
    } on HttpError catch (e) {
      _emitState(RegisterItemFailureState(error: e));
    }
  }

  updateCategories(List<CategoryDTO> newCategories) {
    selectedCategories = newCategories;
    final currentState = state as RegisterItemSuccessState;
    _emitState(
      currentState.copyWith(validationErrorMessage: null),
    );
  }

  void goToStep2({
    ItemType? itemType,
    String? actionType,
    List<int>? categoriesIds,
  }) {
    final validationError = _validateFieldsStep1(
      name: nameEC.value.text,
      description: descriptionEC.value.text,
    );

    if (validationError != null) {
      _emitState(
        RegisterItemValidationErrorState(
          validationErrorMessage: validationError,
        ),
      );
      return;
    }

    final name = nameEC.value.text;
    final description = descriptionEC.value.text;
    final imagesPaths = imagesFiles.map((e) => e.path).toList();

    NavigatorProvider.navigateTo(
      AppRoutes.registerItemStep2,
      arguments: RouteArguments<List<dynamic>>(
        [
          itemType,
          name,
          description,
          imagesPaths,
          actionType,
          categoriesIds,
        ],
      ),
    );
  }

  Future<void> registerItem({
    required String name,
    required String description,
    List<String>? imagesFilesPaths,
  }) async {
    final currentState = state as RegisterItemSuccessState;

    final validationError = _validateFieldsStep2(
      price: priceEC.value.text,
      categories: selectedCategories,
      type: selectedType,
      quantity: quantityEC.value.text,
    );

    if (validationError != null) {
      _emitState(
        currentState.copyWith(validationErrorMessage: validationError),
      );
      return;
    }

    _emitState(currentState.copyWith(isSubmitting: true));

    final price = priceEC.value.text;
    final categories = selectedCategories;
    final type = selectedType!;
    final quantity = quantityEC.value.text;

    final item = RegisterItemRequestDTO(
      title: name,
      description: description,
      type: ItemTypeExtension.fromRegisterItemType(type).toJsonValue(),
      price: double.parse(price),
      quantity: int.tryParse(quantity) ?? 0,
      categoriesIds: categories.map((category) => category.id).toList(),
    );

    try {
      if (createdItemId == null) {
        final itemId = await _itemsService.registerItem(request: item);
        createdItemId = itemId;
      }

      if (imagesFilesPaths != null && imagesFilesPaths.isNotEmpty) {
        try {
          await _itemsService.uploadImagesForItem(
            imagesFilesPaths: imagesFilesPaths,
            itemId: createdItemId!,
          );

          _emitState(RegisteredItemWithSuccess(itemName: name));
        } catch (uploadError) {
          _emitState(
            RegisterItemFailureState(
              error: KondusError(
                message: 'Falha ao salvar as imagens. Tente novamente',
                type: KondusErrorType.upload,
              ),
            ),
          );
        }
      } else {
        _emitState(RegisteredItemWithSuccess(itemName: name));
      }
    } on HttpError catch (e) {
      _emitState(RegisterItemFailureState(error: e));
    }
  }

  String? _validateFieldsStep1({
    required String name,
    required String description,
  }) {
    final nameValidationError = InputValidator.validateName(name: name);
    if (nameValidationError != null) return nameValidationError;

    final descriptionValidationError =
        description.isEmpty ? 'A descrição é obrigatória.' : null;

    if (descriptionValidationError != null) return descriptionValidationError;

    return null;
  }

  void addImages(List<File> images) {
    final allowedExtensions = ['.png', '.jpg', '.jpeg'];

    final validImages = images.where((file) {
      final extens = file.path.toLowerCase();
      return allowedExtensions.any((ext) => extens.endsWith(ext));
    }).toList();

    imagesFiles.addAll(validImages);
    notifyListeners();
  }

  void applyFieldsIfExistsStep1({String? itemName, String? description}) {
    if (itemName != null) {
      nameEC.text = itemName;
    }
    if (description != null) {
      descriptionEC.text = description;
    }
  }

  Future<void> applyFieldsIfExistsStep2(
      {List<int>? categoriesIds, String? actionType}) async {
    if (categoriesIds != null) {
      final allCategories = await _itemsService.getAllCategories();

      selectedCategories = allCategories
          .where(
            (category) => categoriesIds.contains(category.id),
          )
          .toList();
    }
    if (actionType != null) {
      selectedType = actionType;
    }
  }

  String? _validateFieldsStep2({
    required String price,
    required List<CategoryDTO> categories,
    required String? type,
    required String? quantity,
  }) {
    final priceValidationError = InputValidator.validatePrice(value: price);

    if (priceValidationError != null) return priceValidationError;

    final categoriesValidationErrorr =
        categories.isEmpty ? 'Categoria é obrigatória.' : null;

    if (categoriesValidationErrorr != null) return categoriesValidationErrorr;

    final typeValidationError =
        (type == null || type.isEmpty) ? 'O tipo é obrigatório.' : null;

    if (typeValidationError != null) return typeValidationError;

    String? quantityValidationError;

    if (type != 'Aluguel') {
      if (quantity != null && quantity.isNotEmpty) {
        int quantityAsDouble = int.tryParse(quantity) ?? 0;
        if (quantityAsDouble < 1)
          quantityValidationError = 'Insira uma quantidade válida.';
      } else {
        quantityValidationError = 'A quantidade é obrigatória.';
      }
    }

    if (quantityValidationError != null) return quantityValidationError;

    return null;
  }

  _emitState(RegisterItemState newState) {
    _state = newState;
    notifyListeners();
    log('Novo estado emitido: $newState');
  }

  @override
  void dispose() {
    super.dispose();
    imagesFiles.clear();
    nameEC.dispose();
    descriptionEC.dispose();
    priceEC.dispose();
    quantityEC.dispose();
  }
}
