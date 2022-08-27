import 'package:flutter/material.dart';
import 'package:rh_reader/src/models/enums/screen_bucket_enum.dart';

class SideDrawerNotifier extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get mainScaffoldKey => _scaffoldKey;

  ScreenBuckets? _selectedPageType = ScreenBuckets.home;

  ScreenBuckets? get selectedPageType => _selectedPageType;

  String selectedPageTitle() {
    if (_selectedPageType == null) {
      return "";
    } else {
      ScreenBuckets sb = _selectedPageType!;
      return sb.toDisplayString();
    }
  }

  set selectedPageType(ScreenBuckets? selectedPageIndex) {
    _selectedPageType = selectedPageIndex;
    notifyListeners();
  }

  void operateDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }
}