import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../logic/services/adaptive_font.dart';
import '../widgets/fade_in_widget.dart';
import '../widgets/testimonial_widget.dart';

class TestimonialsView extends StatefulWidget {
  /// UI for displaying testimonials for O2Tech

  const TestimonialsView({super.key});

  @override
  State<TestimonialsView> createState() => _TestimonialsViewState();
}

class _TestimonialsViewState extends State<TestimonialsView> {
  final _controller = CarouselController();

  final testimonials = [
    TestimonialWidget(
      testimonial: joshTestimonial,
      name: "Joshua Morrow",
      business: "Brighter Tomorrow Exercise Physiology",
    ),
    TestimonialWidget(
      testimonial: jamesTestimonial,
      name: "James Cunning",
      business: "Building Approval Specialists",
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final mediaHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(24),
      child:
      // CarouselView(
      //   itemExtent: mediaWidth / 2,
      //   children: [
      //     Container(color: Colors.red),
      //     Container(color: Colors.blue),
      //     Container(color: Colors.green),
      //   ],
      // ),
      // Check if orientation is landscape factoring in foldables
      Column(
        children: [
          FadeInWidget(
            widgetToFadeIn: Text(
              "Testimonials",
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: AdaptiveFontSize.getFontSize(context, 24),
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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _controller.animateTo(
                      _controller.offset - mediaWidth,
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1050),
                  child: SizedBox(
                    width: mediaWidth - 140,
                    child: CarouselView(
                      itemSnapping: true,
                      shrinkExtent: mediaWidth < 1050 ? mediaWidth - 140 : 1050,
                      controller: _controller,
                      backgroundColor: Colors.transparent,
                      itemExtent: mediaWidth,
                      children: testimonials,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _controller.animateTo(
                      _controller.offset + mediaWidth - 140,
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
