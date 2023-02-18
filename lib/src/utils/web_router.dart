import 'package:flutter/material.dart';
import '../models/enums/user_types.dart';
import '../ui/authentication/create_account_page.dart';
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
      case createAccountPage:
        var arguments = Map.from(settings.arguments as Map<String, dynamic>);
        UserTypes userType = arguments["signUpUserType"] ?? UserTypes.driver;
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => CreateAccountPage(signUpUserType: userType),
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
