import 'package:matara_division_system/src/models/enums/access_request_status.dart';

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
}