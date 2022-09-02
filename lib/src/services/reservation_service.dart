import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:rh_reader/src/models/change_notifiers/reservation_notifier.dart';

import '../config/firestore_collections.dart';
import '../models/accommodation/edit_accommodation_reserved_rooms_model.dart';
import '../models/reservation/reservation.dart';

class ReservationService {
  // final ReservationNotifier _reservationNotifier = GetIt.I<ReservationNotifier>();
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

  Future<bool> createReservationByCustomer(Reservation reservation) async {
    //UPDATE ACCOMMODATION TABLE
    //accommodationReference
    //checkIn
    //roomName
    //update reserved count

    try{
      _firebaseFirestore.runTransaction((Transaction transaction) async {
        await _firebaseFirestore
            .collection(FirestoreCollections.generalReservationCollection)
            .doc()
            .set(reservation.toMap());

        reservation.includedRooms!.forEach((roomForReservation) async {
          // element.
          EditAccommodationReservedRoomsModel updateModel =  EditAccommodationReservedRoomsModel(reservedRoomCount: roomForReservation.roomCountForOrder!);
          var accommodationRef = _firebaseFirestore.collection(FirestoreCollections.accommodationCollection).doc(roomForReservation.accommodationReference!.id);
          // await transaction.update(roomForReservation.accommodationReference!, data)
          accommodationRef.update(updateModel.toMap());
        });
      });
      return true;
    } catch(e){
      return false;
    }
  }
}