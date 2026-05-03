import 'package:beamer/beamer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:o2_tech/ui/views/contact_form_view.dart';
import 'package:o2_tech/ui/views/portfolio_view.dart';

import '../../ui/views/legal_view.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
  analytics: analytics,
);

final routerDelegate = BeamerDelegate(
  notFoundRedirectNamed: '/',
  initialPath: '/',
  navigatorObservers: [observer],
  locationBuilder:
      RoutesLocationBuilder(
        routes: {
          '/': (context, state, data) {
            return const BeamPage(
              key: ValueKey(''),
              type: BeamPageType.noTransition,
              title: 'O\u2082Tech',
              child: PortfolioView(),
            );
          },
          '/privacy': (context, state, data) {
            return BeamPage(
              key: const ValueKey('privacy'),
              type: BeamPageType.noTransition,
              title: 'Privacy & Terms',
              child: LegalView(), // Pass reading data
            );
          },
          '/contact': (context, state, data) {
            return BeamPage(
              key: const ValueKey('contact'),
              type: BeamPageType.noTransition,
              title: 'Contact Form',
              child: ContactFormView(), // Pass reading data
            );
          },
        },
      ).call,
);
