import '../models/enums/user_types.dart';

class AppSettings {
  static const String authHiveBox = "authHiveBox";
  static const String hiveKeyAppIsAuthenticated = "keyAppIsAuthenticated";
  static const String hiveKeyAuthenticatedUser = "keyAuthenticatedUser";
  static const String debugWebUrl = "http://localhost:3404/#/";
  static const String prodWebUrl = "https://nppmataradivision.web.app/";

  static const String webApiUrl = "https://localhost:7277/api/";

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
        return UserTypes.topLevel;
      default:
        return UserTypes.topLevel;
    }
  }

  static UserTypes? getEnumValueFromEnglishValue(String? value) {
    switch(value) {
      case "sys_admin":
        return UserTypes.systemAdmin;
      case "seat_organizer":
        return UserTypes.topLevel;
      default:
        return null;
    }
  }

  static UserTypes getManagementLevelEnumValueForInteger(int? value) {
    switch (value) {
      case 0: return UserTypes.systemAdmin;
      case 1: return UserTypes.topLevel;
      case 2: return UserTypes.middleLevel;
      case 3: return UserTypes.lowLevel;
      case 4: return UserTypes.labourer;
      default: return UserTypes.labourer;
    }
  }
}