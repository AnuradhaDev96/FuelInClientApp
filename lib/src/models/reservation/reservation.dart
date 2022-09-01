import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  String hotelName, refUserID;
  double? totalCostInLkr;
  List<RoomForReservationModel>? includedRooms;
  //TODO: add field to calculate total based on checkin and checkout
  DateTime? checkIn, checkOut;
  int? noOfNightsReserved;
  double? totalCostOfReservation;

  Reservation({
    required this.refUserID,
    required this.hotelName,
    required this.checkIn,
    required this.checkOut,
    this.includedRooms,
    this.totalCostInLkr,
    this.noOfNightsReserved,
    this.totalCostOfReservation,
  });
}

class RoomForReservationModel {
  String? roomName;
  int? roomCountForOrder, noOfGuests;
  double? subTotal, rateInLkr;
  DocumentReference? accommodationReference;
  DocumentReference? reference;
  int? availableRoomCount;

  RoomForReservationModel({
    required this.roomName,
    required this.roomCountForOrder,
    required this.noOfGuests,
    required this.subTotal,
    required this.rateInLkr,
    required this.accommodationReference,
    this.reference,
    this.availableRoomCount,
  });

  RoomForReservationModel.fromMap(Map<String, dynamic> map, {required this.reference}):
    roomName = map["roomName"],
    roomCountForOrder = map["roomCountForOrder"],
    noOfGuests = map["noOfGuests"],
    subTotal = map["subTotal"],
    rateInLkr = map["refBranch"],
    accommodationReference = map["accommodationReference"];

  Map<String, dynamic> toMap(){
    return {
      'roomName': roomName,
      'roomCountForOrder': roomCountForOrder,
      'noOfGuests': noOfGuests,
      'subTotal': subTotal,
      'rateInLkr': rateInLkr,
      'accommodationReference': accommodationReference,
    };
  }

  RoomForReservationModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);
}