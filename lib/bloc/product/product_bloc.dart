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
  List<ProductModel> tempList = [];
  ProductBloc(this.productRepository) : super(const ProductState()) {
    on<FetchProduct>(_fetchProduct);
    on<SearchEvent>(_searchEvent);
    on<ChangeFilter>(_changeFilter);
    on<ApplyFilter>(_applyFilter);
    on<SliderEvent>(_sliderEvent);
    on<TextFieldEvent>(_textFieldEvent);
    on<ResetEvent>(_resetEvent);
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
    } catch (e) {
      debugPrint('The error in _fetchProduct $e');
      emit(state.copyWith(
          productStatus: ProductStatus.error, message: e.toString()));
    }
  }

  void _searchEvent(SearchEvent event, Emitter<ProductState> emit) {
    if (event.query.isEmpty) {
      emit(state.copyWith(
        tempList: const <ProductModel>[],
        searchMessage: '',
      ));
      return;
    } else {
      tempList = state.productsList
          .where((product) =>
              product.title!.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      if (tempList.isEmpty) {
        emit(state.copyWith(
          tempList: const <ProductModel>[],
          searchMessage: 'No items found for "${event.query}"',
        ));
      } else {
        emit(state.copyWith(
          tempList: tempList,
          searchMessage: '',
        ));
      }
    }
  }

  void _changeFilter(ChangeFilter event, Emitter<ProductState> emit) {
    emit(state.copyWith(productFilter: event.productFilter));
  }

  void _sliderEvent(SliderEvent event, Emitter<ProductState> emit) {
    emit(state.copyWith(
        selectedMinPrice: event.minPrice, selectedMaxPrice: event.maxPrice));
  }

  void _textFieldEvent(TextFieldEvent event, Emitter<ProductState> emit) {
    emit(state.copyWith(
      selectedMinPrice: event.minPrice,
      selectedMaxPrice: event.maxPrice,
    ));
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

    if (filteredList.isEmpty) {
      debugPrint('No products found in this range');
      emit(state.copyWith(filterMessage: 'No products found in this range'));
    }
    else{
      emit(state.copyWith(filterMessage: ''));
    }

    switch (event.productFilter) {
      case ProductFilter.sortByAToZ:
        filteredList.sort((a, b) => a.title!.compareTo(b.title!));
        break;
      case ProductFilter.sortByZToA:
        filteredList.sort((a, b) => b.title!.compareTo(a.title!));
        break;
      case ProductFilter.sortByPriceHighToLow:
        filteredList.sort((a, b) => b.price!.compareTo(a.price!));
        break;
      case ProductFilter.sortByPriceLowToHigh:
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

  _resetEvent(ResetEvent event, Emitter<ProductState> emit) {
    emit(state.copyWith(
      selectedMinPrice: state.productMinPrice,
      selectedMaxPrice: state.productMaxPrice,
      filterProductsList: state.productsList,
      productFilter: ProductFilter.sortByAToZ,
      filterMessage: '',
      searchMessage:'',
    ));
  }
}
