import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/fade_in_widget.dart';

import '/config/constants.dart';
import '/logic/services/adaptive_font.dart';
import '../widgets/text_heading_widget.dart';

class HomeView extends StatefulWidget {
  /// UI to display home page

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double get mediaWidth => MediaQuery.sizeOf(context).width;
  double get mediaHeight => MediaQuery.sizeOf(context).height;

  bool isPressed = false;
  bool isHovered = false;

  // Adaptive width for image of Sam
  double adaptiveImageWidth(double width) {
    if (mediaWidth / mediaHeight > 0.9) {
      return width * 0.4;
    } else if (mediaWidth > 500) {
      return width * 0.8;
    } else {
      return width;
    }
  }

  // Adaptive width for text
  double adaptiveTextWidth(double width) {
    if (mediaWidth / mediaHeight > 0.9) {
      return width * 0.5;
    } else {
      return width;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // If landscape orientation (factoring in foldables)
        if (mediaWidth / mediaHeight > 0.9)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Heading to break over 2 lines if needed
                  Padding(
                    padding:
                        mediaWidth > 1250
                            ? const EdgeInsets.fromLTRB(200, 24, 24, 24)
                            : const EdgeInsets.fromLTRB(96, 24, 24, 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: mediaWidth * 0.5 - 48,
                      ),
                      child: FadeInWidget(
                        widgetToFadeIn: TextHeadingWidget(text: "O2 Tech"),
                      ),
                    ),
                  ),
                  // Subheading
                  Padding(
                    padding:
                        mediaWidth > 1250
                            ? const EdgeInsets.fromLTRB(200, 24, 24, 24)
                            : const EdgeInsets.fromLTRB(96, 24, 24, 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: mediaWidth * 0.5 - 48,
                      ),
                      child: FadeInWidget(
                        widgetToFadeIn: Text(
                          "I build apps & websites.\n"
                          "Scroll down to see more.",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: AdaptiveFontSize.getFontSize(
                                context,
                                18,
                              ),
                              fontWeight: FontWeight.bold,
                              fontFamily: "Open Sans",
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Contact button
                  Padding(
                    padding:
                        mediaWidth > 1250
                            ? const EdgeInsets.fromLTRB(200, 24, 24, 24)
                            : const EdgeInsets.fromLTRB(96, 24, 24, 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: mediaWidth * 0.5 - 48,
                      ),
                      child: FadeInWidget(
                        widgetToFadeIn: Tooltip(
                          message: "Navigate to Contact Form",
                          child: InkWell(
                            onHover:
                                (value) => setState(() {
                                  isHovered = value;
                                }),
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            onTap: () {
                              setState(() {
                                isPressed = true;
                              });
                              Future.delayed(
                                const Duration(milliseconds: 150),
                              ).then((value) {
                                setState(() {
                                  isPressed = false;
                                });
                                // Navigate to contact page here
                                // ignore: use_build_context_synchronously
                                Beamer.of(context).beamToNamed("/contact");
                              });
                            },
                            child: Container(
                              width: mediaWidth > 1000 ? 400 : 300,
                              decoration: BoxDecoration(
                                color:
                                    isHovered ? Colors.black87 : Colors.black,
                                border:
                                    isPressed
                                        ? BoxBorder.all(color: blue, width: 1)
                                        : BoxBorder.all(color: blue, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32),
                                ),
                                boxShadow:
                                    isPressed
                                        ? []
                                        : [
                                          BoxShadow(color: blue, blurRadius: 3),
                                          BoxShadow(color: blue, blurRadius: 6),
                                          BoxShadow(color: blue, blurRadius: 9),
                                          BoxShadow(
                                            color: blue,
                                            blurRadius: 12,
                                          ),
                                        ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Text(
                                    "Contact",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontSize: AdaptiveFontSize.getFontSize(
                                          context,
                                          18,
                                        ),
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
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Image of Sam
              FadeInWidget(
                widgetToFadeIn: Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: [
                      const CircularProgressIndicator(),
                      Container(
                        decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            bottomLeft: Radius.circular(32),
                          ),
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: mediaWidth * 0.5 - 56,
                          ),
                          child: SizedBox(
                            child: Image.asset(
                              "images/sam_office.png",
                              width: adaptiveImageWidth(mediaWidth),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        else
          // Portrait orientation
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading to break over 2 lines if needed
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: adaptiveTextWidth(mediaWidth) - 48,
                          ),
                          child: FadeInWidget(
                            widgetToFadeIn: TextHeadingWidget(text: "O2 Tech"),
                          ),
                        ),
                      ),
                      // Subheading
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: adaptiveTextWidth(mediaWidth) - 48,
                          ),
                          child: FadeInWidget(
                            widgetToFadeIn: Text(
                              "I build apps & websites.",
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: AdaptiveFontSize.getFontSize(
                                    context,
                                    18,
                                  ),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Open Sans",
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Contact button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: adaptiveTextWidth(mediaWidth) - 48,
                          ),
                          child: FadeInWidget(
                            widgetToFadeIn: Tooltip(
                              message: "Navigate to Contact Form",
                              child: InkWell(
                                onHover:
                                    (value) => setState(() {
                                      isHovered = value;
                                    }),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32),
                                ),
                                onTap: () {
                                  setState(() {
                                    isPressed = true;
                                  });
                                  Future.delayed(
                                    const Duration(milliseconds: 150),
                                  ).then((value) {
                                    setState(() {
                                      isPressed = false;
                                    });
                                    // Navigate to contact page here
                                    // ignore: use_build_context_synchronously
                                    Beamer.of(context).beamToNamed("/contact");
                                  });
                                },
                                child: Container(
                                  width: mediaWidth > 1000 ? 400 : 300,
                                  decoration: BoxDecoration(
                                    color:
                                        isHovered
                                            ? Colors.black87
                                            : Colors.black,
                                    border:
                                        isPressed
                                            ? BoxBorder.all(
                                              color: blue,
                                              width: 1,
                                            )
                                            : BoxBorder.all(
                                              color: blue,
                                              width: 2,
                                            ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(32),
                                    ),
                                    boxShadow:
                                        isPressed
                                            ? []
                                            : [
                                              BoxShadow(
                                                color: blue,
                                                blurRadius: 3,
                                              ),
                                              BoxShadow(
                                                color: blue,
                                                blurRadius: 6,
                                              ),
                                              BoxShadow(
                                                color: blue,
                                                blurRadius: 9,
                                              ),
                                              BoxShadow(
                                                color: blue,
                                                blurRadius: 12,
                                              ),
                                            ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                      child: Text(
                                        "Contact",
                                        style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                            fontSize:
                                                AdaptiveFontSize.getFontSize(
                                                  context,
                                                  18,
                                                ),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Open Sans",
                                            color: white,
                                            shadows: [
                                              Shadow(
                                                color: blue,
                                                blurRadius: 3,
                                              ),
                                              Shadow(
                                                color: blue,
                                                blurRadius: 6,
                                              ),
                                              Shadow(
                                                color: blue,
                                                blurRadius: 9,
                                              ),
                                              Shadow(
                                                color: blue,
                                                blurRadius: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Image of Sam
              FadeInWidget(
                widgetToFadeIn: Padding(
                  padding: const EdgeInsets.only(left: 24, top: 24),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          bottomLeft: Radius.circular(32),
                        ),
                      ),
                      child: Image.asset(
                        "images/sam_office.png",
                        width: adaptiveImageWidth(mediaWidth),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        // Animation to prompt scrolling
        Align(
          alignment: Alignment(0, 1),
          child: FadeInWidget(
            widgetToFadeIn: Image.asset("images/scroll.gif", width: 40),
          ),
        ),
      ],
    );
  }
}
