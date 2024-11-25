import 'package:flutter/material.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';
import 'search_state.dart';

class SearchPageController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  SearchState _state = SearchInitial();
  SearchState get state => _state;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchProducts(String query) async {
    if (query.isEmpty) {
      _emitState(SearchInitial());
      return;
    }

    _emitState(SearchLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      final mockApiResponse = [
        ProductDTO(
          name: 'Furadeira X200',
          category: 'Ferramentas',
          actionType: 'Comprar',
          imageUrl: 'https://placehold.co/150.png',
        ),
        ProductDTO(
          name: 'Bolo de Chocolate',
          category: 'Alimentos',
          actionType: 'Comprar',
          imageUrl: 'https://placehold.co/150.png',
        ),
        ProductDTO(
          name: 'Curso de Inglês Online',
          category: 'Serviços',
          actionType: 'Contratar',
          imageUrl: 'https://placehold.co/150.png',
        ),
        ProductDTO(
          name: 'Apartamento Temporário',
          category: 'Imóveis',
          actionType: 'Alugar',
          imageUrl: 'https://placehold.co/150.png',
        ),
      ];

      final filteredProducts = mockApiResponse
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (filteredProducts.isEmpty) {
        _emitState(SearchFailure('Nenhum produto encontrado.'));
      } else {
        _emitState(SearchSuccess(filteredProducts));
      }
    } catch (e) {
      _emitState(SearchFailure('Erro ao buscar produtos.'));
    }
  }

  void onSearchChanged(String query) {
    fetchProducts(query);
  }

  void _emitState(SearchState newState) {
    _state = newState;
    notifyListeners();
  }
}
