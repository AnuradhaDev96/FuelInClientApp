import 'package:hive/hive.dart';

part 'user_types.g.dart';

@HiveType(typeId: 1)
enum UserTypes {
  @HiveField(0)
  systemAdmin,
  @HiveField(1)
  fuelStationManager,
  @HiveField(2)
  fuelStationAuditManager,
  @HiveField(3)
  driver,
  @HiveField(4)
  headOfficeManager,
}

extension ToString on UserTypes {
  String toDisplaySinhalaString() {
    switch (this) {
      case UserTypes.systemAdmin:
        return "moaO;s m%OdkS"; //පද්ධති ප්‍රධානී
      case UserTypes.fuelStationManager:
        return "wdik ixúOdhl"; //ආසන සංවිධායක
      default:
        return "jHdc ;k;=rla"; //ව්‍යාජ තනතුරක්
    }
  }

  String? toDBValue() {
    switch (this) {
      case UserTypes.systemAdmin:
        return "SystemAdmin"; //පද්ධති ප්‍රධානී
      case UserTypes.fuelStationManager:
        return "FuelStationManager"; //ආසන සංවිධායක
      default:
        return null;
    }
  }

}

extension ToInteger on UserTypes {
  int toIntegerValue() {
    switch (this) {
      case UserTypes.systemAdmin:
        return 0;
      case UserTypes.fuelStationManager:
        return 1;
      case UserTypes.fuelStationAuditManager:
        return 2;
      case UserTypes.driver:
        return 3;
      case UserTypes.headOfficeManager:
        return 4;
      default:
        return -1;
    }
  }
}
