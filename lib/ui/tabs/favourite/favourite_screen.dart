import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_bloc.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_event.dart';
import 'package:flutter_bloc_learning/bloc/favourite_product/favourite_product_bloc.dart';
import 'package:flutter_bloc_learning/bloc/favourite_product/favourite_product_state.dart';
import 'package:flutter_bloc_learning/ui/tabs/product/details_screen.dart';
import 'package:flutter_bloc_learning/ui/tabs/product/widgets/favourite_icon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteProductScreen extends StatelessWidget {
  const FavouriteProductScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<FavouriteProductBloc, FavouriteProductState>(builder: (context, state) {
          if (state.favouriteProductList.isEmpty) {
            return Center(
              child: Text(
                'No favourite products',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          } else {
            return GridView.builder(
              itemCount: state.favouriteProductList.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                childAspectRatio: 0.64,
              ),
              itemBuilder: (context, index) {
                final product = state.favouriteProductList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          productModel: product,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Hero(
                                tag: product.id.toString(),
                                child: Image.network(
                                  width: double.infinity,
                                  height: 170,
                                  fit: BoxFit.cover,
                                  product.image.toString(),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              left: 7,
                              right: 7,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 19,
                                    width: 47,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          spreadRadius: 0,
                                          offset: const Offset(0, 4),
                                          color: const Color(0x00000000).withValues(alpha: 0.25),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      spacing: 2,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Color(0xffFDCC0D),
                                        ),
                                        Text(
                                          product.rating!.rate.toString(),
                                          style: TextStyle(
                                            color: const Color(0xff000000),
                                            fontFamily: GoogleFonts.inter().fontFamily,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                 TFavouriteIcon(product: product),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Column(
                            children: [
                              Text(
                                product.title.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${product.price.toString()}',
                                    style: TextStyle(
                                      fontFamily: GoogleFonts.inter().fontFamily,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<CartBloc>().add(AddToCartEvent(productModel: product, quantity: 1));
                                      Fluttertoast.showToast(
                                        msg: 'Product added to cart',
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        gravity: ToastGravity.TOP,
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffE4E4E4),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.shopping_bag,
                                        size: 10,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
