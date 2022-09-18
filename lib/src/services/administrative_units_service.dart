import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matara_division_system/src/models/administrative_units/grama_niladari_divisions.dart';

import '../config/firestore_collections.dart';

class AdministrativeUnitsService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// Get divisional secretariats stream
  Stream<QuerySnapshot<Map<String, dynamic>>> getDivisionalSecretariatsStream() {
    final Stream<QuerySnapshot<Map<String, dynamic>>> result =
    _firebaseFirestore.collection(FirestoreCollections.divisionalSecretariatsCollection).snapshots();

    return result;
  }

  /// Get grama niladiri divisions list
  Future<List<GramaNiladariDivisions>> getGramaNiladiriDivisionsList(String divisionalSecretariatId) async {
    final QuerySnapshot result = await _firebaseFirestore
        .collection(FirestoreCollections.divisionalSecretariatsCollection)
        .doc(divisionalSecretariatId)
        .collection(FirestoreCollections.gramaNiladariDivisionsCollection)
        .get();

    final List<DocumentSnapshot> documents = result.docs;
    // print("####servicedoc count: ${documents.length}");

    if (documents.isNotEmpty) {
      List<GramaNiladariDivisions> gramaNiladariDivList = [];
      for (var element in documents) {
        gramaNiladariDivList.add(GramaNiladariDivisions.fromSnapshot(element));
      }
      print("####servicedoc count: ${gramaNiladariDivList.length}");
      return gramaNiladariDivList;
    } else {
      return <GramaNiladariDivisions>[];
    }
  }
}