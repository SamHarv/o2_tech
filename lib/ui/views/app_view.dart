import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../data/models/app_model.dart';
import '../../logic/services/url_launcher.dart';
import '../../logic/services/adaptive_font.dart';
import '../widgets/fade_in_widget.dart';

class AppView extends StatelessWidget {
  final AppModel app;

  const AppView({super.key, required this.app});

  Widget _appIcon(BuildContext context, double size) {
    final widget = Image.asset(app.logo, width: size, height: size, fit: BoxFit.contain);
    if (app.title == "Thoughts") {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(borderRadius: BorderRadius.circular(12), child: widget),
      );
    }
    return ClipRRect(borderRadius: BorderRadius.circular(12), child: widget);
  }

  Widget _storeLinks(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (app.appStoreUrl != null)
          IconButton(
            tooltip: "Apple App Store",
            hoverColor: blue,
            splashColor: white,
            icon: const FaIcon(FontAwesomeIcons.appStore, color: white, size: 36),
            onPressed: () => UrlLauncher.launch(app.appStoreUrl!),
          ),
        if (app.playStoreUrl != null)
          IconButton(
            tooltip: "Google Play Store",
            hoverColor: blue,
            splashColor: white,
            icon: const FaIcon(FontAwesomeIcons.googlePlay, color: white, size: 36),
            onPressed: () => UrlLauncher.launch(app.playStoreUrl!),
          ),
        if (app.webUrl != null)
          IconButton(
            tooltip: "Web Version",
            hoverColor: blue,
            splashColor: white,
            icon: const Icon(Icons.language, color: white, size: 36),
            onPressed: () => UrlLauncher.launch(app.webUrl!),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final mediaHeight = MediaQuery.sizeOf(context).height;
    final isLandscape = mediaWidth / mediaHeight > 0.9;

    return LayoutBuilder(
      builder: (context, constraints) {
        final iconSize = (constraints.maxHeight * 0.14).clamp(40.0, 80.0);

        if (isLandscape) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaWidth > 1250 ? 80 : 40,
                  vertical: 32,
                ),
                child: LayoutBuilder(
                  builder: (context, inner) {
                    final halfWidth = inner.maxWidth / 2 - 16;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Info column
                        SizedBox(
                          width: halfWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInWidget(widgetToFadeIn: _appIcon(context, iconSize)),
                              const SizedBox(height: 20),
                              FadeInWidget(
                                widgetToFadeIn: Text(
                                  app.title,
                                  style: GoogleFonts.openSans(
                                    fontSize: AdaptiveFontSize.getFontSize(context, 20),
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                    shadows: const [
                                      Shadow(color: blue, blurRadius: 3),
                                      Shadow(color: blue, blurRadius: 6),
                                      Shadow(color: blue, blurRadius: 9),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              FadeInWidget(
                                widgetToFadeIn: Text(
                                  app.description,
                                  style: TextStyle(
                                    fontSize: AdaptiveFontSize.getFontSize(context, 14),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              FadeInWidget(widgetToFadeIn: _storeLinks(context)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        // Screenshot
                        Expanded(
                          child: FadeInWidget(
                            widgetToFadeIn: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.asset(
                                app.screenshot,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }

        // Portrait
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: FadeInWidget(
                      widgetToFadeIn: Text(
                        app.title,
                        style: GoogleFonts.openSans(
                          fontSize: AdaptiveFontSize.getFontSize(context, 22),
                          fontWeight: FontWeight.bold,
                          color: white,
                          shadows: const [
                            Shadow(color: blue, blurRadius: 3),
                            Shadow(color: blue, blurRadius: 6),
                            Shadow(color: blue, blurRadius: 9),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FadeInWidget(widgetToFadeIn: _appIcon(context, 48)),
                ],
              ),
              const SizedBox(height: 10),
              FadeInWidget(
                widgetToFadeIn: Text(
                  app.description,
                  style: TextStyle(
                    fontSize: AdaptiveFontSize.getFontSize(context, 14),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: FadeInWidget(
                        widgetToFadeIn: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            app.screenshot,
                            fit: BoxFit.contain,
                            alignment: Alignment.bottomLeft,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FadeInWidget(
                      widgetToFadeIn: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (app.appStoreUrl != null)
                            IconButton(
                              tooltip: "Apple App Store",
                              hoverColor: blue,
                              icon: const FaIcon(FontAwesomeIcons.appStore, color: white, size: 36),
                              onPressed: () => UrlLauncher.launch(app.appStoreUrl!),
                            ),
                          if (app.playStoreUrl != null)
                            IconButton(
                              tooltip: "Google Play Store",
                              hoverColor: blue,
                              icon: const FaIcon(FontAwesomeIcons.googlePlay, color: white, size: 36),
                              onPressed: () => UrlLauncher.launch(app.playStoreUrl!),
                            ),
                          if (app.webUrl != null)
                            IconButton(
                              tooltip: "Web Version",
                              hoverColor: blue,
                              icon: const Icon(Icons.language, color: white, size: 36),
                              onPressed: () => UrlLauncher.launch(app.webUrl!),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
