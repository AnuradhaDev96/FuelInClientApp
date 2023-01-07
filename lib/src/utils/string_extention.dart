import '../models/enums/access_request_status.dart';
import '../models/enums/user_types.dart';

extension IsNumericExtention on String {
  bool get isInteger {
    return int.tryParse(this) != null;
  }

  bool get isDouble {
    return double.tryParse(this) != null;
  }
}

extension StringToEnum on String {
  // AccessRequestStatus enum
  AccessRequestStatus get requestStatusEnumValue {
    switch(this) {
      case "Pending":
        return AccessRequestStatus.pendingApproval;
      case "Approved":
        return AccessRequestStatus.approved;
      case "Declined":
        return AccessRequestStatus.declined;
      default:
        return AccessRequestStatus.pendingApproval;
    }
  }

  UserTypes? get authUserTypeEnumValue {
    switch (this) {
      case "sys_admin":
        return UserTypes.systemAdmin;
      case "seat_organizer":
        return UserTypes.topLevel;
      default:
        return null;
    }
  }
}