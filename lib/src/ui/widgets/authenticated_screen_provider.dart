import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/models/authentication/fuel_in_user.dart';
import 'package:matara_division_system/src/models/enums/user_types.dart';
import 'package:matara_division_system/src/ui/widgets/reader_home/seat_organizer_home.dart';
import 'package:matara_division_system/src/ui/widgets/verify_email_page.dart';

import '../../api_providers/main_api_provider.dart';
import '../../config/app_settings.dart';
import '../../models/authentication/lock_hood_user.dart';
import '../../models/authentication/system_user.dart';
import '../../services/auth_service.dart';
import 'admin_home/admin_home.dart';
import 'splash_web_screen.dart';

// import 'admin_home/seat_organizer_home.dart';

class AuthenticatedScreenProvider extends StatefulWidget {
  const AuthenticatedScreenProvider({Key? key}) : super(key: key);

  @override
  State<AuthenticatedScreenProvider> createState() => _AuthenticatedScreenProviderState();
}

class _AuthenticatedScreenProviderState extends State<AuthenticatedScreenProvider> {
  late bool _isEmailVerified;
  Timer? _checkUserVerifiedEmailTimer;

  @override
  void initState() {
    _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!_isEmailVerified) {
      _checkUserVerifiedEmailTimer = Timer.periodic(
        const Duration(seconds: 4),
        (timer) {
          _checkUserHasVerifiedEmail();
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_checkUserVerifiedEmailTimer != null) _checkUserVerifiedEmailTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkUserHasVerifiedEmail() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (_isEmailVerified) _checkUserVerifiedEmailTimer?.cancel();
  }



  @override
  Widget build(BuildContext context) {
    if (!_isEmailVerified) {
      return VerifyEmailPage();
    } else {
      return FutureBuilder(
        future: GetIt.I<MainApiProvider>().getPermissionsForUser(),
        builder: (BuildContext context, AsyncSnapshot<FuelInUser?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashWebScreen();
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const SplashWebScreen();
          } else if (snapshot.hasData) {
            UserTypes? managementType = AppSettings.getEnumValueForUserTypeString(snapshot.data!.role);

            if (managementType == UserTypes.systemAdmin) {
              return const AdminHome();
            } else if (managementType == UserTypes.fuelStationManager) {
              return const FuelStationManagerHome();
            } else {
              return const SplashWebScreen();
            }
          }
          return const SplashWebScreen();
        },
      );
    }
  }
}