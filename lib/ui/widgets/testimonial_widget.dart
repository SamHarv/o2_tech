import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../logic/services/adaptive_font.dart';

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
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (_) => const Padding(
                padding: EdgeInsets.only(right: 3),
                child: Icon(Icons.star_rounded, color: Colors.amber, size: 18),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            testimonial,
            style: TextStyle(
              fontSize: AdaptiveFontSize.getFontSize(context, 13),
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.65,
            ),
          ),
          const SizedBox(height: 20),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.07)),
          const SizedBox(height: 16),
          Text(
            name,
            style: GoogleFonts.openSans(
              fontSize: AdaptiveFontSize.getFontSize(context, 14),
              fontWeight: FontWeight.w600,
              color: white,
              shadows: const [
                Shadow(color: blue, blurRadius: 4),
                Shadow(color: blue, blurRadius: 8),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            business,
            style: TextStyle(
              fontSize: AdaptiveFontSize.getFontSize(context, 12),
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
