import 'package:hive/hive.dart';

part 'user_types.g.dart';

@HiveType(typeId: 1)
enum UserTypes {
  @HiveField(0)
  systemAdmin,
  @HiveField(1)
  topLevel,
  @HiveField(2)
  middleLevel,
  @HiveField(3)
  lowLevel,
  @HiveField(4)
  labourer,
}

extension ToString on UserTypes {
  String toDisplaySinhalaString() {
    switch (this) {
      case UserTypes.systemAdmin:
        return "moaO;s m%OdkS"; //පද්ධති ප්‍රධානී
      case UserTypes.topLevel:
        return "wdik ixúOdhl"; //ආසන සංවිධායක
      default:
        return "jHdc ;k;=rla"; //ව්‍යාජ තනතුරක්
    }
  }

  String? toDBValue() {
    switch (this) {
      case UserTypes.systemAdmin:
        return "sys_admin"; //පද්ධති ප්‍රධානී
      case UserTypes.topLevel:
        return "seat_organizer"; //ආසන සංවිධායක
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
      case UserTypes.topLevel:
        return 1;
      case UserTypes.middleLevel:
        return 2;
      case UserTypes.lowLevel:
        return 3;
      case UserTypes.labourer:
        return 4;
      default:
        return -1;
    }
  }
}
