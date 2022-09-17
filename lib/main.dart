import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket/page/main/bill.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:movie_ticket/page/main/index.dart';
import 'package:movie_ticket/page/main/member.dart';
import 'package:movie_ticket/page/admin/admin.dart';
import 'package:movie_ticket/page/main/movie.dart';
import 'package:movie_ticket/page/main/register.dart';
import 'package:movie_ticket/page/not_found.dart';

import 'package:google_fonts/google_fonts.dart';

import 'global.dart' as g;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(const MovieTickte());
}

class MovieTickte extends StatelessWidget {
  const MovieTickte({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FS Cinema',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
        primarySwatch: Colors.blueGrey,
        fontFamily: GoogleFonts.firaSans().fontFamily,
        appBarTheme: AppBarTheme(
          elevation: 0,
          toolbarHeight: 60,
          foregroundColor: Colors.black,
          backgroundColor: g.colorPallet[0],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: kIsWeb ? { for (final platform in TargetPlatform.values) platform: const NoTransitionsBuilder() } : const {},
        )
      ),
      
      initialRoute: "/home",
      routes: {
        "/home": (context) => const Index(),
        "/register": (context) => const Register(),
        "/movie": (context) => const Movie(),
        "/member": (context) => const Member(),
        "/bill": (context) => const Bill(),

        "/admin": (context) => const Admin(),

        "/notfound": (context) => const NotFound(),
      },
    );
  }
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // only return the child without warping it with animations
    return child!;
  }
}