import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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

  // Future<void> fetchProducts(String query,
  //     [List<CategoryModel> selectedCategories = const []]) async {
  //   if (query.isEmpty) {
  //     _emitState(SearchInitial());
  //     return;
  //   }

  //   _emitState(SearchLoading());

  //   try {
  //     final response = await _itemsService.getAllItems(
  //       filters: ItemsFiltersModel(
  //         categoriesIds: selectedCategories.map((e) => e.id).toList(),
  //         types: [],
  //         query: query,
  //       ),
  //     );

  //     if (response == null || response.items.isEmpty) {
  //       _emitState(const SearchFailure('Nenhum produto encontrado.'));
  //       return;
  //     }

  //     final items = ProductDTO.fromItemResponseDTO(response);

  //     _emitState(
  //       SearchSuccess(items, selectedCategories),
  //     );
  //   } catch (e) {
  //     _emitState(const SearchFailure('Erro ao buscar produtos.'));
  //   }
  // }

  void onFiltersChanged(List<CategoryModel> newCategories) {
    selectedCategories = newCategories;
    fetchItems();
  }

  Future<void> fetchItems() async {
    final query = searchController.text;

    if (query.isEmpty && selectedCategories.isEmpty) {
      _emitState(SearchInitial());
      return;
    }

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
        _emitState(const SearchFailure('Nenhum produto encontrado.'));
        return;
      }

      final products = ProductDTO.fromItemResponseDTO(response);

      _emitState(SearchSuccess(products, selectedCategories));
    } catch (e) {
      _emitState(const SearchFailure('Erro ao buscar produtos.'));
    }
  }

  void removeCategory(CategoryModel category) {
  selectedCategories.removeWhere((cat) => cat.id == category.id);

  if (searchController.text.isNotEmpty) {
    fetchItems();
  } else {
    notifyListeners();
  }
}


  void onSearchChanged(String query) {
    fetchItems();
  }

  void _emitState(SearchState newState) {
    _state = newState;
    notifyListeners();
  }
}
