import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProduct extends ProductEvent {}

class ChangeFilter extends ProductEvent {
  final ProductFilter productFilter;
  const ChangeFilter({required this.productFilter});
  @override
  List<Object> get props => [productFilter];
}

class ApplyFilter extends ProductEvent {
  final ProductFilter productFilter;

  const ApplyFilter({required this.productFilter});

  @override
  List<Object> get props => [productFilter];
}
