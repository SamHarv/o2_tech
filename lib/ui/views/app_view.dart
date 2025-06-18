import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../data/models/app_model.dart';
import '../../logic/services/url_launcher.dart';
import '../../logic/services/adaptive_font.dart';
import '../widgets/fade_in_widget.dart';

class AppView extends StatelessWidget {
  /// UI for displaying an app in the portfolio
  ///
  /// // TODO: COnstrain height

  /// The app to display
  final AppModel app;

  const AppView({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final mediaHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(24),
      child:
          // Check if orientation is landscape factoring in foldables
          (mediaWidth / mediaHeight > 0.9)
              // Landscape orientation
              ? ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1050),
                child: Padding(
                  padding: const EdgeInsets.all(80),
                  child: Row(
                    spacing: 32,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App information
                      SizedBox(
                        width:
                            mediaWidth > 1050
                                ? 1050 / 2 - 48
                                : mediaWidth / 2 - 48,
                        child: Column(
                          spacing: 32,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // App logo/ icon
                            FadeInWidget(
                              widgetToFadeIn: Row(
                                children: [
                                  // Thoughts logo is black, so add a white background
                                  if (app.title != "Thoughts")
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        app.logo,
                                        width:
                                            mediaWidth < mediaHeight
                                                ? mediaWidth / 5
                                                : mediaHeight / 5,
                                      ),
                                    )
                                  else
                                    Container(
                                      height:
                                          mediaWidth < mediaHeight
                                              ? mediaWidth / 5
                                              : mediaHeight / 5,
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(app.logo),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            // App Title
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        mediaWidth > 1050
                                            ? 1050 / 2 - 80
                                            : mediaWidth / 2 - 80,
                                  ),
                                  child: FadeInWidget(
                                    widgetToFadeIn: Text(
                                      app.title,
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize:
                                              AdaptiveFontSize.getFontSize(
                                                context,
                                                20,
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
                            // App Description
                            Row(
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        mediaWidth > 1050
                                            ? 1050 / 2 - 48
                                            : mediaWidth / 2 - 48,
                                  ),
                                  child: FadeInWidget(
                                    widgetToFadeIn: Text(
                                      app.description,
                                      style: TextStyle(
                                        fontSize: AdaptiveFontSize.getFontSize(
                                          context,
                                          14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // App Links for GitHub, App Store, Play Store, Web
                            FadeInWidget(
                              widgetToFadeIn: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  app.appStoreUrl == null
                                      ? const SizedBox()
                                      : IconButton(
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
                                              app.appStoreUrl!,
                                            ),
                                      ),
                                  app.playStoreUrl == null
                                      ? const SizedBox()
                                      : IconButton(
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
                                              app.playStoreUrl!,
                                            ),
                                      ),
                                  app.webUrl == null
                                      ? const SizedBox()
                                      : IconButton(
                                        tooltip: "Web Version",
                                        hoverColor: blue,
                                        splashColor: white,
                                        icon: const Icon(
                                          Icons.language,
                                          color: white,
                                          size: 40,
                                        ),
                                        onPressed:
                                            () =>
                                                UrlLauncher.launch(app.webUrl!),
                                      ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // App Screenshot
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth:
                              mediaWidth > 1050
                                  ? 1050 / 2 - 192
                                  : mediaWidth / 2 - 192,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: FadeInWidget(
                              widgetToFadeIn: Image.asset(app.screenshot),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              // Portrait orientation
              : Column(
                spacing: 24,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // App Title
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: mediaWidth - 48),
                        child: FadeInWidget(
                          widgetToFadeIn: Text(
                            app.title,
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
                      // App logo/ icon
                      if (app.title != "Thoughts")
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FadeInWidget(
                            widgetToFadeIn: Image.asset(app.logo, height: 50),
                          ),
                        )
                      else
                        FadeInWidget(
                          widgetToFadeIn: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(app.logo),
                            ),
                          ),
                        ),
                    ],
                  ),
                  // App Description
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: mediaWidth - 48),
                        child: FadeInWidget(
                          widgetToFadeIn: Text(
                            app.description,
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // App Screenshot
                        ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: FadeInWidget(
                            widgetToFadeIn: Image.asset(app.screenshot),
                          ),
                        ),
                        // App Links for GitHub, App Store, Play Store, Web
                        FadeInWidget(
                          widgetToFadeIn: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // IconButton(
                              //   tooltip: "GitHub",
                              //   hoverColor: blue,
                              //   splashColor: white,
                              //   icon: const FaIcon(
                              //     FontAwesomeIcons.github,
                              //     color: white,
                              //     size: 40,
                              //   ),
                              //   onPressed:
                              //       () => UrlLauncher.launch(app.githubUrl),
                              // ),
                              app.appStoreUrl == null
                                  ? const SizedBox()
                                  : IconButton(
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
                                          app.appStoreUrl!,
                                        ),
                                  ),
                              app.playStoreUrl == null
                                  ? const SizedBox()
                                  : IconButton(
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
                                          app.playStoreUrl!,
                                        ),
                                  ),
                              app.webUrl == null
                                  ? const SizedBox()
                                  : IconButton(
                                    tooltip: "Web Version",
                                    hoverColor: blue,
                                    splashColor: white,
                                    icon: const Icon(
                                      Icons.language,
                                      color: white,
                                      size: 40,
                                    ),
                                    onPressed:
                                        () => UrlLauncher.launch(app.webUrl!),
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
  }
}
