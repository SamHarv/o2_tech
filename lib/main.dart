import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

import 'config/constants.dart';
import 'ui/views/portfolio_view.dart';

Future<void> main() async {
  // Set the status bar colour to black
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: black,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: false,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'O2 Tech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(primary: black, secondary: blue),
        primaryColor: black,
        scaffoldBackgroundColor: black,

        textTheme: GoogleFonts.openSansTextTheme().apply(
          bodyColor: white,
          displayColor: white,
        ),

        appBarTheme: AppBarTheme(
          color: black,

          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: black,
            systemNavigationBarColor: black,
            systemNavigationBarDividerColor: black,
          ),
        ),
      ),
      home: const PortfolioView(),
    );
  }
}
