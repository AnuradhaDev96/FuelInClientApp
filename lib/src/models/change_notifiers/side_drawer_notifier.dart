import 'package:flutter/material.dart';

class SideDrawerNotifier extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get mainScaffoldKey => _scaffoldKey;

  void operateDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }
}