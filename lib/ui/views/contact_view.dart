import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '/config/constants.dart';
import '/logic/services/adaptive_font.dart';
import '/logic/services/url_launcher.dart';
import '../widgets/fade_in_widget.dart';
import '../widgets/text_heading_widget.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: double.infinity,
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
                  widgetToFadeIn: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Get In Touch",
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
                  ),
                ),
                const SizedBox(height: 40),
                FadeInWidget(
                  widgetToFadeIn: TextHeadingWidget(text: "Sam Harvey"),
                ),
                const SizedBox(height: 32),
                FadeInWidget(
                  widgetToFadeIn: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _ContactChip(
                        icon: FontAwesomeIcons.envelope,
                        label: "Message",
                        onTap: () => Beamer.of(context).beamToNamed("/contact"),
                      ),
                      _ContactChip(
                        icon: FontAwesomeIcons.youtube,
                        label: "YouTube",
                        onTap: () => UrlLauncher.launch(
                          "https://www.youtube.com/channel/UCO6fpaaJYCkVSZQIhA4Gi8Q",
                        ),
                      ),
                      _ContactChip(
                        icon: FontAwesomeIcons.instagram,
                        label: "Instagram",
                        onTap: () => UrlLauncher.launch(
                          "https://www.instagram.com/o2tech2024?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==",
                        ),
                      ),
                      _ContactChip(
                        icon: FontAwesomeIcons.facebook,
                        label: "Facebook",
                        onTap: () => UrlLauncher.launch(
                          "https://www.facebook.com/profile.php?id=61557448528374",
                        ),
                      ),
                      _ContactChip(
                        icon: FontAwesomeIcons.solidFolder,
                        label: "Legal",
                        onTap: () => Beamer.of(context).beamToNamed("/privacy"),
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
}

class _ContactChip extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_ContactChip> createState() => _ContactChipState();
}

class _ContactChipState extends State<_ContactChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: _hovered
                  ? blue.withValues(alpha: 0.12)
                  : Colors.white.withValues(alpha: 0.04),
              border: Border.all(
                color: _hovered
                    ? blue.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.1),
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: blue.withValues(alpha: 0.15),
                        blurRadius: 16,
                      )
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  widget.icon,
                  color: _hovered ? blue : Colors.white.withValues(alpha: 0.7),
                  size: 16,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.label,
                  style: GoogleFonts.openSans(
                    fontSize: AdaptiveFontSize.getFontSize(context, 13),
                    fontWeight: FontWeight.w500,
                    color: _hovered ? blue : Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
