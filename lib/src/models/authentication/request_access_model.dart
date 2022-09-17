import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matara_division_system/src/utils/string_extention.dart';

import '../../config/app_settings.dart';
import '../enums/access_request_status.dart';
import '../enums/user_types.dart';

class RequestAccessModel {
  String fullName, email;
  int waPhoneNumber;
  AccessRequestStatus? accessRequestStatus;
  DateTime? requestedDate;
  DateTime? lastUpdatedDate;

  /// When a user is created for this request the uid is assigned to this.
  /// [accessRequestStatus] should only be [AccessRequestStatus.approved]
  String? uidOfCreatedUser;


  /// If userType is null during fromMap() display an error
  UserTypes? userType;

  // DocumentReference? reference;

  RequestAccessModel({
    required this.fullName,
    required this.email,
    required this.waPhoneNumber,
    required this.userType,
    this.accessRequestStatus = AccessRequestStatus.pendingApproval,
    this.requestedDate,
    this.lastUpdatedDate,
    this.uidOfCreatedUser
  });

  Map<String, dynamic> toMap(){
    return {
      'fullName': fullName,
      'email': email,
      'waPhoneNumber': waPhoneNumber,
      'userType': userType?.toDBValue(),
      'accessRequestStatus': accessRequestStatus?.toDbValue(),
      'requestedDate': requestedDate,
      'lastUpdatedDate': lastUpdatedDate,
      'uidOfCreatedUser': uidOfCreatedUser,
    };
  }

  RequestAccessModel.fromMap(Map<String, dynamic> map, {required this.email}):
        fullName = map["fullName"],
        waPhoneNumber = map["waPhoneNumber"],
        userType = AppSettings.getEnumValueFromEnglishValue(map["userType"]),
        accessRequestStatus = map["accessRequestStatus"] == null
            ? AccessRequestStatus.pendingApproval
            : (map["accessRequestStatus"] as String).requestStatusEnumValue,
        requestedDate = map["requestedDate"] == null ? null : (map["requestedDate"] as Timestamp).toDate(),
        lastUpdatedDate = map["lastUpdatedDate"] == null ? null : (map["lastUpdatedDate"] as Timestamp).toDate(),
        uidOfCreatedUser = map["uidOfCreatedUser"];


      RequestAccessModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, email: snapshot.id);

}
