import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matara_division_system/src/models/administrative_units/divisional_secretariats.dart';
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

  /// Get grama niladiri divisions stream
  Stream<QuerySnapshot<Map<String, dynamic>>> getGramaNiladiriDivisionsStream(String divisionalSecretariatId) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> result =
    _firebaseFirestore
        .collection(FirestoreCollections.divisionalSecretariatsCollection)
        .doc(divisionalSecretariatId)
        .collection(FirestoreCollections.gramaNiladariDivisionsCollection)
        .snapshots();

    return result;
  }

  Future<bool> createDivisionalSecretariatRecord(DivisionalSecretariats divisionalSecretariat) async {
    DocumentSnapshot documentSnapshot = await _firebaseFirestore
        .collection(FirestoreCollections.divisionalSecretariatsCollection)
        .doc(divisionalSecretariat.id)
        .get();

    if (!documentSnapshot.exists) {
      bool success = false;
      await _firebaseFirestore
          .collection(FirestoreCollections.divisionalSecretariatsCollection)
          .doc(divisionalSecretariat.id)
          .set(divisionalSecretariat.toMap())
          .then((value) => success = true, onError: (e) => success = false);
      return success;
    } else {
      return false;
    }
  }

  Future<bool> deleteDivisionalSecretariatRecord(DivisionalSecretariats divisionalSecretariat) async {
    DocumentSnapshot documentSnapshot = await _firebaseFirestore
        .collection(FirestoreCollections.divisionalSecretariatsCollection)
        .doc(divisionalSecretariat.id)
        .get();

    if (documentSnapshot.exists) {
      bool success = false;
      await _firebaseFirestore
          .collection(FirestoreCollections.divisionalSecretariatsCollection)
          .doc(divisionalSecretariat.id)
          .delete()
          .then((value) => success = true, onError: (e) => success = false);
      return success;
    } else {
      return false;
    }
  }

  Future<bool> createGramaNiladariDivisionRecord(String divisionalSecretariatId, GramaNiladariDivisions gramaNiladariDivision) async {
    DocumentSnapshot documentSnapshot = await _firebaseFirestore
        .collection(FirestoreCollections.divisionalSecretariatsCollection)
        .doc(divisionalSecretariatId)
        .collection(FirestoreCollections.gramaNiladariDivisionsCollection)
        .doc(gramaNiladariDivision.id)
        .get();

    if (!documentSnapshot.exists) {
      bool success = false;
      await _firebaseFirestore
          .collection(FirestoreCollections.divisionalSecretariatsCollection)
          .doc(divisionalSecretariatId)
          .collection(FirestoreCollections.gramaNiladariDivisionsCollection)
          .doc(gramaNiladariDivision.id)
          .set(gramaNiladariDivision.toMap())
          .then((value) => success = true, onError: (e) => success = false);
      return success;
    } else {
      return false;
    }
  }

  Future<bool> deleteGramaNiladariDivisionRecord(String divisionalSecretariatId, GramaNiladariDivisions gramaNiladariDivision) async {
    DocumentSnapshot documentSnapshot = await _firebaseFirestore
        .collection(FirestoreCollections.divisionalSecretariatsCollection)
        .doc(divisionalSecretariatId)
        .collection(FirestoreCollections.gramaNiladariDivisionsCollection)
        .doc(gramaNiladariDivision.id)
        .get();

    if (documentSnapshot.exists) {
      bool success = false;
      await _firebaseFirestore
          .collection(FirestoreCollections.divisionalSecretariatsCollection)
          .doc(divisionalSecretariatId)
          .collection(FirestoreCollections.gramaNiladariDivisionsCollection)
          .doc(gramaNiladariDivision.id)
          .delete()
          .then((value) => success = true, onError: (e) => success = false);
      return success;
    } else {
      return false;
    }
  }

}