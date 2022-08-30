import 'package:flutter/material.dart';
import 'package:rh_reader/src/models/enums/screen_bucket_enum.dart';

import '../enums/admin_screen_buckets.dart';

class SideDrawerNotifier extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKeyForAdmin = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get mainScaffoldKey => _scaffoldKey;
  GlobalKey<ScaffoldState> get adminScaffoldKey => _scaffoldKeyForAdmin;

  //general properties
  ScreenBuckets? _selectedPageType = ScreenBuckets.home;
  ScreenBuckets? get selectedPageType => _selectedPageType;

  // admin properties
  AdminScreenBuckets? _selectedPageTypeByAdmin = AdminScreenBuckets.employeeManagement;
  AdminScreenBuckets? get selectedPageTypeByAdmin => _selectedPageTypeByAdmin;

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

  // admin functions
  String selectedPageTitleByAdmin() {
    if (_selectedPageTypeByAdmin == null) {
      return "";
    } else {
      AdminScreenBuckets asb = _selectedPageTypeByAdmin!;
      return asb.toDisplayString();
    }
  }

  set selectedPageTypeByAdmin(AdminScreenBuckets? selectedPageIndex) {
    _selectedPageTypeByAdmin = selectedPageIndex;
    notifyListeners();
  }

  void operateDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void operateAdminDrawer() {
    _scaffoldKeyForAdmin.currentState!.openDrawer();
  }
}