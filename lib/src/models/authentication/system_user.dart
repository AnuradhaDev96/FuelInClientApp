import 'package:cloud_firestore/cloud_firestore.dart';

class SystemUser {
  String? fullName;
  String? email;
  String? type;
  String? encPassword;
  // String profileImageUrl;
  String? uid;
  DocumentReference? reference;
  List<String>? authPermissions;

  SystemUser({this.fullName, this.email, this.type, this.encPassword, this.uid, this.reference, this.authPermissions});

  SystemUser.fromMap(Map<String, dynamic> map, {required this.reference}):
    fullName = map["fullName"],
    email = map["email"],
    type = map["type"],
    encPassword = map["encPassword"],
    authPermissions = map["authPermissions"] == null ? null : List<String>.from(map["authPermissions"].map((it) => it)),
    uid = map["uid"];

  Map<String, dynamic> toMap(){
    return {
      'fullName': fullName,
      'email': email,
      'encPassword': encPassword,
      'type': type,
      'uid': uid,
      'authPermissions': authPermissions?.map((e) => e).toList()
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