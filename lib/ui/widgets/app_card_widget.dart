import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../data/models/app_model.dart';
import '../../logic/services/adaptive_font.dart';
import '../../logic/services/url_launcher.dart';

class AppCardWidget extends StatefulWidget {
  final AppModel app;
  const AppCardWidget({super.key, required this.app});

  @override
  State<AppCardWidget> createState() => _AppCardWidgetState();
}

class _AppCardWidgetState extends State<AppCardWidget> {
  bool _hovered = false;

  Widget _icon({double size = 44}) {
    const radius = BorderRadius.all(Radius.circular(10));
    final img = Image.asset(
      widget.app.logo,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
    if (widget.app.title == "Thoughts") {
      return Container(
        width: size,
        height: size,
        decoration:
            const BoxDecoration(color: white, borderRadius: radius),
        child: ClipRRect(borderRadius: radius, child: img),
      );
    }
    return ClipRRect(borderRadius: radius, child: img);
  }

  void _handleTap(BuildContext context) {
    final urls = <_PlatformEntry>[];
    if (widget.app.appStoreUrl != null) {
      urls.add(_PlatformEntry(
        label: "App Store",
        subtitle: "iOS",
        icon: FontAwesomeIcons.appStore,
        isFa: true,
        url: widget.app.appStoreUrl!,
      ));
    }
    if (widget.app.playStoreUrl != null) {
      urls.add(_PlatformEntry(
        label: "Play Store",
        subtitle: "Android",
        icon: FontAwesomeIcons.googlePlay,
        isFa: true,
        url: widget.app.playStoreUrl!,
      ));
    }
    if (widget.app.webUrl != null) {
      urls.add(_PlatformEntry(
        label: "Website",
        subtitle: "Browser",
        icon: Icons.language,
        isFa: false,
        url: widget.app.webUrl!,
      ));
    }

    if (urls.isEmpty) return;
    if (urls.length == 1) {
      UrlLauncher.launch(urls.first.url);
      return;
    }

    showDialog(
      context: context,
      builder: (_) => _PlatformDialog(
        app: widget.app,
        iconWidget: _icon(size: 40),
        entries: urls,
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
                _icon(),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.app.title,
                    style: GoogleFonts.openSans(
                      fontSize: AdaptiveFontSize.getFontSize(context, 15),
                      fontWeight: FontWeight.w600,
                      color: white,
                      shadows: _hovered
                          ? const [Shadow(color: blue, blurRadius: 6)]
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.app.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AdaptiveFontSize.getFontSize(context, 13),
                color: Colors.white60,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 12),
            // Platform indicators — these are also individually tappable;
            // Flutter's gesture system ensures the inner InkWell wins over
            // the outer one when tapping directly on an icon.
            Row(
              children: [
                if (widget.app.appStoreUrl != null)
                  _CardLink(
                    icon: FontAwesomeIcons.appStore,
                    tooltip: "App Store",
                    onTap: () =>
                        UrlLauncher.launch(widget.app.appStoreUrl!),
                  ),
                if (widget.app.playStoreUrl != null)
                  _CardLink(
                    icon: FontAwesomeIcons.googlePlay,
                    tooltip: "Play Store",
                    onTap: () =>
                        UrlLauncher.launch(widget.app.playStoreUrl!),
                  ),
                if (widget.app.webUrl != null)
                  _CardLink(
                    icon: Icons.language,
                    tooltip: "Website",
                    onTap: () => UrlLauncher.launch(widget.app.webUrl!),
                    isMaterial: true,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Platform selection dialog ─────────────────────────────────────────────

class _PlatformEntry {
  final String label;
  final String subtitle;
  final dynamic icon;
  final bool isFa;
  final String url;

  const _PlatformEntry({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.isFa,
    required this.url,
  });
}

class _PlatformDialog extends StatelessWidget {
  final AppModel app;
  final Widget iconWidget;
  final List<_PlatformEntry> entries;

  const _PlatformDialog({
    required this.app,
    required this.iconWidget,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                iconWidget,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.title,
                        style: GoogleFonts.openSans(
                          fontSize: AdaptiveFontSize.getFontSize(
                              context, 16),
                          fontWeight: FontWeight.w600,
                          color: white,
                        ),
                      ),
                      const SizedBox(height: 2),
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
            ...entries.map((e) => _EntryTile(entry: e)),
          ],
        ),
      ),
    );
  }
}

class _EntryTile extends StatefulWidget {
  final _PlatformEntry entry;
  const _EntryTile({required this.entry});

  @override
  State<_EntryTile> createState() => _EntryTileState();
}

class _EntryTileState extends State<_EntryTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onHover: (v) => setState(() => _hovered = v),
      onTap: () {
        Navigator.pop(context);
        UrlLauncher.launch(widget.entry.url);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: _hovered
              ? blue.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            widget.entry.isFa
                ? FaIcon(widget.entry.icon as IconData,
                    color: _hovered ? blue : white, size: 20)
                : Icon(widget.entry.icon as IconData,
                    color: _hovered ? blue : white, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.entry.label,
                    style: GoogleFonts.openSans(
                      fontSize:
                          AdaptiveFontSize.getFontSize(context, 14),
                      fontWeight: FontWeight.w500,
                      color: _hovered ? blue : white,
                    ),
                  ),
                  Text(
                    widget.entry.subtitle,
                    style: TextStyle(
                      fontSize:
                          AdaptiveFontSize.getFontSize(context, 11),
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
}

// ── Individual platform icon (within the card footer) ────────────────────

class _CardLink extends StatefulWidget {
  final dynamic icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isMaterial;

  const _CardLink({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.isMaterial = false,
  });

  @override
  State<_CardLink> createState() => _CardLinkState();
}

class _CardLinkState extends State<_CardLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onHover: (v) => setState(() => _hovered = v),
        onTap: widget.onTap,
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
          child: widget.isMaterial
              ? Icon(
                  widget.icon as IconData,
                  color: _hovered ? blue : Colors.white54,
                  size: 18,
                )
              : FaIcon(
                  widget.icon as IconData,
                  color: _hovered ? blue : Colors.white54,
                  size: 16,
                ),
        ),
      ),
    );
  }
}
