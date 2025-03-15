import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/product/product_event.dart';
import 'package:flutter_bloc_learning/repository/product_repository.dart';
import '../../utils/enum.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;
  ProductBloc(this.productRepository) : super(ProductState()) {
    on<FetchProduct>(_fetchProduct);
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
}
