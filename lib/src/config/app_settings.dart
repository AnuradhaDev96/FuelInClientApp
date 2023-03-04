import '../models/enums/fuel_order_status.dart';
import '../models/enums/kanban_status.dart';
import '../models/enums/purchase_fuel_type.dart';
import '../models/enums/user_types.dart';

class AppSettings {
  static const String authHiveBox = "authHiveBox";
  static const String hiveKeyAppIsAuthenticated = "keyAppIsAuthenticated";
  static const String hiveKeyAuthenticatedUser = "keyAuthenticatedUser";
  static const String debugWebUrl = "http://localhost:3404/#/";
  static const String prodWebUrl = "https://nppmataradivision.web.app/";

  static const String webApiUrl = "https://localhost:7175/api/";

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
        return UserTypes.fuelStationManager;
      default:
        return UserTypes.fuelStationManager;
    }
  }

  static UserTypes? getEnumValueForUserTypeString(String? value) {
    switch(value) {
      case "SystemAdmin":
        return UserTypes.systemAdmin;
      case "FuelStationManager":
        return UserTypes.fuelStationManager;
      case "FuelStationAuditManager":
        return UserTypes.fuelStationAuditManager;
      case "Driver":
        return UserTypes.driver;
      case "HeadOfficeManager":
        return UserTypes.headOfficeManager;
      default:
        return null;
    }
  }

  static UserTypes getManagementLevelEnumValueForInteger(int? value) {
    switch (value) {
      case 0: return UserTypes.systemAdmin;
      case 1: return UserTypes.fuelStationManager;
      case 2: return UserTypes.fuelStationAuditManager;
      case 3: return UserTypes.driver;
      case 4: return UserTypes.headOfficeManager;
      default: return UserTypes.headOfficeManager;
    }
  }

  static KanBanStatus getKanBanTaskStatusEnumValueForInteger(int? value) {
    switch (value) {
      case 0: return KanBanStatus.newTask;
      case 1: return KanBanStatus.inProgress;
      case 2: return KanBanStatus.onHold;
      case 3: return KanBanStatus.completed;
      default: return KanBanStatus.newTask;
    }
  }

  static PurchaseFuelType? getEnumValueForPurchaseFuelTypeString(String value) {
    switch (value) {
      case "Petrol92": return PurchaseFuelType.petrol92;
      case "Petrol95": return PurchaseFuelType.petrol95;
      case "AutoDiesel": return PurchaseFuelType.autoDiesel;
      case "SuperDiesel": return PurchaseFuelType.superDiesel;
      default: return null;
    }
  }

  static FuelOrderStatus? getEnumValueForFuelOrderStatusString(String value) {
    switch (value) {
      case "PaymentDone": return FuelOrderStatus.paymentDone;
      case "DeliveryConfirmed": return FuelOrderStatus.deliveryConfirmed;
      default: return null;
    }
  }
}