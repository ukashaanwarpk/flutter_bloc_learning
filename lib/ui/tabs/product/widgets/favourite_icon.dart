import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/favourite_product/favourite_product_bloc.dart';
import 'package:flutter_bloc_learning/bloc/favourite_product/favourite_product_event.dart';
import 'package:flutter_bloc_learning/bloc/favourite_product/favourite_product_state.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';
import 'package:flutter_bloc_learning/utils/utils.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteProductBloc, FavouriteProductState>(
        buildWhen: (previous, current) => previous.favouriteProductList != current.favouriteProductList,
        builder: (context, state) {
          final isFavourite = state.favouriteProductList.any((element) => element.id == product.id);
          return GestureDetector(
            onTap: () {
              if (isFavourite) {
                Utils.showToast('Product removed from favourite');
              } else {
                Utils.showToast('Product added to favourite');
              }

              context.read<FavouriteProductBloc>().add(AddtoFavouriteEvent(productModel: product));
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                    color: const Color(0x00000000).withValues(alpha: 0.25),
                  )
                ],
                color: const Color(0xffffffff),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: isFavourite ? Colors.red : const Color(0xff000000),
                  size: 15,
                ),
              ),
            ),
          );
        });
  }
}
