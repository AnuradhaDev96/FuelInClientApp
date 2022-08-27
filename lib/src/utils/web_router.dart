import 'package:flutter/material.dart';
import 'package:rh_reader/src/ui/authentication/signin_page.dart';

class WebRouter {
  static const String signInPage = "sign in page";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signInPage:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const SignInPage(),
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
