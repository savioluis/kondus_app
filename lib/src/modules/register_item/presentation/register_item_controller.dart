import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/core/utils/input_validator.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_state.dart';

class RegisterItemController extends ChangeNotifier {
  final ItemsService _itemsService = GetIt.instance<ItemsService>();

  RegisterItemState _state = RegisterItemStep1State();

  RegisterItemState get state => _state;

  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final priceEC = TextEditingController();

  String? selectedType;

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

  goToStep2() {
    final validationError = _validateFields(
      name: nameEC.value.text,
      price: priceEC.value.text,
      description: descriptionEC.value.text,
    );

    final currentState = state as RegisterItemStep1State;

    if (validationError != null) {
      _emitState(
          currentState.copyWith(validationErrorMessage: validationError));
      return;
    }

    final name = nameEC.value.text;
    final price = priceEC.value.text;
    final description = descriptionEC.value.text;

    NavigatorProvider.navigateTo(
      '',
      arguments: RouteArguments<List<String>>(
        [name, price, description],
      ),
    );
  }

  String? _validateFields({
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

  _emitState(RegisterItemState newState) {
    _state = newState;
    notifyListeners();
    log('Novo estado emitido: $newState');
  }
}
