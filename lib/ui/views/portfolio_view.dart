import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../logic/services/adaptive_font.dart';
import '/data/repository/app_data.dart';
import '../widgets/app_card_widget.dart';
import '../widgets/fade_in_widget.dart';
import '../widgets/loading_widget.dart';
import 'contact_view.dart';
import 'digby_view.dart';
import 'home_view.dart';
import 'testimonials_view.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  final _scrollController = ScrollController();
  final _contactKey = GlobalKey();

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 400));
    _scrollToTop();
  }

  void _scrollToContact() {
    final ctx = _contactKey.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }


  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance
        .logEvent(name: 'portfolio_view', parameters: {'source': 'web'})
        .catchError((_) {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        // Title fills full toolbar width; ConstrainedBox centres it to 1200 px,
        // matching every other page section so the logo and contact icon sit
        // on the same grid as the headings and cards below.
        title: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Tooltip(
                    message: "Back to top",
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: _scrollToTop,
                      child: const LoadingWidget(size: 48, duration: 5000),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Contact",
                    icon: const FaIcon(
                      FontAwesomeIcons.envelope,
                      shadows: [
                        Shadow(color: blue, blurRadius: 3),
                        Shadow(color: blue, blurRadius: 7),
                        Shadow(color: blue, blurRadius: 12),
                      ],
                    ),
                    onPressed: _scrollToContact,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: blue,
        backgroundColor: const Color(0xFF1C1C1C),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero — full viewport height
              SizedBox(
                height: h - 64,
                child: const HomeView(),
              ),
              // Work section
              _WorkSection(apps: apps),
              // Testimonials
              const TestimonialsView(),
              // Contact — anchored for scroll-to
              SizedBox(
                key: _contactKey,
                child: const ContactView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Work section — responsive app grid (Digby at end)
// ---------------------------------------------------------------------------

class _WorkSection extends StatelessWidget {
  final List<dynamic> apps;

  const _WorkSection({required this.apps});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;

    return Center(
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
                widgetToFadeIn: _SectionHeading(
                  title: "Work",
                  context: context,
                ),
              ),
              const SizedBox(height: 48),
              // App grid — Digby included at end, equal height per row
              LayoutBuilder(
                builder: (context, constraints) {
                  final avail = constraints.maxWidth;
                  final cols = avail > 820
                      ? 3
                      : avail > 520
                          ? 2
                          : 1;
                  const gap = 16.0;
                  final cardW = (avail - gap * (cols - 1)) / cols;
                  final gridItems = <Widget>[
                    ...apps.map((app) => AppCardWidget(app: app)),
                    const DigbyView(),
                  ];
                  final rows = <Widget>[];
                  for (var i = 0; i < gridItems.length; i += cols) {
                    if (i > 0) rows.add(const SizedBox(height: gap));
                    final slice =
                        gridItems.skip(i).take(cols).toList();
                    rows.add(IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (var j = 0; j < slice.length; j++) ...[
                            if (j > 0) const SizedBox(width: gap),
                            SizedBox(width: cardW, child: slice[j]),
                          ],
                          for (var j = slice.length; j < cols; j++) ...[
                            const SizedBox(width: gap),
                            SizedBox(width: cardW),
                          ],
                        ],
                      ),
                    ));
                  }
                  return Column(children: rows);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared section heading widget used by Work section
// ---------------------------------------------------------------------------

class _SectionHeading extends StatelessWidget {
  final String title;
  final BuildContext context;

  const _SectionHeading({required this.title, required this.context});

  @override
  Widget build(BuildContext _) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
    );
  }
}
