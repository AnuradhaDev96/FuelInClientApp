import 'package:flutter/material.dart';

class NavigationUtils {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future <dynamic> pushNamed(String routeName, {Object? arguments}) {
    return navigationKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }
}