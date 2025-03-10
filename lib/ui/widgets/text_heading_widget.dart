import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/config/constants.dart';
import '/logic/services/adaptive_font.dart';

class TextHeadingWidget extends StatelessWidget {
  final String text;
  const TextHeadingWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.clip,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: AdaptiveFontSize.getFontSize(context, 60),
          fontWeight: FontWeight.bold,
          fontFamily: "Open Sans",
          color: white,
          shadows: [
            Shadow(color: blue, blurRadius: 3),
            Shadow(color: blue, blurRadius: 6),
            Shadow(color: blue, blurRadius: 9),
            Shadow(color: blue, blurRadius: 12),
          ],
        ),
      ),
    );
  }
}
