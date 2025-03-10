import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/config/constants.dart';
import 'contact_view.dart';
import 'digby_view.dart';
import 'home_view.dart';
import 'app_view.dart';
import '/data/repository/app_data.dart';

class PortfolioView extends StatefulWidget {
  /// UI to display the portfolio in a PageView widget

  const PortfolioView({super.key});

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  final pageController = PageController();
  int _index = 0; // Current page index
  // Animation properties for page transitions
  final _animationDuration = Duration(milliseconds: 500);
  final _curve = Curves.easeIn;
  // Detect whether mouse wheel is scrolling to prevent jank
  bool isMouse = false;

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final mediaHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding:
              (mediaWidth / mediaHeight > 0.9)
                  ? const EdgeInsets.fromLTRB(80, 8, 8, 8)
                  : const EdgeInsets.all(8),
          child: Tooltip(
            message: "Navigate Home",
            child: InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: () {
                pageController.animateToPage(
                  0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              },
              child: SizedBox(height: 40, child: Image.asset(logo)),
            ),
          ),
        ),
        actions: [
          // Navigate to contact page
          Padding(
            padding:
                (mediaWidth / mediaHeight > 0.9)
                    ? const EdgeInsets.only(right: 80)
                    : const EdgeInsets.all(0),
            child: IconButton(
              tooltip: "Navigate to Contact",
              icon: FaIcon(
                FontAwesomeIcons.envelope,
                shadows: [
                  Shadow(color: Colors.blue, blurRadius: 3),
                  Shadow(color: Colors.blue, blurRadius: 6),
                  Shadow(color: Colors.blue, blurRadius: 9),
                ],
              ),
              onPressed: () {
                pageController.animateToPage(
                  10,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: ScrollConfiguration(
        // Enable drag scrolling with mouse
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: GestureDetector(
          onTap: () {
            // Reset mouse state on tap
            setState(() {
              isMouse = false;
            });
          },
          child: Listener(
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent) {
                // Determine whether the user is scrolling with a mouse
                if (pointerSignal.kind == PointerDeviceKind.mouse) {
                  setState(() {
                    isMouse = true;
                  });
                } else {
                  setState(() {
                    isMouse = false;
                  });
                }
                // Custom scroll logic
                if (pointerSignal.scrollDelta.dy > 0) {
                  if (_index == 10) {
                    return;
                  }
                  pageController.nextPage(
                    duration: _animationDuration,
                    curve: _curve,
                  );
                } else {
                  if (_index == 0) {
                    return;
                  }
                  pageController.previousPage(
                    duration: _animationDuration,
                    curve: _curve,
                  );
                }
              }
            },
            child: PageView(
              // NeverScrollableScrollPhysics prevents the PageView from
              // scrolling with the mouse wheel as it causes jank, custom
              // scroll logic is implemented instead
              physics:
                  isMouse
                      ? const NeverScrollableScrollPhysics()
                      : const PageScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: pageController,
              pageSnapping: true,
              // Handle page change
              onPageChanged: (index) {
                setState(() => _index = index);
              },
              // Pages to display
              children: [
                HomeView(),
                AppView(app: apps[0]),
                AppView(app: apps[1]),
                AppView(app: apps[2]),
                AppView(app: apps[3]),
                AppView(app: apps[4]),
                AppView(app: apps[5]),
                AppView(app: apps[6]),
                AppView(app: apps[7]),
                DigbyView(),

                // TODO: Testimonials
                ContactView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
