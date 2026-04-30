import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../logic/services/adaptive_font.dart';
import 'fade_in_widget.dart';

class TestimonialWidget extends StatelessWidget {
  final String name;
  final String business;
  final String testimonial;
  const TestimonialWidget({
    super.key,
    required this.name,
    required this.business,
    required this.testimonial,
  });

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 24,
      children: [
        // 5 stars
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => Icon(Icons.star, color: Colors.yellow),
          ),
        ),
        // Testimonial content
        FadeInWidget(
          widgetToFadeIn: Text(
            testimonial,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AdaptiveFontSize.getFontSize(context, 14),
            ),
          ),
        ),
        // Author
        FadeInWidget(
          widgetToFadeIn: Text(
            name,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: AdaptiveFontSize.getFontSize(context, 16),
                fontWeight: FontWeight.bold,
                fontFamily: "Open Sans",
                color: white,
                shadows: [
                  Shadow(color: blue, blurRadius: 3),
                  Shadow(color: blue, blurRadius: 6),
                  Shadow(color: blue, blurRadius: 9),
                ],
              ),
            ),
          ),
        ),
        // Author's company
        FadeInWidget(
          widgetToFadeIn: Text(
            business,
            style: TextStyle(
              fontSize: AdaptiveFontSize.getFontSize(context, 12),
            ),
          ),
        ),
      ],
    );
  }
}
