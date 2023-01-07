import '../enums/user_types.dart';

class LockHoodUser {
  int? id;
  String? fullName;
  String? email;
  // String? type;
  String? encPassword;
  String? jobRole;
  String? phoneNumber;
  int? managementType;


  LockHoodUser({this.fullName, this.email, this.encPassword, this.id, this.jobRole, this.phoneNumber,this.managementType,});

  LockHoodUser.fromMap(Map<String, dynamic> map):
        id = map["id"],
        fullName = map["fullName"],
        email = map["email"],
        encPassword = map["password"],
        jobRole = map["jobRole"],
        managementType = map["managementType"],
        phoneNumber = map["phoneNumber"];

  Map<String, dynamic> toMap(){
    return {
      'fullName': fullName,
      'email': email,
      'password': encPassword,
      'jobRole': jobRole,
      'phoneNumber': phoneNumber,
      'managementType': managementType,
    };
  }
}