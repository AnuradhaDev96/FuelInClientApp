import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matara_division_system/src/ui/widgets/verify_email_page.dart';

import 'admin_home/admin_home.dart';

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
      return const AdminHome();
    }

  }
}