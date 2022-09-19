import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/accommodation/reserved_dates_of_accommodation.dart';
import '../models/reservation/reservation_suit.dart';

import '../config/firestore_collections.dart';
import '../models/reservation/reservation.dart';

class ReservationService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  double calculateSubTotalForSelectedRoom(RoomForReservationModel roomForReservationModel) {
    if (roomForReservationModel.roomCountForOrder != null && roomForReservationModel.rateInLkr != null) {
      return roomForReservationModel.roomCountForOrder! * roomForReservationModel.rateInLkr!;
    }
    return 0;
  }

  int calculateNoOfNightsForReservation(DateTime checkIn, DateTime checkOut) {
    return checkOut.difference(checkIn).inDays;
  }

  double calculateTotalCostOfOrder(DateTime checkInDate, DateTime checkoutDate, List<RoomForReservationModel> selectedRoomList) {
    double totalCost = 0;
    selectedRoomList.forEach((element) {
      totalCost += calculateSubTotalForSelectedRoom(element);
    });
    totalCost = totalCost * calculateNoOfNightsForReservation(checkInDate, checkoutDate);
    return totalCost;
  }

  int calculateTotalRoomsForReservation(List<RoomForReservationModel> selectedRoomList) {
    int totalRooms = 0;
    selectedRoomList.forEach((element) {
      totalRooms += element.roomCountForOrder ?? 0;
    });

    return totalRooms;
  }

  int calculateTotalGuestsForReservation(List<RoomForReservationModel> selectedRoomList) {
    int totalGuests = 0;
    selectedRoomList.forEach((element) {
      totalGuests += element.noOfGuests ?? 0;
    });

    return totalGuests;
  }

  /// Create a reservation and update the accommodation table's reservedRoomCount
  /// for each room included in the reservation
  /// Adds new collection to accommodation record with checking and staying dates
  Future<bool> createReservationByCustomer(Reservation reservation) async {
    //UPDATE ACCOMMODATION TABLE
    //accommodationReference
    //checkIn
    //roomName
    //update reserved count

    try{
      _firebaseFirestore.runTransaction((Transaction transaction) async {
        // await _firebaseFirestore
        //     .collection(FirestoreCollections.generalReservationCollection)
        //     .doc()
        //     .set(reservation.toMap());

        DocumentReference? referenceOfCreatedReservation;
        await _firebaseFirestore
            .collection(FirestoreCollections.divisionalSecretariatsCollection)
            .add(reservation.toMap()).then((createdReference) => referenceOfCreatedReservation = createdReference);

        // increment reserved room count of each included room and
        reservation.includedRooms!.forEach((roomForReservation) async {
          // element.
          final dateForAccommodationRef = _firebaseFirestore
              .collection(FirestoreCollections.accommodationCollection)
              .doc(roomForReservation.accommodationReference!.id)
              .collection(FirestoreCollections.reservedDatesOfAccommodation)
              .doc(DateFormat('yyyy-MM-dd').format(reservation.checkIn!));

          DocumentSnapshot doc = await dateForAccommodationRef.get();

          ReservedDatesOfAccommodation reservedDatesOfAccommodation = ReservedDatesOfAccommodation(
              reservedRoomCount: roomForReservation.roomCountForOrder!,
              reservationReferenceElement: referenceOfCreatedReservation);

          // check whether the room has reservations for given check in date
          if (!doc.exists) {
            // if there are not any reservations yet, creates new reservation date for room
            await _firebaseFirestore
                .collection(FirestoreCollections.accommodationCollection)
                .doc(roomForReservation.accommodationReference!.id)
                .collection(FirestoreCollections.reservedDatesOfAccommodation)
                .doc(DateFormat('yyyy-MM-dd').format(reservation.checkIn!))
                .set(reservedDatesOfAccommodation.toMap());
          } else {
            // if already has date then updates the room count and reservation refs
            dateForAccommodationRef.update(reservedDatesOfAccommodation.toMapForUpdate());
          }

          //EditAccommodationReservedRoomsModel updateModel =  EditAccommodationReservedRoomsModel(reservedRoomCount: roomForReservation.roomCountForOrder!);
          //var accommodationRef = _firebaseFirestore.collection(FirestoreCollections.accommodationCollection).doc(roomForReservation.accommodationReference!.id);
          // ignore: await transaction.update(roomForReservation.accommodationReference!, data)

          // accommodationRef.update(updateModel.toMap());
        });
      });
      return true;
    } catch(e){
      return false;
    }
  }

  Future<bool> createReservationSuitByCustomer(ReservationSuit reservationSuit) async {
    try{
      _firebaseFirestore.runTransaction((Transaction transaction) async {
        await _firebaseFirestore
            .collection(FirestoreCollections.reservationSuitReservationCollection)
            .doc()
            .set(reservationSuit.toMap());
      });
      return true;
    } catch(e){
      return false;
    }
  }

  // get generat reservation stream
  Stream<QuerySnapshot<Map<String, dynamic>>> getGeneralReservationsStream() {
    final Stream<QuerySnapshot<Map<String, dynamic>>> result =
    _firebaseFirestore.collection(FirestoreCollections.divisionalSecretariatsCollection).snapshots();
    return result;
  }
}