import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_bloc.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_event.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_state.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Cart Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              return Expanded(
                flex: 5,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = state.cartItems[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.30,
                          height: size.height * 0.13,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                item.productModel.image.toString(),
                                width: size.width * 0.30,
                                height: size.height * 0.13,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productModel.title.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: size.width * 0.035,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Text(
                                "\$${item.productModel.price.toString()}",
                                style: GoogleFonts.poppins(
                                  color: Colors.black.withValues(alpha: 0.8),
                                  fontSize: size.width * 0.035,
                                ),
                              ),
                              SizedBox(
                                height: size.width * 0.030,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<CartBloc>().add(IncrementQuantityEvent(productId: item.productModel.id!));
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  Text(
                                    item.quantity.toString(),
                                    style: GoogleFonts.poppins(),
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<CartBloc>().add(DecrementQuantityEvent(productId: item.productModel.id!));
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                        size: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<CartBloc>().add(RemoveFromCartEvent(productId: item.productModel.id!));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color.fromARGB(255, 247, 247, 247),
                                content: Text(
                                  "Item removed!",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.redAccent.withValues(alpha: .07),
                            radius: 18,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 14,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('sub total'),
                        Text('\$${100}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Shipping'),
                        Text('\$${20}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total'),
                        Text('\$${200}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
