import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart Screen'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.30,
                    height: size.height * 0.13,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1743883325575-783014a39a8b?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mango Juice',
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Text(
                          "\$${40}",
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
                              onTap: () {},
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
                              '2',
                              style: GoogleFonts.poppins(),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            GestureDetector(
                              onTap: () {},
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
              ),
            ),

            const Row(
              children: [
                Text('sub total'),
                Text('\$${100}'),
                
              ],
            ),
             
             const Row(
              children: [
                Text('Shipping'),
                Text('\$${20}'),
                
              ],
            ),
            const Row(
              children: [
                Text('Total'),
                Text('\$${200}'),
                
              ],
            ),
          ],
        ));
  }
}
