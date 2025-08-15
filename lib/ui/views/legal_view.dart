import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../logic/services/adaptive_font.dart';
import '../widgets/fade_in_widget.dart';

enum LegalType { privacyPolicy, termsOfService }

class LegalView extends StatefulWidget {
  /// UI for displaying the privacy policy and terms of service

  const LegalView({super.key});

  @override
  State<LegalView> createState() => _LegalViewState();
}

class _LegalViewState extends State<LegalView> {
  LegalType selected = LegalType.privacyPolicy;
  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Beamer.of(context).beamToNamed("/");
          },
          icon: Icon(Icons.navigate_before),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            spacing: 24,
            children: [
              SizedBox(
                width: mediaWidth - 48,
                child: SegmentedButton(
                  segments: [
                    ButtonSegment(
                      value: LegalType.privacyPolicy,
                      label: Text("Privacy Policy"),
                    ),
                    ButtonSegment(
                      value: LegalType.termsOfService,
                      label: Text("Terms of Service"),
                    ),
                  ],
                  selected: {selected},
                  onSelectionChanged: (Set<LegalType> newSelection) {
                    setState(() {
                      selected = newSelection.first;
                    });
                  },
                ),
              ),
              selected == LegalType.privacyPolicy
                  ? Column(
                    spacing: 24,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // App Title
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: mediaWidth - 48,
                            ),
                            child: FadeInWidget(
                              widgetToFadeIn: Text(
                                "Privacy Policy",
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
                      Row(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: mediaWidth - 48,
                            ),
                            child: FadeInWidget(
                              widgetToFadeIn: Text(
                                privacyPolicy,
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
                  )
                  : Column(
                    spacing: 24,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // App Title
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: mediaWidth - 48,
                            ),
                            child: FadeInWidget(
                              widgetToFadeIn: Text(
                                "Terms of Service",
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
                      Row(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: mediaWidth - 48,
                            ),
                            child: FadeInWidget(
                              widgetToFadeIn: Text(
                                terms,
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
              FadeInWidget(
                widgetToFadeIn: Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 40, child: Image.asset("images/pride.png")),
                    SizedBox(width: 40, child: Image.asset("images/first.png")),
                    SizedBox(
                      width: 40,
                      child: Image.asset("images/torres.png"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
