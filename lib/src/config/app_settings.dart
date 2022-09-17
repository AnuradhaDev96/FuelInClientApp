import '../models/enums/user_types.dart';

class AppSettings {
  static const String authHiveBox = "authHiveBox";
  static const String hiveKeyAppIsAuthenticated = "keyAppIsAuthenticated";
  static const String hiveKeyAuthenticatedUser = "keyAuthenticatedUser";
  static const String debugWebUrl = "http://localhost:3404/#/";
  static const String prodWebUrl = "https://nppmataradivision.web.app/";

  static List<String> getSinhalaValuesOfUserTypes() {
    // var us = UserTypes.values.map((type) => type.toString()).toList();
    // print("######${us.length}");
    return UserTypes.values.map((type) => type.toDisplaySinhalaString()).toList();
  }

  static UserTypes getEnumValueFromSinhalaValue(String value) {
    switch(value) {
      case "moaO;s m%OdkS":
        return UserTypes.systemAdmin;
      case "wdik ixúOdhl":
        return UserTypes.seatOrganizer;
      default:
        return UserTypes.seatOrganizer;
    }
  }

  static UserTypes? getEnumValueFromEnglishValue(String? value) {
    switch(value) {
      case "sys_admin":
        return UserTypes.systemAdmin;
      case "seat_organizer":
        return UserTypes.seatOrganizer;
      default:
        return null;
    }
  }
}