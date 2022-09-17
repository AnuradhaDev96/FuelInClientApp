import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/models/authentication/authenticated_user.dart';
import 'package:matara_division_system/src/models/authentication/request_access_model.dart';
import 'package:matara_division_system/src/models/enums/access_request_status.dart';
import 'package:matara_division_system/src/utils/common_utils.dart';
import 'package:matara_division_system/src/utils/local_storage_utils.dart';
import '../../firebase_options.dart';
import '../config/firestore_collections.dart';

import '../models/authentication/password_login_result.dart';
import '../models/authentication/system_user.dart';
import '../models/change_notifiers/application_auth_notifier.dart';
import '../models/enums/user_types.dart';
class AuthService {
  final FirebaseAuthWeb _firebaseAuthWeb = FirebaseAuthWeb.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  Future<AuthenticatedUser?> passwordLogin(String username, String password) async {
    // if (kIsWeb) {
    //   _firebaseAuthWeb.setPersistence(Persistence.NONE);
    // }
    await _firebaseAuthWeb.setPersistence(Persistence.INDEXED_DB);

    final loggedUser = await _firebaseAuthWeb.signInWithEmailAndPassword("anusampath9470@gmail.com", "admin_z123");
    // final loggedUser = await _firebaseAuthWeb.signInWithEmailAndPassword(username, password);
    print(loggedUser);

    final QuerySnapshot result = await _firebaseFirestore
      .collection(FirestoreCollections.userCollection)
      .where('email', isEqualTo: loggedUser.user?.email)
      .limit(1)
      .get();

    final List<DocumentSnapshot> documents = result.docs;
    AuthenticatedUser? authenticatedUser;

    if (documents.length == 1) {
      SystemUser element = SystemUser.fromSnapshot(documents[0]);

      if (element.type == UserTypes.systemAdmin.toDBValue()) {
        authenticatedUser = AuthenticatedUser(
            displayName: element.fullName ?? "",
            email: loggedUser.user?.email ?? "",
            token: loggedUser.credential?.token ?? 0,
            userType: UserTypes.systemAdmin,
        );

      } else if (element.type == UserTypes.seatOrganizer.toDBValue()) {
        authenticatedUser = AuthenticatedUser(
            displayName: element.fullName ?? "",
            email: loggedUser.user?.email ?? "",
            token: loggedUser.credential?.token ?? 0,
            userType: UserTypes.seatOrganizer);
      } else {
        throw Exception("Invalid user type.");
      }

    } else {
      throw Exception("User cannot be found in db.");
    }
    return authenticatedUser;
  }

  Future<void> signOutUser() async {
    _firebaseAuthWeb.signOut();
  }

  Future<void> acceptAccessRequestByAdmin(RequestAccessModel requestAccessModel, String password) async {
    var result = await _firebaseAuthWeb.createUserWithEmailAndPassword(requestAccessModel.email, password);
    // print("###createUserResponse: ${result.credential}");
    // print("###createUserResponse: ${result.user}");
    // print("###createUserResponse: ${result.additionalUserInfo}");
    if (result.user != null) {

      // save created user details user collection
      SystemUser systemUser = SystemUser(
        fullName: requestAccessModel.fullName,
        email: requestAccessModel.email,
        encPassword: CommonUtils.getPasswordOnSave(password),
        type: requestAccessModel.userType?.toDBValue(),
        uid: result.user!.uid,
      );
      await _firebaseFirestore
          .collection(FirestoreCollections.userCollection)
          .doc()
          .set(systemUser.toMap());

      //update the access request collection with uid, and approved status
      requestAccessModel.uidOfCreatedUser = result.user!.uid;
      requestAccessModel.accessRequestStatus = AccessRequestStatus.approved;
      requestAccessModel.lastUpdatedDate = DateTime.now();
      final reqDocumentRef =
      _firebaseFirestore.collection(FirestoreCollections.accessRequestsCollection).doc(requestAccessModel.email);
      await reqDocumentRef.update(requestAccessModel.toMap()).then((value) async {
        //send verification email to accepted user after updating request model
        await result.user?.sendEmailVerification(DefaultFirebaseOptions.actionCodeSettings);
      });
    } else {
      throw Exception("User is null");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersForAdminStream() {
    final Stream<QuerySnapshot<Map<String, dynamic>>> result =
    _firebaseFirestore.collection(FirestoreCollections.userCollection).snapshots();
    // print("##showaccessL: ${result.length}");
    return result;
  }


  //# region Access Requests
  Stream<QuerySnapshot<Map<String, dynamic>>> getRequestAccessForAdminStream() {
    final Stream<QuerySnapshot<Map<String, dynamic>>> result =
    _firebaseFirestore.collection(FirestoreCollections.accessRequestsCollection).snapshots();
    print("##showaccessL: ${result.length}");
    return result;
  }

  Future<bool> saveAccessRequestByAnonymous(RequestAccessModel requestAccessModel) async {
    // bool status;
    try {

      // final QuerySnapshot result =
      // await _firebaseFirestore.collection(FirestoreCollections.accessRequestsCollection).get();
      requestAccessModel.requestedDate = DateTime.now();
      requestAccessModel.lastUpdatedDate = DateTime.now();

      final reqDocumentRef =
          _firebaseFirestore.collection(FirestoreCollections.accessRequestsCollection).doc(requestAccessModel.email);

      bool x = await reqDocumentRef
          .set(requestAccessModel.toMap()).then(
              (value) {
            print("you are in succes req");
            return true;
          },
          onError: (e) {
            print("####errorzz: $e");
            return false;
          });
      // print("REQUESTSUCESS");
      return x;
    } catch(e){
      print("REQUESTdENIEWS:  $e");
      return false;
    }
  }


  //# end region Access Requests

  // getSingleMall() async{
  //   final QuerySnapshot result =
  //       await _firebaseFirestore.collection(FirestoreCollections.userCollection).where('email', isEqualTo: email).limit(1).get();
  //   print(result);
  //   // return result;
  // }
}