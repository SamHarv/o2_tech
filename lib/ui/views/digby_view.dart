import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../logic/services/adaptive_font.dart';
import '../../logic/services/url_launcher.dart';

class DigbyView extends StatefulWidget {
  const DigbyView({super.key});

  @override
  State<DigbyView> createState() => _DigbyViewState();
}

class _DigbyViewState extends State<DigbyView> {
  bool _hovered = false;

  static const _appStoreUrl =
      "https://apps.apple.com/us/app/digby/id6480343595";
  static const _playStoreUrl =
      "https://play.google.com/store/apps/details?id=com.samharvey.digby&pcampaignid=web_share";
  static const _webUrl = "https://digby-9696d.web.app/";

  void _handleTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset("images/digby.png",
                      width: 40, height: 40, fit: BoxFit.contain),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Digby",
                          style: GoogleFonts.openSans(
                            fontSize:
                                AdaptiveFontSize.getFontSize(context, 16),
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                        ),
                        Text(
                          "Choose where to open",
                          style: TextStyle(
                            fontSize:
                                AdaptiveFontSize.getFontSize(context, 12),
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.08)),
              _dialogTile(
                ctx,
                icon: FontAwesomeIcons.appStore,
                label: "App Store",
                subtitle: "iOS",
                url: _appStoreUrl,
                isFa: true,
              ),
              _dialogTile(
                ctx,
                icon: FontAwesomeIcons.googlePlay,
                label: "Play Store",
                subtitle: "Android",
                url: _playStoreUrl,
                isFa: true,
              ),
              _dialogTile(
                ctx,
                icon: Icons.language,
                label: "Website",
                subtitle: "Browser",
                url: _webUrl,
                isFa: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dialogTile(
    BuildContext ctx, {
    required dynamic icon,
    required String label,
    required String subtitle,
    required String url,
    required bool isFa,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.pop(ctx);
        UrlLauncher.launch(url);
      },
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          children: [
            isFa
                ? FaIcon(icon as IconData, color: white, size: 20)
                : Icon(icon as IconData, color: white, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.openSans(
                      fontSize:
                          AdaptiveFontSize.getFontSize(ctx, 14),
                      fontWeight: FontWeight.w500,
                      color: white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize:
                          AdaptiveFontSize.getFontSize(ctx, 11),
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 13,
              color: Colors.white.withValues(alpha: 0.25),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onHover: (v) => setState(() => _hovered = v),
      onTap: () => _handleTap(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _hovered
              ? blue.withValues(alpha: 0.05)
              : Colors.white.withValues(alpha: 0.02),
          border: Border.all(
            color: _hovered
                ? blue.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.08),
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: blue.withValues(alpha: 0.12),
                    blurRadius: 24,
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo animates on hover: static ↔ active
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Image.asset(
                    _hovered ? "images/move.png" : "images/digby.png",
                    key: ValueKey(_hovered),
                    width: 44,
                    height: 44,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Digby",
                  style: GoogleFonts.openSans(
                    fontSize: AdaptiveFontSize.getFontSize(context, 15),
                    fontWeight: FontWeight.w600,
                    color: white,
                    shadows: _hovered
                        ? const [Shadow(color: blue, blurRadius: 6)]
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "An addictive cross-platform game — available on iOS, Android, and web.",
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AdaptiveFontSize.getFontSize(context, 13),
                color: Colors.white60,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _iconLink(FontAwesomeIcons.appStore, "App Store",
                    _appStoreUrl, true),
                _iconLink(FontAwesomeIcons.googlePlay, "Play Store",
                    _playStoreUrl, true),
                _iconLink(Icons.language, "Website", _webUrl, false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconLink(
      dynamic icon, String tooltip, String url, bool isFa) {
    return _CardIcon(
        icon: icon, tooltip: tooltip, url: url, isFa: isFa);
  }
}

class _CardIcon extends StatefulWidget {
  final dynamic icon;
  final String tooltip;
  final String url;
  final bool isFa;

  const _CardIcon({
    required this.icon,
    required this.tooltip,
    required this.url,
    required this.isFa,
  });

  @override
  State<_CardIcon> createState() => _CardIconState();
}

class _CardIconState extends State<_CardIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onHover: (v) => setState(() => _hovered = v),
        onTap: () => UrlLauncher.launch(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.all(7),
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: _hovered
                ? blue.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.isFa
              ? FaIcon(widget.icon as IconData,
                  color: _hovered ? blue : Colors.white54, size: 16)
              : Icon(widget.icon as IconData,
                  color: _hovered ? blue : Colors.white54, size: 18),
        ),
      ),
    );
  }
}
