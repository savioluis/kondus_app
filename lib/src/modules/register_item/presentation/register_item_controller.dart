import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/dtos/items/category_dto.dart';
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

  goToStep2(ItemType? itemType) {
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

    NavigatorProvider.navigateTo(
      AppRoutes.registerItemStep2,
      arguments: RouteArguments<List<dynamic>>(
        [itemType, name, description],
      ),
    );
  }

  registerItem({
    required String name,
    required String description,
  }) {
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

    final price = priceEC.value.text;
    final categories = selectedCategories;
    final type = selectedType!;
    final quantity = quantityEC.value.text;

    final itemModel = RegisterItemModel(
      title: name,
      description: description,
      type: type,
      price: double.parse(price),
      quantity: int.tryParse(quantity) ?? 0,
      categoriesIds: categories.map((category) => category.id).toList(),
    );

    print(itemModel);
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
}
