import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/product/product_event.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';
import 'package:flutter_bloc_learning/repository/product_repository.dart';
import '../../utils/enum.dart';
import 'product_state.dart';
import 'dart:math';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;
  ProductBloc(this.productRepository) : super(ProductState()) {
    on<FetchProduct>(_fetchProduct);
    on<ChangeFilter>(_changeFilter);
    on<ApplyFilter>(_applyFilter);

    on<SliderEvent>(_sliderEvent);
  }

  void _fetchProduct(FetchProduct event, Emitter<ProductState> emit) async {
    try {
      final productData = await productRepository.getProducts();

      // Calculate min and max prices from the fetched products
      double minPrice = 0;
      double maxPrice = 0;

      if (productData.isNotEmpty) {
        minPrice = productData.map((e) => e.price!).reduce(min);
        maxPrice = productData.map((e) => e.price!).reduce(max);
      }

      emit(state.copyWith(
        productStatus: ProductStatus.success,
        productsList: productData,
        filterProductsList: productData,
        message: 'Success',
        productMinPrice: minPrice,
        productMaxPrice: maxPrice,
        selectedMinPrice: minPrice,
        selectedMaxPrice: maxPrice,
      ));
      // Add debug print to verify values
      debugPrint('After fetch: minPrice=$minPrice, maxPrice=$maxPrice');
    } catch (e) {
      emit(state.copyWith(
          productStatus: ProductStatus.error, message: e.toString()));
    }
  }

  void _changeFilter(ChangeFilter event, Emitter<ProductState> emit) {
    emit(state.copyWith(productFilter: event.productFilter));
  }

  void _sliderEvent(SliderEvent event, Emitter<ProductState> emit) {
    emit(state.copyWith(
        selectedMinPrice: event.minPrice, selectedMaxPrice: event.maxPrice));
  }

  void _applyFilter(ApplyFilter event, Emitter<ProductState> emit) {
      // Create a new copy of the ORIGINAL list, not the current filtered one

    final List<ProductModel> sortedList = List.from(state.productsList);

    // First filter by price range
    final filteredList = sortedList
        .where((product) =>
            product.price! >= state.selectedMinPrice &&
            product.price! <= state.selectedMaxPrice)
        .toList();

    switch (event.productFilter) {
      case ProductFilter.sortByAToZ:
        filteredList.sort((a, b) => a.title!.compareTo(b.title!));
        break;
      case ProductFilter.sortByPrice:
        filteredList.sort((a, b) => a.price!.compareTo(b.price!));
        break;
      case ProductFilter.sortByRating:
        // For rating, you might choose descending order
        filteredList.sort((a, b) =>
            b.rating!.rate!.compareTo(double.parse(a.rating!.rate.toString())));
        break;
    }

    emit(state.copyWith(
      filterProductsList: filteredList,
      productFilter: event.productFilter,
    ));
  }
}
