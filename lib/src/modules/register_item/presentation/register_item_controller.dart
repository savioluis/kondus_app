import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/core/utils/input_validator.dart';
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
  List<String> selectedCategories = [];

  Future<void> registerItem() async {}

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

      final categories = response.map((e) => e.name).toList();

      _emitState(RegisterItemSuccessState(categories: categories));
    } on HttpError catch (e) {
      _emitState(RegisterItemFailureState(error: e));
    }
  }

  updateCategories(List<String> newCategories) {
    selectedCategories = newCategories;
    notifyListeners();
  }

  goToStep2(ItemType? itemType) {
    final validationError = _validateFieldsStep1(
      name: nameEC.value.text,
      price: priceEC.value.text,
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
    final price = priceEC.value.text;
    final description = descriptionEC.value.text;

    NavigatorProvider.navigateTo(
      AppRoutes.registerItemStep2,
      arguments: RouteArguments<List<dynamic>>(
        [itemType, name, price, description],
      ),
    );
  }

  goToStep3(
      {ItemType? itemType,
      required String name,
      required String price,
      required String description}) {
    final validationError = _validateFieldsStep2(
      type: selectedType,
      categories: selectedCategories,
    );

    if (validationError != null) {
      _emitState(
        RegisterItemValidationErrorState(
          validationErrorMessage: validationError,
        ),
      );
      return;
    }

    final type = selectedType!;
    final categories = selectedCategories;

    NavigatorProvider.navigateTo(
      AppRoutes.registerItemStep3,
      arguments: RouteArguments<List<dynamic>>(
        [itemType, name, price, description, type, categories],
      ),
    );
  }

  String? _validateFieldsStep1({
    required String name,
    required String price,
    required String description,
  }) {
    final nameValidationError = InputValidator.validateName(name: name);
    if (nameValidationError != null) return nameValidationError;

    final priceValidationError = InputValidator.validatePrice(value: price);

    if (priceValidationError != null) return priceValidationError;

    final descriptionValidationError =
        description.isEmpty ? 'A descrição é obrigatória.' : null;

    if (descriptionValidationError != null) return descriptionValidationError;

    return null;
  }

  String? _validateFieldsStep2({
    required String? type,
    required List<String> categories,
  }) {
    final typeValidationError =
        (type == null || type.isEmpty) ? 'O tipo é obrigatório.' : null;

    if (typeValidationError != null) return typeValidationError;

    final categoriesValidationErrorr =
        categories.isEmpty ? 'Categoria é obrigatória.' : null;

    if (categoriesValidationErrorr != null) return categoriesValidationErrorr;

    return null;
  }

  _emitState(RegisterItemState newState) {
    _state = newState;
    notifyListeners();
    log('Novo estado emitido: $newState');
  }
}
