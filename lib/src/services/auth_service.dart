import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rh_reader/src/config/firestore_collections.dart';

import '../models/authentication/password_login_result.dart';
import '../models/authentication/system_user.dart';
class AuthService {
  final FirebaseAuthWeb _firebaseAuthWeb = FirebaseAuthWeb.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  Future<PasswordLoginResult?> passwordLogin(String username, String password) async {
      final loggedUser = await _firebaseAuthWeb.signInWithEmailAndPassword("anuradhashs@gmail.com", "admin_z");
      print(loggedUser);

      PasswordLoginResult passwordLoginResult = PasswordLoginResult(
        displayName: loggedUser.user?.displayName,
        email: loggedUser.user?.email,
        token: loggedUser.credential?.token,
      );

      final QuerySnapshot result = await _firebaseFirestore
        .collection(FirestoreCollections.userCollection)
        .where('email', isEqualTo: passwordLoginResult.email)
        .limit(1)
        .get();

    final List<DocumentSnapshot> documents = result.docs;

      if (documents.length == 1){
        SystemUser element = SystemUser.fromSnapshot(documents[0]);
        passwordLoginResult.type = element.type;
        print(passwordLoginResult.type);
      }else{
        //return null if the user is not in the firestore
        throw Exception("User cannot be found in db.");
      }
      return passwordLoginResult;
  }

  // getSingleMall() async{
  //   final QuerySnapshot result =
  //       await _firebaseFirestore.collection(FirestoreCollections.userCollection).where('email', isEqualTo: email).limit(1).get();
  //   print(result);
  //   // return result;
  // }
}