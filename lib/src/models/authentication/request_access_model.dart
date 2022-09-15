import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/app_settings.dart';
import '../enums/user_types.dart';

class RequestAccessModel {
  String fullName, email;
  int waPhoneNumber;

  /// If userType is null during fromMap() display an error
  UserTypes? userType;

  DocumentReference? reference;

  RequestAccessModel({
    required this.fullName,
    required this.email,
    required this.waPhoneNumber,
    required this.userType,
  });

  Map<String, dynamic> toMap(){
    return {
      'fullName': fullName,
      'email': email,
      'waPhoneNumber': waPhoneNumber,
      'userType': userType?.toDBValue(),
    };
  }

  RequestAccessModel.fromMap(Map<String, dynamic> map, {required this.reference}):
        fullName = map["fullName"],
        email = map["email"],
        waPhoneNumber = map["waPhoneNumber"],
        userType = AppSettings.getEnumValueFromEnglishValue(map["userType"]);

  RequestAccessModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

}
