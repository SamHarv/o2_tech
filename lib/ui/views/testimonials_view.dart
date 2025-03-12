import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../logic/services/adaptive_font.dart';
import '../widgets/fade_in_widget.dart';

class TestimonialsView extends StatelessWidget {
  /// UI for displaying testimonials for O2Tech

  const TestimonialsView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final mediaHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(24),
      child:
          // Check if orientation is landscape factoring in foldables
          (mediaWidth / mediaHeight > 0.9)
              ? Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 80, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // App information
                    SizedBox(
                      width: mediaWidth / 2 - 48,
                      child: Column(
                        spacing: 32,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: mediaWidth / 2 - 80,
                                ),
                                child: FadeInWidget(
                                  widgetToFadeIn: Text(
                                    "Testimonial",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontSize: AdaptiveFontSize.getFontSize(
                                          context,
                                          24,
                                        ),
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
                              ),
                            ],
                          ),
                          // Testimonial content
                          Row(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: mediaWidth / 2 - 48,
                                ),
                                child: FadeInWidget(
                                  widgetToFadeIn: Text(
                                    joshTestimonial,
                                    style: TextStyle(
                                      fontSize: AdaptiveFontSize.getFontSize(
                                        context,
                                        16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Author
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: mediaWidth / 2 - 80,
                                ),
                                child: FadeInWidget(
                                  widgetToFadeIn: Text(
                                    "Joshua Morrow",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontSize: AdaptiveFontSize.getFontSize(
                                          context,
                                          24,
                                        ),
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
                              ),
                            ],
                          ),
                          // Author's company
                          Row(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: mediaWidth / 2 - 48,
                                ),
                                child: FadeInWidget(
                                  widgetToFadeIn: Text(
                                    "Brighter Tomorrow Exercise Physiology",
                                    style: TextStyle(
                                      fontSize: AdaptiveFontSize.getFontSize(
                                        context,
                                        16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Image of Josh
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: mediaWidth / 2 - 160,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: FadeInWidget(
                            widgetToFadeIn: Image.asset("images/josh.jpeg"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              // Portrait orientation
              : Column(
                spacing: 24,
                children: [
                  Row(
                    children: [
                      // Title
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: mediaWidth - 48),
                        child: FadeInWidget(
                          widgetToFadeIn: Text(
                            "Testimonial",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: AdaptiveFontSize.getFontSize(
                                  context,
                                  24,
                                ),
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
                      ),
                    ],
                  ),
                  // Image of Josh
                  Expanded(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: FadeInWidget(
                            widgetToFadeIn: Image.asset("images/josh.jpeg"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Testimonial content
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: mediaWidth - 48),
                        child: FadeInWidget(
                          widgetToFadeIn: Text(
                            joshTestimonial,
                            style: TextStyle(
                              fontSize: AdaptiveFontSize.getFontSize(
                                context,
                                16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Author
                  Row(
                    children: [
                      // Title
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: mediaWidth - 48),
                        child: FadeInWidget(
                          widgetToFadeIn: Text(
                            "Joshua Morrow",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: AdaptiveFontSize.getFontSize(
                                  context,
                                  24,
                                ),
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
                      ),
                    ],
                  ),
                  // Author's company
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: mediaWidth - 48),
                        child: FadeInWidget(
                          widgetToFadeIn: Text(
                            "Brighter Tomorrow Exercise Physiology",
                            style: TextStyle(
                              fontSize: AdaptiveFontSize.getFontSize(
                                context,
                                16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
    );
  }
}
