import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:o2_tech/ui/views/contact_form_view.dart';
import 'package:o2_tech/ui/views/portfolio_view.dart';

import '../../ui/views/legal_view.dart';

final routerDelegate = BeamerDelegate(
  notFoundRedirectNamed: '/home',
  initialPath: '/home',
  locationBuilder:
      RoutesLocationBuilder(
        routes: {
          '/home': (context, state, data) {
            return const BeamPage(
              key: ValueKey('home'),
              type: BeamPageType.noTransition,
              title: 'O2Tech Blood Pressure',
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
