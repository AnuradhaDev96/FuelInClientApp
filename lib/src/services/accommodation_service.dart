import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rh_reader/src/config/firestore_collections.dart';

import '../models/accommodation/accommodation.dart';

class AccommodationService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> registerAccommodation(Accommodation accommodationModel) async {
    try{
      _firebaseFirestore.runTransaction((Transaction transaction) async {
        await _firebaseFirestore
            .collection(FirestoreCollections.accommodationCollection)
            .doc()
            .set(accommodationModel.toMap());
      });
      return true;
    } catch(e){
      return false;
    }
  }

  Future<bool> updateAccommodation(Accommodation accommodationModel) async {
    try{
      _firebaseFirestore.runTransaction(
              (Transaction transaction) async {
            transaction.update(accommodationModel.reference!, accommodationModel.toMap());
          }
      );
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> deleteAccommodation(Accommodation accommodationModel) async {
    try{
      _firebaseFirestore.runTransaction((Transaction transaction) async {
        transaction.delete(accommodationModel.reference!);
      });
      return true;
    } catch(e){
      return false;
    }
  }

  Future<List<Accommodation>> getAccommodationsList() async{
    final QuerySnapshot result =
    await _firebaseFirestore.collection(FirestoreCollections.accommodationCollection).get();

    final List<DocumentSnapshot> documents = result.docs;

    if (documents.isNotEmpty) {
      List<Accommodation> accommodationList = [];
      for (var element in documents) {
        accommodationList.add(Accommodation.fromSnapshot(element));
      }
      return accommodationList;
    } else {
      return <Accommodation>[];
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAccommodationsStream() {
    final Stream<QuerySnapshot<Map<String, dynamic>>> result =
    _firebaseFirestore.collection(FirestoreCollections.accommodationCollection).snapshots();
    return result;
  }

}