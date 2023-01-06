import 'package:flutter/material.dart';
import '../ui/authentication/signin_page.dart';
import '../ui/landing_page/landing_page.dart';

class WebRouter {
  static const String signInPage = "/sign-in";
  static const String createAccountPage = "/create-account";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signInPage:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const LandingPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
