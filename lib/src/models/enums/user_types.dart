import 'package:hive/hive.dart';

part '../hive_generated/user_types.g.dart';

@HiveType(typeId: 1)
enum UserTypes {
  @HiveField(0)
  systemAdmin,
  @HiveField(1)
  seatOrganizer
}

extension ToString on UserTypes {
  String toDisplaySinhalaString() {
    switch (this) {
      case UserTypes.systemAdmin:
        return "moaO;s m%OdkS"; //පද්ධති ප්‍රධානී
      case UserTypes.seatOrganizer:
        return "wdik ixúOdhl"; //ආසන සංවිධායක
    }
  }

  String toDBValue() {
    switch (this) {
      case UserTypes.systemAdmin:
        return "sys_admin"; //පද්ධති ප්‍රධානී
      case UserTypes.seatOrganizer:
        return "seat_organizer"; //ආසන සංවිධායක
    }
  }

}
