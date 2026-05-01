import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/config/constants.dart';
import '/logic/services/adaptive_font.dart';
import '../widgets/fade_in_widget.dart';
import '../widgets/text_heading_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _btnHovered = false;
  bool _btnPressed = false;
  bool _badgeVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _badgeVisible = true);
    });
  }

  // ── Eyebrow badge ─────────────────────────────────────────────────────────

  Widget _badge(BuildContext context) {
    return AnimatedSlide(
      offset: _badgeVisible ? Offset.zero : const Offset(0, 0.5),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _badgeVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: blue.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(24),
            color: blue.withValues(alpha: 0.08),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: blue,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: blue, blurRadius: 6)],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Flutter Mobile & Web Developer",
                style: GoogleFonts.openSans(
                  fontSize: AdaptiveFontSize.getFontSize(context, 12),
                  color: blue,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── CTA button ────────────────────────────────────────────────────────────

  Widget _contactButton(BuildContext context) {
    final beamer = Beamer.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _btnHovered = true),
      onExit: (_) => setState(() => _btnHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _btnPressed = true),
        onTapUp: (_) {
          setState(() => _btnPressed = false);
          beamer.beamToNamed("/contact");
        },
        onTapCancel: () => setState(() => _btnPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          decoration: BoxDecoration(
            color:
                _btnHovered ? blue.withValues(alpha: 0.12) : Colors.transparent,
            border: Border.all(color: blue, width: 1.5),
            borderRadius: BorderRadius.circular(8),
            boxShadow:
                _btnPressed
                    ? []
                    : [
                      BoxShadow(
                        color: blue.withValues(alpha: 0.3),
                        blurRadius: 18,
                      ),
                    ],
          ),
          child: Text(
            "Get In Touch",
            style: GoogleFonts.openSans(
              fontSize: AdaptiveFontSize.getFontSize(context, 14),
              fontWeight: FontWeight.w600,
              color: white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _scrollCue() =>
      FadeInWidget(widgetToFadeIn: Image.asset("images/scroll.gif", width: 28));

  // ── Photo card — rounded, blue-bordered, glow ─────────────────────────────

  Widget _photoCard(double height) {
    return SizedBox(
      height: height,
      child: AspectRatio(
        aspectRatio: 0.75,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: blue.withValues(alpha: 0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: blue.withValues(alpha: 0.18),
                blurRadius: 48,
                spreadRadius: -4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: Image.asset(
              "images/sam_office.png",
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }

  // ── Layout selection ──────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;
    return w / h > 0.9
        ? _buildLandscape(context, h)
        : _buildPortrait(context);
  }

  // ── Landscape ─────────────────────────────────────────────────────────────
  // Two columns: text (flex 6) left, photo card (flex 4) right.
  // Row stretches to full height; text content is centered in its column
  // via an inner Expanded + mainAxisAlignment.center. Scroll cue pins to
  // the bottom of the left column, never behind the photo.

  Widget _buildLandscape(BuildContext context, double h) {
    final photoH = ((h - 64) * 0.72).clamp(280.0, 500.0);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left — text content
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _badge(context),
                          const SizedBox(height: 24),
                          FadeInWidget(
                            widgetToFadeIn: TextHeadingWidget(text: "O2 Tech"),
                          ),
                          const SizedBox(height: 16),
                          FadeInWidget(
                            widgetToFadeIn: Text(
                              "I build apps & websites\nfor small businesses.",
                              style: GoogleFonts.openSans(
                                fontSize: AdaptiveFontSize.getFontSize(
                                    context, 16),
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.55),
                                height: 1.65,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          FadeInWidget(
                              widgetToFadeIn: _contactButton(context)),
                        ],
                      ),
                    ),
                    // Scroll cue anchored at the bottom of the text column
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _scrollCue(),
                    ),
                  ],
                ),
              ),
              // Gap between columns
              const SizedBox(width: 48),
              // Right — photo card, vertically centred
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.center,
                  child: FadeInWidget(widgetToFadeIn: _photoCard(photoH)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Portrait ──────────────────────────────────────────────────────────────
  // Text block at the top; photo card fills all remaining space as a rounded
  // bordered card (no edge-to-edge bleed). Scroll cue is Positioned so it
  // always clears the photo.

  Widget _buildPortrait(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text section — natural height
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _badge(context),
              const SizedBox(height: 20),
              FadeInWidget(
                widgetToFadeIn: TextHeadingWidget(text: "O2 Tech"),
              ),
              const SizedBox(height: 12),
              FadeInWidget(
                widgetToFadeIn: Text(
                  "Apps & websites for small businesses.",
                  style: GoogleFonts.openSans(
                    fontSize: AdaptiveFontSize.getFontSize(context, 14),
                    color: Colors.white.withValues(alpha: 0.55),
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FadeInWidget(widgetToFadeIn: _contactButton(context)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Photo card — expands to fill all remaining viewport space
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: FadeInWidget(
              widgetToFadeIn: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: blue.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: blue.withValues(alpha: 0.12),
                      blurRadius: 32,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(19),
                  child: Image.asset(
                    "images/sam_office.png",
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Scroll cue — centred below the photo, clearly visible
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(child: _scrollCue()),
        ),
      ],
    );
  }
}
