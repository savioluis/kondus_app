import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';
import 'search_state.dart';

class SearchPageController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  SearchState _state = SearchInitial();
  SearchState get state => _state;

  final _itemsService = GetIt.instance<ItemsService>();

  List<CategoryModel> selectedCategories = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchItems() async {
    final query = searchController.text;

    _emitState(SearchLoading());

    try {
      final response = await _itemsService.getAllItems(
        filters: ItemsFiltersModel(
          query: query,
          categoriesIds: selectedCategories.map((c) => c.id).toList(),
          types: [],
        ),
      );

      if (response == null || response.items.isEmpty) {
        _emitState(
          SearchFailureState(
            KondusError(
              message: 'Nenhum produto encontrado.',
              type: KondusErrorType.empty,
            ),
          ),
        );
        return;
      }

      final products = ProductDTO.fromItemResponseDTO(response);

      _emitState(SearchSuccess(products, selectedCategories));
    } on HttpError catch (e) {
      _emitState(SearchFailureState(e));
    }
  }

  void onFiltersChanged(List<CategoryModel> newCategories) {
    selectedCategories = newCategories;
    fetchItems();
  }

  void onSearchChanged(String query) {
    fetchItems();
  }

  void _emitState(SearchState newState) {
    log('Estado emitido: $newState');
    _state = newState;
    notifyListeners();
  }
}
