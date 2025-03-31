import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/product/product_bloc.dart';
import 'package:flutter_bloc_learning/bloc/product/product_event.dart';
import 'package:flutter_bloc_learning/bloc/product/product_state.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(FetchProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBF9F9),
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
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color(0xffD9D9D9),
                          size: 25,
                        ),
                        filled: true,
                        fillColor: Color(0xffffffff),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search in here',
                        hintStyle: TextStyle(
                          color: Color(0xffCACACA),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.menu,
                      color: Color(0xff000000),
                      size: 25,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          backgroundColor: Color(0xffffffff),
                          context: context,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.6,
                              child: BlocBuilder<ProductBloc, ProductState>(
                                buildWhen: (previous, current) =>
                                    previous.productFilter !=
                                    current.productFilter,
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      RadioListTile(
                                        value: ProductFilter.sortByAToZ,
                                        groupValue: state.productFilter,
                                        onChanged: (value) {
                                          context.read<ProductBloc>().add(
                                              ChangeFilter(
                                                  productFilter: value!));
                                        },
                                        title: Text(
                                          'Sort by A to Z',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff000000),
                                            fontFamily:
                                                GoogleFonts.inter().fontFamily,
                                          ),
                                        ),
                                      ),
                                      RadioListTile(
                                        value: ProductFilter.sortByPrice,
                                        groupValue: state.productFilter,
                                        onChanged: (value) {
                                          context.read<ProductBloc>().add(
                                              ChangeFilter(
                                                  productFilter: value!));
                                        },
                                        title: Text(
                                          'Sort by price',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff000000),
                                            fontFamily:
                                                GoogleFonts.inter().fontFamily,
                                          ),
                                        ),
                                      ),
                                      RadioListTile(
                                        value: ProductFilter.sortByRating,
                                        groupValue: state.productFilter,
                                        onChanged: (value) {
                                          context.read<ProductBloc>().add(
                                              ChangeFilter(
                                                  productFilter: value!));
                                        },
                                        title: Text(
                                          'Sort by rating',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff000000),
                                            fontFamily:
                                                GoogleFonts.inter().fontFamily,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SfRangeSlider(
                                          interval: 20,
                                          showTicks: true,
                                          showLabels: true,
                                          enableTooltip: true,
                                          minorTicksPerInterval: 1,
                                          values: SfRangeValues(40, 80),
                                          onChanged: (value) {}),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () {
                                            final currentFilter =
                                                state.productFilter;
                                            context.read<ProductBloc>().add(
                                                ApplyFilter(
                                                    productFilter:
                                                        currentFilter));
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Apply',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: GoogleFonts.inter()
                                                  .fontFamily,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shop by Categories',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.inter().fontFamily),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                        color: Color(0xff0DA54B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.inter().fontFamily),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => SizedBox(
                    width: 10,
                  ),
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 90,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xff7AF97A),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xffffffff),
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                          ),
                          Text(
                            'Popular',
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.inter().fontFamily),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.inter().fontFamily),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                        color: Color(0xff0DA54B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.inter().fontFamily),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                switch (state.productStatus) {
                  case ProductStatus.loading:
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff0DA54B),
                      ),
                    );
                  case ProductStatus.error:
                    return Center(child: Text(state.message.toString()));
                  case ProductStatus.success:
                    return Expanded(
                      child: GridView.builder(
                          itemCount: state.productsList.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.64,
                          ),
                          itemBuilder: (context, index) {
                            final product = state.productsList[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    offset: Offset(0, 4),
                                    color: Color(0x00000000)
                                        .withValues(alpha: 0.25),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          width: double.infinity,
                                          height: 170,
                                          fit: BoxFit.cover,
                                          product.image.toString(),
                                        ),
                                      ),
                                      Positioned(
                                        top: 15,
                                        left: 7,
                                        right: 7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 19,
                                              width: 47,
                                              decoration: BoxDecoration(
                                                color: Color(0xffffffff),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4,
                                                    spreadRadius: 0,
                                                    offset: Offset(0, 4),
                                                    color: Color(0x00000000)
                                                        .withValues(
                                                            alpha: 0.25),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                spacing: 2,
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    size: 15,
                                                    color: Color(0xffFDCC0D),
                                                  ),
                                                  Text(
                                                    product.rating!.rate
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Color(0xff000000),
                                                      fontFamily:
                                                          GoogleFonts.inter()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    offset: Offset(0, 4),
                                                    color: Color(0x00000000)
                                                        .withValues(
                                                            alpha: 0.25),
                                                  )
                                                ],
                                                color: Color(0xffffffff),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
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
                                  SizedBox(
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
                                            fontFamily:
                                                GoogleFonts.inter().fontFamily,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\$${product.price.toString()}',
                                              style: TextStyle(
                                                fontFamily: GoogleFonts.inter()
                                                    .fontFamily,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: Color(0xffE4E4E4),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.shopping_bag,
                                                size: 10,
                                                color: Color(0xff000000),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
