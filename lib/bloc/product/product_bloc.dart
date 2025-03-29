import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/product/product_event.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';
import 'package:flutter_bloc_learning/repository/product_repository.dart';
import '../../utils/enum.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;
  ProductBloc(this.productRepository) : super(ProductState()) {
    on<FetchProduct>(_fetchProduct);
    on<ChangeFilter>(_changeFilter);
    on<ApplyFilter>(_applyFilter);
  }

  void _fetchProduct(FetchProduct event, Emitter<ProductState> emit) async {
    try {
      final productData = await productRepository.getProducts();

      emit(state.copyWith(
        productStatus: ProductStatus.success,
        productsList: productData,
        message: 'Success',
      ));
    } catch (e) {
      emit(state.copyWith(
          productStatus: ProductStatus.error, message: e.toString()));
    }
  }

  void _changeFilter(ChangeFilter event, Emitter<ProductState> emit) {
    emit(state.copyWith(productFilter: event.productFilter));
  }

 void _applyFilter(ApplyFilter event, Emitter<ProductState> emit) {
  // Create a new copy of the current list
  final List<ProductModel> sortedList = List.from(state.productsList);

  switch (event.productFilter) {
    case ProductFilter.sortByAToZ:
      sortedList.sort((a, b) => a.title!.compareTo(b.title!));
      break;
    case ProductFilter.sortByPrice:
      sortedList.sort((a, b) => a.price!.compareTo(b.price!));
      break;
    case ProductFilter.sortByRating:
      // For rating, you might choose descending order
      sortedList.sort((a, b) => b.rating!.rate!.compareTo(double.parse(a.rating!.rate.toString())));
      break;
  }

  emit(state.copyWith(
    productsList: sortedList,
    productFilter: event.productFilter,
  ));
}

}
