import 'package:flutter/material.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  const DetailsScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          'Detail Screen',
          style: TextStyle(
            color: const Color(0xff000000),
            fontSize: 18,
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: productModel.id!,
              child: Image.network(
                height: size.height * 0.45,
                width: size.width,
                productModel.image!,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        productModel.rating!.rate.toString(),
                        style: TextStyle(
                          color: const Color(0xff000000),
                          fontSize: 18,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('(${productModel.rating!.count})',
                          style: TextStyle(
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: const Color.fromARGB(255, 142, 140, 140),
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text('Review'),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    productModel.title.toString(),
                    style: TextStyle(
                      color: const Color(0xff000000),
                      fontSize: 16,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '\$${productModel.price.toString()}',
                    style: TextStyle(
                      color: const Color(0xff000000),
                      fontSize: 18,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Description',
                    style: TextStyle(
                      color: const Color(0xff000000),
                      fontSize: 18,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    productModel.description.toString(),
                    style: TextStyle(
                      color: const Color(0xff000000),
                      fontSize: 16,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 45,
                        width: 122,
                        decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: Color(0xff000000),
                              ),
                            ),
                            const Text(
                              '2',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),
                              ),
                            ),
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.50,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: const Color(0xff0DA54B),
                              foregroundColor: const Color(0xffffffff)),
                          onPressed: () {},
                          child: Text(
                            'Add to cart',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.inter().fontFamily),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
