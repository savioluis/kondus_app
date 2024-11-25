import 'package:equatable/equatable.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductDTO> products;

  const SearchSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class SearchFailure extends SearchState {
  final String errorMessage;

  const SearchFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
