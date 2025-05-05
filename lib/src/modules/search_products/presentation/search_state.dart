import 'package:equatable/equatable.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  // TODO: migrate to itemDTO and fix the dependencies
  final List<ProductDTO> products;
  final bool isLoadingMoreItems;

  const SearchSuccess({required this.products ,this.isLoadingMoreItems = false});

  @override
  List<Object?> get props => [products, isLoadingMoreItems];

  SearchSuccess copyWith({
    List<ProductDTO>? products,
    bool? isLoadingMoreItems,
  }) {
    return SearchSuccess(
      products: products ?? this.products,
      isLoadingMoreItems: isLoadingMoreItems ?? this.isLoadingMoreItems,
    );
  }
}

class SearchFailureState extends SearchState {
  final KondusFailure error;

  const SearchFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class SearchFailurePageState extends SearchState {}
