import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../logic/services/adaptive_font.dart';
import '../widgets/fade_in_widget.dart';
import '../widgets/testimonial_widget.dart';

class TestimonialsView extends StatelessWidget {
  const TestimonialsView({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final isWide = w > 700;

    return Container(
      width: double.infinity,
      color: Colors.white.withValues(alpha: 0.02),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: w > 600 ? 80 : 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInWidget(
                  widgetToFadeIn: _sectionHeading(context),
                ),
                const SizedBox(height: 48),
                FadeInWidget(
                  widgetToFadeIn: isWide
                      ? IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Expanded(
                                child: TestimonialWidget(
                                  testimonial: joshTestimonial,
                                  name: "Joshua Morrow",
                                  business:
                                      "Brighter Tomorrow Exercise Physiology",
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: TestimonialWidget(
                                  testimonial: jamesTestimonial,
                                  name: "James Cunning",
                                  business: "Building Approval Specialists",
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Column(
                          children: [
                            TestimonialWidget(
                              testimonial: joshTestimonial,
                              name: "Joshua Morrow",
                              business:
                                  "Brighter Tomorrow Exercise Physiology",
                            ),
                            SizedBox(height: 20),
                            TestimonialWidget(
                              testimonial: jamesTestimonial,
                              name: "James Cunning",
                              business: "Building Approval Specialists",
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Testimonials",
          style: GoogleFonts.openSans(
            fontSize: AdaptiveFontSize.getFontSize(context, 28),
            fontWeight: FontWeight.bold,
            color: white,
            shadows: const [
              Shadow(color: blue, blurRadius: 4),
              Shadow(color: blue, blurRadius: 10),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(width: 40, height: 2, color: blue),
      ],
    );
  }
}
