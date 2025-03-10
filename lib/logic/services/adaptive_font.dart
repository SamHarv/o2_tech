import 'package:flutter/material.dart';

class AdaptiveFontSize {
  /// Returns a font size that is scaled based on the screen width
  static double getFontSize(BuildContext context, double baseFontSize) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    const double baseScreenWidth = 405.0; // Standard screen width
    double scaleFactor = 1;
    if (screenWidth > 1000) {
      scaleFactor = 1.6;
    } else if (screenWidth > 500) {
      scaleFactor = 1.25;
    } else {
      scaleFactor = screenWidth / baseScreenWidth;
    }
    return baseFontSize * scaleFactor;
  }
}
