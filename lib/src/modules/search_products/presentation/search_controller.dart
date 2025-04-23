import 'dart:async';
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

  Timer? _debounce;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  loadInitialData() {
    _emitState(SearchLoading());
    fetchItems();
  }

  Future<void> fetchItems() async {
    final query = searchController.text;

    final currentState = state;

    if (currentState is SearchSuccess) {
      _emitState(currentState.copyWith(isLoadingMoreItems: true));
    }

    try {
      final response = await _itemsService.getAllItems(
        filters: ItemsFiltersModel(
          query: query,
          categoriesIds: selectedCategories.map((c) => c.id).toList(),
          types: [],
        ),
      );

      if (response == null || response.items.isEmpty) {
        _emitState(const SearchSuccess(products: [], isLoadingMoreItems: false));
        return;
      }

      final products = ProductDTO.fromItemResponseDTO(response);

      _emitState(SearchSuccess(products: products, isLoadingMoreItems: false));
    } on HttpError catch (e) {
      _emitState(SearchFailureState(e));
    }
  }

  void onFiltersChanged(List<CategoryModel> newCategories) {
    selectedCategories = newCategories;
    fetchItems();
  }

  void onSearchChanged(String query) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 750), () {
      fetchItems();
    });
  }

  void _emitState(SearchState newState) {
    log('Estado emitido: $newState');
    _state = newState;
    notifyListeners();
  }
}
