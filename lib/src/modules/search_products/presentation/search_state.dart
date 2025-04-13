import 'package:equatable/equatable.dart';
import 'package:kondus/core/error/kondus_error.dart';
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
  // TODO: migrate to itemDTO and fix the dependencies
  final List<ProductDTO> products;

  const SearchSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class SearchFailureState extends SearchState {
  final KondusFailure error;

  const SearchFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class SearchFailurePageState extends SearchState {

}
