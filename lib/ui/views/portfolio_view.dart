import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:animated_background/animated_background.dart';
import 'package:o2_tech/ui/views/testimonials_view.dart';
import 'package:o2_tech/ui/widgets/loading_widget.dart';

import '../../config/constants.dart';
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

class _PortfolioViewState extends State<PortfolioView>
    with TickerProviderStateMixin {
  final pageController = PageController();
  int _index = 0; // Current page index
  // Animation properties for page transitions
  final _animationDuration = Duration(milliseconds: 500);
  final _curve = Curves.easeIn;
  // Detect whether mouse wheel is scrolling to prevent jank
  bool isMouse = false;

  final homeKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: _animationDuration,
      curve: _curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final mediaHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: false,
        title: Padding(
          padding:
              (mediaWidth / mediaHeight > 0.9)
                  ? mediaWidth > 1250
                      ? const EdgeInsets.fromLTRB(184, 8, 8, 8)
                      : const EdgeInsets.fromLTRB(80, 8, 8, 8)
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
              child: LoadingWidget(size: 50, duration: 5000),
              //SizedBox(height: 40, child: Image.asset(logo)),
            ),
          ),
        ),
        actions: [
          // Navigate to contact page
          Padding(
            padding:
                (mediaWidth / mediaHeight > 0.9)
                    ? mediaWidth > 1250
                        ? const EdgeInsets.only(right: 184)
                        : const EdgeInsets.only(right: 80)
                    : const EdgeInsets.all(0),
            child: IconButton(
              tooltip: "Navigate to Contact",
              icon: FaIcon(
                FontAwesomeIcons.envelope,
                shadows: [
                  Shadow(color: blue, blurRadius: 3),
                  Shadow(color: blue, blurRadius: 6),
                  Shadow(color: blue, blurRadius: 9),
                ],
              ),
              onPressed: () {
                pageController.animateToPage(
                  12,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      // body: Center(child: LoadingWidget(duration: 2500)),
      // body:
      // AnimatedBackground(
      //   vsync: this,
      //   behaviour: RandomParticleBehaviour(
      //     options: const ParticleOptions(
      //       baseColor: blue,
      //       spawnOpacity: 0.0,
      //       opacityChangeRate: 0.25,
      //       minOpacity: 0.1,
      //       maxOpacity: 0.4,
      //       spawnMaxRadius: 10,
      //       spawnMinSpeed: 500.0,
      //       spawnMaxSpeed: 700.0,
      //       particleCount: 10,
      //     ),
      //   ),
      //   child:
      // ScrollConfiguration(
      //   // Enable drag scrolling with mouse
      //   behavior: ScrollConfiguration.of(context).copyWith(
      //     dragDevices: {
      //       PointerDeviceKind.touch,
      //       PointerDeviceKind.mouse,
      //       PointerDeviceKind.trackpad,
      //     },
      //   ),
      // child: GestureDetector(
      //   // onTapDown: (details) {
      //   //   // Reset mouse state on tap
      //   //   setState(() {
      //   //     isMouse = false;
      //   //   });
      //   // },
      //   onVerticalDragUpdate: (details) {
      //     // Reset mouse state on drag
      //     setState(() {
      //       isMouse = false;
      //     });
      //   },
      //   child: Listener(
      //     onPointerSignal: (pointerSignal) {
      //       if (pointerSignal is PointerScrollEvent) {
      //         // Determine whether the user is scrolling with a mouse
      //         if (pointerSignal.kind == PointerDeviceKind.mouse ||
      //             pointerSignal.kind == PointerDeviceKind.trackpad) {
      //           setState(() {
      //             isMouse = true;
      //           });
      //         } else {
      //           setState(() {
      //             isMouse = false;
      //           });
      //         }
      //         // Custom scroll logic
      //         if (pointerSignal.scrollDelta.dy > 0) {
      //           if (_index == 11) {
      //             return;
      //           }
      //           pageController.nextPage(
      //             duration: _animationDuration,
      //             curve: _curve,
      //           );
      //         } else if (pointerSignal.scrollDelta.dy < 0) {
      //           if (_index == 0) {
      //             return;
      //           }
      //           pageController.previousPage(
      //             duration: _animationDuration,
      //             curve: _curve,
      //           );
      //         }
      //       }
      //     },
      // child:
      // PageView(
      //   // NeverScrollableScrollPhysics prevents the PageView from
      //   // scrolling with the mouse wheel as it causes jank, custom
      //   // scroll logic is implemented instead
      //   physics:
      //       isMouse
      //           ? const NeverScrollableScrollPhysics()
      //           : const PageScrollPhysics(),
      //   scrollDirection: Axis.vertical,
      //   controller: pageController,
      //   pageSnapping: true,
      //   // Handle page change
      //   onPageChanged: (index) {
      //     setState(() => _index = index);
      //   },
      body: SingleChildScrollView(
        physics: PageScrollPhysics(),
        controller: pageController,
        child: Column(
          // Pages to display
          children: [
            SizedBox(
              key: homeKey,
              width: mediaWidth,
              height: mediaHeight - 60,
              child: HomeView(),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: AppView(app: apps[0]),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: AppView(app: apps[1]),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: AppView(app: apps[2]),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: AppView(app: apps[3]),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: AppView(app: apps[4]),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: AppView(app: apps[5]),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: AppView(app: apps[6]),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: AppView(app: apps[7]),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: AppView(app: apps[8]),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: AppView(app: apps[9]),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: DigbyView(),
            ),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight - 60,
              child: TestimonialsView(),
            ),
            SizedBox(
              key: contactKey,
              width: mediaWidth,
              height: mediaHeight - 60,
              child: ContactView(),
            ),
          ],
        ),
      ),
    );
    // ),
    // ),
    //   ),
    // ),
  }
}
