import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_bloc.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_event.dart';
import 'package:flutter_bloc_learning/bloc/product/product_bloc.dart';
import 'package:flutter_bloc_learning/bloc/product/product_event.dart';
import 'package:flutter_bloc_learning/bloc/product/product_state.dart';
import 'package:flutter_bloc_learning/ui/tabs/product/details_screen.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/category_widget.dart';
import 'widgets/heading_widget.dart';
import 'widgets/show_filter_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(FetchProduct());
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBF9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextFormField(
                      onChanged: (value) {
                        context.read<ProductBloc>().add(
                              SearchEvent(query: value),
                            );
                      },
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Color(0xffD9D9D9),
                          size: 25,
                        ),
                        filled: true,
                        fillColor: const Color(0xffffffff),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search in here',
                        hintStyle: TextStyle(
                          color: const Color(0xffCACACA),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.menu,
                      color: Color(0xff000000),
                      size: 25,
                    ),
                    onPressed: () {
                      showFilterSheet(
                        context,
                        minPriceController: minPriceController,
                        maxPriceController: maxPriceController,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const HeadingWidget(
                title: 'Shop by Categories',
                traling: 'See All',
              ),
              const SizedBox(
                height: 20,
              ),
              const CategoryWidget(),
              const SizedBox(
                height: 30,
              ),
              const HeadingWidget(
                title: 'Recommended',
                traling: 'See All',
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                switch (state.productStatus) {
                  case ProductStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff0DA54B),
                      ),
                    );
                  case ProductStatus.error:
                    return Center(child: Text(state.message.toString()));
                  case ProductStatus.success:
                    return state.filterMessage.isNotEmpty
                        ? Center(child: Text(state.filterMessage))
                        : Expanded(
                            child: state.searchMessage.isNotEmpty
                                ? Center(
                                    child: Text(state.searchMessage),
                                  )
                                : GridView.builder(
                                    itemCount: state.tempList.isEmpty ? state.filterProductsList.length : state.tempList.length,
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: 0.64,
                                    ),
                                    itemBuilder: (context, index) {
                                      final product = state.tempList.isEmpty ? state.filterProductsList[index] : state.tempList[index];
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
                                                        Container(
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
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.favorite_border,
                                                              color: Color(0xff000000),
                                                              size: 15,
                                                            ),
                                                          ),
                                                        ),
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
                                                            context
                                                                .read<CartBloc>()
                                                                .add(AddToCartEvent(productModel: product, quantity: 1));
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
                                    }),
                          );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
