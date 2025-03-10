// import 'package:beamer/beamer.dart';
// import 'package:flutter/material.dart';
// import 'package:o2_tech/ui/views/portfolio_view.dart';

// final routerDelegate = BeamerDelegate(
//   notFoundRedirectNamed: '/home',
//   initialPath: '/home',
//   locationBuilder:
//       RoutesLocationBuilder(
//         routes: {
//           '/home': (context, state, data) {
//             return const BeamPage(
//               key: ValueKey('home'),
//               type: BeamPageType.noTransition,
//               title: 'O2Tech Blood Pressure',
//               child: PortfolioView(title: 'O2Tech BP'),
//             );
//           },
//           '/legal': (context, state, data) {
//             return BeamPage(
//               key: const ValueKey('legal'),
//               type: BeamPageType.noTransition,
//               title: 'Privacy & Terms',
//               child: LegalView(), // Pass reading data
//             );
//           },
//           '/sign-in': (context, state, data) {
//             return const BeamPage(
//               key: ValueKey('sign-in'),
//               type: BeamPageType.noTransition,
//               title: 'Sign In',
//               child: SignInView(),
//             );
//           },
//           '/sign-up': (context, state, data) {
//             return const BeamPage(
//               key: ValueKey('sign-up'),
//               type: BeamPageType.noTransition,
//               title: 'Sign Up',
//               child: SignUpView(),
//             );
//           },
//           '/forgot-password': (context, state, data) {
//             return const BeamPage(
//               key: ValueKey('forgot-password'),
//               type: BeamPageType.noTransition,
//               title: 'Forgot Password',
//               child: ForgotPasswordView(),
//             );
//           },
//           '/account': (context, state, data) {
//             return const BeamPage(
//               key: ValueKey('account'),
//               type: BeamPageType.noTransition,
//               title: 'Account',
//               child: AccountView(),
//             );
//           },
//         },
//       ).call,
// );
