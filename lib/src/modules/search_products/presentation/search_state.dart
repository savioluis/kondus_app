import 'package:equatable/equatable.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  // migrate to itemDTO and fix the dependencies
  final List<ProductDTO> products;
  final List<CategoryModel> selectedCategories;

  const SearchSuccess(this.products, this.selectedCategories);

  @override
  List<Object?> get props => [products, selectedCategories];
}

class SearchFailure extends SearchState {
  final String errorMessage;

  const SearchFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
