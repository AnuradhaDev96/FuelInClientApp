import 'dart:math';

import 'package:encrypt/encrypt.dart';

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
    final Key key = Key.fromLength(32);
    final IV iv = IV.fromLength(16);

    final Encrypter encrypter = Encrypter(AES(key));
    final Encrypted encryptedValue = encrypter.encrypt(value, iv: iv);

    return encryptedValue.base64;
  }

}