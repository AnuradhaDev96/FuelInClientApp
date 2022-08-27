import 'package:flutter/material.dart';
import 'package:rh_reader/src/models/enums/screen_bucket_enum.dart';

class SideDrawerNotifier extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get mainScaffoldKey => _scaffoldKey;

  ScreenBuckets? _selectedPageType;

  ScreenBuckets? get selectedPageType => _selectedPageType;

  set selectedPageType(ScreenBuckets? selectedPageIndex) {
    _selectedPageType = _selectedPageType;
    notifyListeners();
  }

  void operateDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }
}