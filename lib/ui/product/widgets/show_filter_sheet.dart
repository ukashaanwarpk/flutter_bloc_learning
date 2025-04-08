import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/product/product_bloc.dart';
import 'package:flutter_bloc_learning/bloc/product/product_event.dart';
import 'package:flutter_bloc_learning/bloc/product/product_state.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

Future<dynamic> showFilterSheet(BuildContext context,
    {required TextEditingController minPriceController,
    required TextEditingController maxPriceController}) {
  if (minPriceController.text.isEmpty && maxPriceController.text.isEmpty) {
    final state = context.read<ProductBloc>().state;
    minPriceController.text = state.selectedMinPrice.toStringAsFixed(0);
    maxPriceController.text = state.selectedMaxPrice.toStringAsFixed(0);
  }
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Color(0xffffffff),
      context: context,
      builder: (context) {
        return BlocBuilder<ProductBloc, ProductState>(
          buildWhen: (previous, current) =>
              previous.productFilter != current.productFilter ||
              previous.selectedMinPrice != current.selectedMinPrice ||
              previous.selectedMaxPrice != current.selectedMaxPrice ||
              previous.filterProductsList != current.filterProductsList,
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    activeColor: Colors.green,
                    value: ProductFilter.sortByAToZ,
                    groupValue: state.productFilter,
                    onChanged: (value) {
                      context
                          .read<ProductBloc>()
                          .add(ChangeFilter(productFilter: value!));
                    },
                    title: Text(
                      'Sort by A to Z',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                  ),
                  RadioListTile(
                    activeColor: Colors.green,
                    value: ProductFilter.sortByZToA,
                    groupValue: state.productFilter,
                    onChanged: (value) {
                      context
                          .read<ProductBloc>()
                          .add(ChangeFilter(productFilter: value!));
                    },
                    title: Text(
                      'Sort by Z to A',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                  ),
                  RadioListTile(
                    activeColor: Colors.green,
                    value: ProductFilter.sortByPriceLowToHigh,
                    groupValue: state.productFilter,
                    onChanged: (value) {
                      context.read<ProductBloc>().add(
                            ChangeFilter(productFilter: value!),
                          );
                    },
                    title: Text(
                      'Sort by price Low to High',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                  ),
                  RadioListTile(
                    activeColor: Colors.green,
                    value: ProductFilter.sortByPriceHighToLow,
                    groupValue: state.productFilter,
                    onChanged: (value) {
                      context.read<ProductBloc>().add(
                            ChangeFilter(productFilter: value!),
                          );
                    },
                    title: Text(
                      'Sort by price High to Low',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                  ),
                  RadioListTile(
                    activeColor: Colors.green,
                    value: ProductFilter.sortByRating,
                    groupValue: state.productFilter,
                    onChanged: (value) {
                      context
                          .read<ProductBloc>()
                          .add(ChangeFilter(productFilter: value!));
                    },
                    title: Text(
                      'Sort by rating',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SfRangeSliderTheme(
                    data: SfRangeSliderThemeData(
                      tooltipBackgroundColor: Colors.green[300],
                    ),
                    child: SfRangeSlider(
                        values: SfRangeValues(
                          state.selectedMinPrice,
                          state.selectedMaxPrice,
                        ),
                        min: state.productMinPrice,
                        max: state.productMaxPrice,
                        activeColor: Colors.green,
                        tooltipShape: SfPaddleTooltipShape(),
                        inactiveColor: Color.fromARGB(255, 216, 186, 186),
                        showTicks: false,
                        showLabels: false,
                        enableTooltip: true,
                        minorTicksPerInterval: 1,
                        onChanged: (value) {
                          context.read<ProductBloc>().add(
                                SliderEvent(
                                  minPrice: value.start,
                                  maxPrice: value.end,
                                ),
                              );
                          // Update the text controllers
                          minPriceController.text =
                              value.start.toStringAsFixed(0);
                          maxPriceController.text =
                              value.end.toStringAsFixed(0);
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(children: [
                      Expanded(
                        child: TextFormField(
                          controller: minPriceController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              context.read<ProductBloc>().add(
                                    SliderEvent(
                                      minPrice: double.parse(
                                          value), // used to update min price
                                      maxPrice: state
                                          .productMaxPrice, // price coming from state
                                    ),
                                  );
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Min Price',
                            prefixText: 'Rs ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: maxPriceController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              context.read<ProductBloc>().add(
                                    SliderEvent(
                                      minPrice: state.productMinPrice,
                                      maxPrice: double.parse(value),
                                    ),
                                  );
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Max Price',
                            prefixText: 'Rs ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              context.read<ProductBloc>().add(
                                    ResetEvent(),
                                  );
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.inter().fontFamily,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              final currentFilter = state.productFilter;
                              context.read<ProductBloc>().add(
                                    ApplyFilter(productFilter: currentFilter),
                                  );
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.inter().fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      });
}
