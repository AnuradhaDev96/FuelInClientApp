import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/config/app_settings.dart';
import 'package:matara_division_system/src/models/authentication/authenticated_user.dart';

import '../../utils/local_storage_utils.dart';

class ApplicationAuthNotifier extends ChangeNotifier {
  // bool _isAppAuthenticated = false;
  // TODO: implement stream for firebase authenitcation
  /* sources
  * 1. https://stackoverflow.com/questions/64520543/struggling-with-authstatechanges-in-flutter
  * 2. https://stackoverflow.com/questions/63669262/check-authentication-state-of-user-using-firebaseauth-in-flutter
  * 3. https://firebase.flutter.dev/docs/auth/usage/
  * */

  AuthenticatedUser? _authenticatedUser;
  // AuthenticatedUser? get authenticatedUser => _authenticatedUser;

  final LocalStorageUtils _localStorageUtils =  GetIt.I<LocalStorageUtils>();

  bool checkAppAuthenticated() {

    // GetIt.I<LocalStorageUtils>().hiveDbBox = await Hive.openBox(AppSettings.authHiveBox);
    bool savedLoggedInValue =
        GetIt.I<LocalStorageUtils>().hiveDbBox?.get(AppSettings.hiveKeyAppIsAuthenticated, defaultValue: false);
    _authenticatedUser =
        GetIt.I<LocalStorageUtils>().hiveDbBox?.get(AppSettings.hiveKeyAuthenticatedUser, defaultValue: null);

    if (savedLoggedInValue && _authenticatedUser != null) {
      return true;
    } else {
      return false;
    }
  }

  void setAppAuthenticated(AuthenticatedUser authenticatedUser) {
    print("Setting auth");
    _authenticatedUser = authenticatedUser;
    _localStorageUtils.hiveDbBox?.put(AppSettings.hiveKeyAppIsAuthenticated, true);
    _localStorageUtils.hiveDbBox?.put(AppSettings.hiveKeyAuthenticatedUser, authenticatedUser);
    notifyListeners();
  }

  void setAppUnAuthenticated() {
    _authenticatedUser = null;
    _localStorageUtils.hiveDbBox?.put(AppSettings.hiveKeyAppIsAuthenticated, false);
    _localStorageUtils.hiveDbBox?.put(AppSettings.hiveKeyAuthenticatedUser, null);

    // temp
    bool savedLoggedInValue = _localStorageUtils.hiveDbBox?.get(AppSettings.hiveKeyAppIsAuthenticated, defaultValue: false);
    print("after Attempt sign out: $savedLoggedInValue");
    notifyListeners();
  }
}