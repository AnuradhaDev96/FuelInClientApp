import 'package:flutter/material.dart';

class CreditCardNotifier extends ChangeNotifier {
  String _expiryDate = "";

  get expiryDate => _expiryDate;

  void setExpiryDate(String value) {
    switch (value.length) {
      case 0:
      case 1:
      case 2:
        _expiryDate = value;
        break;
      case 3:
        if (value.contains("/")) {
          _expiryDate = value.substring(0, 2);
        } else {
          _expiryDate = "${value.substring(0,2)}/${value.substring(2)}";
        }
        break;
      case 4:
        _expiryDate = "${value.substring(0,2)}/${value.substring(2)}";
        break;
      default:
        break;
    }
    // if (value.length == 3) {
    //   if (value.contains("/")) {
    //     _expiryDate = value.substring(0, 2);
    //   } else {
    //     _expiryDate = "${value.substring(0,2)}/${value.substring(2)}";
    //   }
    // } else if (value.length > 5) {
    //   return;
    // } else {
    //   _expiryDate = "${value.substring(0,2)}/${value.substring(2)}";
    // }
    notifyListeners();
  }
}
