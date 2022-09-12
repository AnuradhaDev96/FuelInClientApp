import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../config/firestore_collections.dart';

import '../models/accommodation/accommodation.dart';
import '../models/accommodation/reserved_dates_of_accommodation.dart';

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

  Future<List<Accommodation>> getAccommodationsListBasedOnReservations(
      String hotelName, DateTime checkInDateToSearch) async {
    // final Stream<QuerySnapshot<Map<String, dynamic>>> result =
    // _firebaseFirestore.collection(FirestoreCollections.accommodationCollection).where('refBranch', isEqualTo: hotelName).snapshots();
    // final searchResultBehaviorSubject = BehaviorSubject<List<Accommodation>>();

    // return result;


    try {
      List<Accommodation> accommodationList = [];
      // _firebaseFirestore.runTransaction((Transaction transaction) async {
        // get all accommodations by hotelName
        final QuerySnapshot accommodationSnapshot = await _firebaseFirestore
            .collection(FirestoreCollections.accommodationCollection)
            .where('refBranch', isEqualTo: hotelName)
            .get();

        // looping the accommodation result
        for (var accommodationDocument in accommodationSnapshot.docs) {
          // going inside the ReservedDatesOfAccommodation collection and get the record for given checkInDateToSearch
          DocumentSnapshot reservedDateDoc = await accommodationDocument.reference
              .collection(FirestoreCollections.reservedDatesOfAccommodation)
              .doc(DateFormat('yyyy-MM-dd').format(checkInDateToSearch))
              .get();

          if (reservedDateDoc.exists) {
            // compare the available rooms
            ReservedDatesOfAccommodation reservedDate = ReservedDatesOfAccommodation.fromSnapshot(reservedDateDoc);
            Accommodation accommodation = Accommodation.fromSnapshot(accommodationDocument);
            if ((accommodation.noOfRooms! - reservedDate.reservedRoomCount) == 0) {
              continue;
            } else {
              // if still have any rooms return that room to search result
              // TODO: assign reserved rooms temp value to search result
              accommodation.tempReservedRoomCountForResultSet = reservedDate.reservedRoomCount;
              accommodationList.add(accommodation);
            }
          } else {
            print("######");
            accommodationList.add(Accommodation.fromSnapshot(accommodationDocument));
            print("inside loop: ${accommodationList.length}");
          }
        }
      // });
      print("tryyy: ${accommodationList.length}");
      return accommodationList;
    } catch (e) {
      print("absolute exception: $e");
      // searchResultBehaviorSubject.sink.add(accommodationList);
      return <Accommodation>[];
    }

    // return accommodationList;

  }

  Future<Accommodation?> getAccommodationByReference(DocumentReference? accommodationRef) async {
    if (accommodationRef == null) {
      return null;
    }

    DocumentSnapshot reservedDateDoc = await _firebaseFirestore
        .collection(FirestoreCollections.accommodationCollection)
        .doc(accommodationRef.id)
        .get();
    Accommodation? accommodation = Accommodation.fromSnapshot(reservedDateDoc);
    return accommodation;
  }

}