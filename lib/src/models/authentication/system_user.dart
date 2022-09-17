import 'package:cloud_firestore/cloud_firestore.dart';

class SystemUser {
  String? fullName;
  String? email;
  String? type;
  String? encPassword;
  // String profileImageUrl;
  String? uid;
  DocumentReference? reference;

  SystemUser({this.fullName, this.email, this.type, this.encPassword, this.uid, this.reference});

  SystemUser.fromMap(Map<String, dynamic> map, {required this.reference}):
    fullName = map["fullName"],
    email = map["email"],
    type = map["userType"],
    encPassword = map["encPassword"],
    uid = map["uid"];

  Map<String, dynamic> toMap(){
    return {
      'fullName': fullName,
      'email': email,
      'encPassword': encPassword,
      'type': type,
      'uid': uid,
      // 'profileImageUrl': profileImageUrl
    };
  }

  SystemUser.fromSnapshot(DocumentSnapshot snapshot)
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