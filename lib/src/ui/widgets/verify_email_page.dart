import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../utils/firebase_options.dart';
import '../../config/app_colors.dart';
import '../../config/language_settings.dart';
import '../../models/change_notifiers/application_auth_notifier.dart';
import '../../services/auth_service.dart';

class VerifyEmailPage extends StatefulWidget {
  VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  Timer? _countdownTimer;
  bool _isSendButtonEnabled = true;
  int _remainingTime = 31;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    print("######dispose is called");
    if (_countdownTimer != null) _countdownTimer?.cancel();
    super.dispose();
  }

  void _sendVerificationEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification(DefaultFirebaseOptions.actionCodeSettings);
    setState(() {
      _isSendButtonEnabled = false;
    });
    _startCountdownTimer();
  }

  void _startCountdownTimer() {
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if(_remainingTime == 0) {
          setState(() {
            _isSendButtonEnabled = true;
          });
          timer.cancel();
        } else {
          setState(() {
            _remainingTime--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.nppPurpleLight,
                    AppColors.darkPurple,
                    AppColors.nppPurpleDark,
                  ]
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0,  horizontal: 30.0),
                    child: Text(
                      "fuu .sKqu i;Hdmkh lsÍu i|yd Tnf.a Bfï,a bkafndlaia fyda iamEï f*da,avrfha we;s ,skala tlg fhduq jkak'",//මෙම ගිණුම සත්‍යාපනය කිරීම සඳහා ඔබගේ ඊමේල් ඉන්බොක්ස් හෝ ස්පෑම් ෆෝල්ඩරයේ ඇති ලින්ක් එකට යොමු වන්න.
                      style: TextStyle(
                        fontSize: 20.0,
                        color: AppColors.white
                        // fontFamily: 'DL-Paras',
                      ),
                    ),
                  ),
                  _isSendButtonEnabled
                      ? SizedBox(
                          width: 250,
                          height: 40,
                          child: ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                  backgroundColor: MaterialStateProperty.all(AppColors.appBarColor),
                                  textStyle: MaterialStateProperty.all(const TextStyle(
                                      fontFamily: 'DL-Paras',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.0,
                                      color: AppColors.darkPurple)),
                                ),
                            onPressed: () => _sendVerificationEmail(),
                            child: const Text(
                              "Resend Verification",
                              style: TextStyle(
                                color: AppColors.white,
                                fontFamily: SettingsSinhala.engFontFamily,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.white, width: 4.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          child: Center(
                            child: Text(
                              '$_remainingTime',
                              style: const TextStyle(
                                fontFamily: SettingsSinhala.engFontFamily,
                                fontSize: 25.0,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.all(
                            AppColors.appBarColor
                        ),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                          fontFamily: 'DL-Paras',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                          color: AppColors.darkPurple
                        )),
                      ),
                      onPressed: () => _logOutAction(context),
                      child: const Text(
                        "Log Out",//බඳවාගැනීම සම්පූර්ණ කරන්න
                        style: TextStyle(
                          color: AppColors.white,
                          fontFamily: SettingsSinhala.engFontFamily,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logOutAction(BuildContext context) async {
    try {
      await GetIt.I<AuthService>().signOutUser().then((value) => notifyAppIsUnAuthenticated(context));
    } catch (e) {
      return;
    }
  }

  void notifyAppIsUnAuthenticated(BuildContext context) {
    Provider.of<ApplicationAuthNotifier>(context, listen: false).setAppUnAuthenticated();
  }
}


// @override
// void initState() {
//   sendVerify();
//   super.initState();
// }
//

