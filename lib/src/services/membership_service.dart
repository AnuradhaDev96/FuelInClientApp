import 'package:cloud_firestore/cloud_firestore.dart';

import '../config/firestore_collections.dart';
import '../models/membership/membership_model.dart';

class MembershipService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// Get divisional secretariats stream
  Stream<QuerySnapshot<Map<String, dynamic>>> getDivisionalSecretariatsStream(String divisionalSecretariatId, String gramaNiladariDivisionId) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> result =
    _firebaseFirestore
        .collection(FirestoreCollections.divisionalSecretariatsCollection)
        .doc(divisionalSecretariatId)
        .collection(FirestoreCollections.gramaNiladariDivisionsCollection)
        .doc(gramaNiladariDivisionId)
        .collection(FirestoreCollections.membershipCollection)
        .snapshots();

    return result;
  }

  Future<bool> createMembershipRecord(MembershipModel membershipModel) async {
    membershipModel.createdDate = DateTime.now();

    DocumentSnapshot documentSnapshot = await _firebaseFirestore
        .collection(FirestoreCollections.divisionalSecretariatsCollection)
        .doc(membershipModel.divisionalSecretariatId)
        .collection(FirestoreCollections.gramaNiladariDivisionsCollection)
        .doc(membershipModel.gramaNiladariDivisionId)
        .collection(FirestoreCollections.membershipCollection)
        .doc(membershipModel.nicNumber)
        .get();

    if (!documentSnapshot.exists) {
      bool success = false;
      await _firebaseFirestore
          .collection(FirestoreCollections.divisionalSecretariatsCollection)
          .doc(membershipModel.divisionalSecretariatId)
          .collection(FirestoreCollections.gramaNiladariDivisionsCollection)
          .doc(membershipModel.gramaNiladariDivisionId)
          .collection(FirestoreCollections.membershipCollection)
          .doc(membershipModel.nicNumber)
          .set(membershipModel.toMap())
          .then((value) => success = true, onError: (e) => success = false);
      return success;
    } else {
      return false;
    }
  }
}