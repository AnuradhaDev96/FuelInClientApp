import 'dart:math';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';

class CommonUtils {
  static String generatePasswordForAuth({
    bool includeLetters = true,
    bool includeNumbers = true,
    bool includeCharacters = true,
  }) {
    const length = 15;
    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    const special = '@#%^*>\$@?/[]=+';

    String charsForPassword = "";
    if (includeLetters) charsForPassword += "$letterLowerCase$letterUpperCase";
    if (includeNumbers) charsForPassword += number;
    if (includeCharacters) charsForPassword += special;

    return List.generate(length, (index) {
      final randomIndex = Random.secure().nextInt(charsForPassword.length);
      return charsForPassword[randomIndex];
    }).join('');
  }

  static String getPasswordOnSave(String value) {
    final enc.Key key = enc.Key.fromLength(32);
    final enc.IV iv = enc.IV.fromLength(16);

    final enc.Encrypter encrypter = enc.Encrypter(enc.AES(key));
    final enc.Encrypted encryptedValue = encrypter.encrypt(value, iv: iv);

    return encryptedValue.base64;
  }

  static bool isMobileUI(BuildContext context) => MediaQuery.of(context).size.width < 850;

  static bool isTabletUi(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;

  static bool isDesktopUI(BuildContext context) => MediaQuery.of(context).size.width >= 1100;
}