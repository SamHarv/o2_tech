import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/fade_in_widget.dart';

import '../../config/constants.dart';
import '../../logic/services/adaptive_font.dart';
import '../../logic/services/url_launcher.dart';

class DigbyView extends StatefulWidget {
  /// UI to display the Digby project

  const DigbyView({super.key});

  @override
  State<DigbyView> createState() => _DigbyViewState();
}

class _DigbyViewState extends State<DigbyView> {
  bool hovering = false; // for animating logo
  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final mediaHeight = MediaQuery.sizeOf(context).height;
    return Center(
      child: Column(
        spacing: 48,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
                  (mediaWidth / mediaHeight > 0.9)
                      ? mediaHeight / 3
                      : mediaWidth * 0.5,
            ),
            child: Row(
              children: [
                FadeInWidget(
                  widgetToFadeIn: Text(
                    "Digby",
                    textAlign: TextAlign.left,
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
              ],
            ),
          ),
          // Digby logo which animates on hover
          FadeInWidget(
            widgetToFadeIn: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: InkWell(
                borderRadius: BorderRadius.circular(32),
                onTap: () => UrlLauncher.launch("https://digby-9696d.web.app/"),
                onHover: (hover) {
                  // animate to increase size
                  setState(() => hovering = hover);
                },
                child: Image.asset(
                  hovering ? "images/move.png" : "images/digby.png",
                  width:
                      (mediaWidth / mediaHeight > 0.9)
                          ? mediaHeight / 3
                          : mediaWidth * 0.5,
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
                  (mediaWidth / mediaHeight > 0.9)
                      ? mediaHeight / 3
                      : mediaWidth * 0.5,
            ),
            child: FadeInWidget(
              widgetToFadeIn: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // App Store
                  IconButton(
                    tooltip: "Apple App Store",
                    hoverColor: blue,
                    splashColor: white,
                    icon: const FaIcon(
                      FontAwesomeIcons.appStore,
                      color: white,
                      size: 40,
                    ),
                    onPressed:
                        () => UrlLauncher.launch(
                          "https://apps.apple.com/us/app/digby/id6480343595",
                        ),
                  ),
                  // Google Play Store
                  IconButton(
                    tooltip: "Google Play Store",
                    hoverColor: blue,
                    splashColor: white,
                    icon: const FaIcon(
                      FontAwesomeIcons.googlePlay,
                      color: white,
                      size: 40,
                    ),
                    onPressed:
                        () => UrlLauncher.launch(
                          "https://play.google.com/store/apps/details?id=com.samharvey.digby&pcampaignid=web_share",
                        ),
                  ),
                  // Web Version
                  IconButton(
                    tooltip: "Web Version",
                    hoverColor: blue,
                    splashColor: white,
                    icon: const Icon(Icons.language, color: white, size: 40),
                    onPressed:
                        () =>
                            UrlLauncher.launch("https://digby-9696d.web.app/"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
