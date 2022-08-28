import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  String? fullName;
  String? salary;
  String? designation;
  // String profileImageUrl;
  DocumentReference? reference;

  EmployeeModel({this.fullName, this.salary, this.designation, this.reference});

  EmployeeModel.fromMap(Map<String, dynamic> map, {required this.reference}):
        fullName = map["fullName"],
        salary = map["salary"],
        designation = map["designation"];

  Map<String, dynamic> toMap(){
    return {
      'fullName': fullName,
      'salary': salary,
      'designation': designation,
    };

  }

  EmployeeModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

// toJson(){
//   return {
//     'fullName': fullName,
//     'email': email,
//     'password': password,
//     'type': type,
//     'profileImageUrl': profileImageUrl
//   };
// }
}