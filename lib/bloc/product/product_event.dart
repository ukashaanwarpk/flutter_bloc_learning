import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProduct extends ProductEvent {}




class SearchEvent extends ProductEvent {
  final String query;

  const SearchEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class ChangeFilter extends ProductEvent {
  final ProductFilter productFilter;
  const ChangeFilter({required this.productFilter});
  @override
  List<Object> get props => [productFilter];
}

class SliderEvent extends ProductEvent {
  final double minPrice;
  final double maxPrice;

  const SliderEvent({required this.minPrice, required this.maxPrice});
  @override
  List<Object> get props => [minPrice, maxPrice];
}

class TextFieldEvent extends ProductEvent {
  final double minPrice;
  final double maxPrice;
  const TextFieldEvent({required this.minPrice, required this.maxPrice});
  @override
  List<Object> get props => [minPrice, maxPrice];
}

class ApplyFilter extends ProductEvent {
  final ProductFilter productFilter;

  const ApplyFilter({required this.productFilter});

  @override
  List<Object> get props => [productFilter];
}

class ResetEvent extends ProductEvent {}
