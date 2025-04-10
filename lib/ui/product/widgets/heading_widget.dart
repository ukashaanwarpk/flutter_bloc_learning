import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingWidget extends StatelessWidget {
  final String title;
  final String traling;
  const HeadingWidget({
    required this.title,
    required this.traling,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: const Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.inter().fontFamily),
        ),
        Text(
          traling,
          style: TextStyle(
              color: const Color(0xff0DA54B),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.inter().fontFamily),
        ),
      ],
    );
  }
}
