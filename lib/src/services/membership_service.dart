import 'package:cloud_firestore/cloud_firestore.dart';

import '../config/firestore_collections.dart';

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
}