import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/fade_in_widget.dart';

import '/config/constants.dart';
import '/logic/services/adaptive_font.dart';
import '/logic/services/url_launcher.dart';

class ContactView extends StatelessWidget {
  /// UI to display contact information
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        spacing: 32,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: mediaWidth - 48),
            child: FadeInWidget(
              widgetToFadeIn: Text(
                "Sam Harvey",
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
          ),
          // Email & social icons
          FadeInWidget(
            widgetToFadeIn: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Email
                IconButton(
                  tooltip: "Contact Sam",
                  icon: FaIcon(FontAwesomeIcons.envelope),
                  onPressed: () => Beamer.of(context).beamToNamed("/contact"),
                ),
                // Youtube
                IconButton(
                  tooltip: "Youtube",
                  icon: FaIcon(FontAwesomeIcons.youtube),
                  onPressed:
                      () => UrlLauncher.launch(
                        "https://www.youtube.com/channel/UCO6fpaaJYCkVSZQIhA4Gi8Q",
                      ),
                ),
                // Instagram
                IconButton(
                  tooltip: "Instagram",
                  icon: FaIcon(FontAwesomeIcons.instagram),
                  onPressed:
                      () => UrlLauncher.launch(
                        "https://www.instagram.com/o2tech2024?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==",
                      ),
                ),
                // Facebook
                IconButton(
                  tooltip: "Facebook",
                  icon: FaIcon(FontAwesomeIcons.facebook),
                  onPressed:
                      () => UrlLauncher.launch(
                        "https://www.facebook.com/profile.php?id=61557448528374",
                      ),
                ),
                IconButton(
                  tooltip: "Privacy & Terms",
                  icon: Icon(Icons.folder, size: 28),
                  // icon: FaIcon(FontAwesomeIcons.info),
                  onPressed: () {
                    Beamer.of(context).beamToNamed("/privacy");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
