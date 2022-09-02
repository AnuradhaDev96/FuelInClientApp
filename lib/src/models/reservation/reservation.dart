import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  String hotelName;
  String? customerName;
  String? customerEmail;
  List<RoomForReservationModel>? includedRooms;
  DateTime? checkIn, checkOut;
  int? noOfNightsReserved, totalRooms, totalGuests;
  double? totalCostOfReservation;

  Reservation({
    this.customerName,
    required this.hotelName,
    required this.checkIn,
    required this.checkOut,
    this.includedRooms,
    this.noOfNightsReserved,
    this.totalCostOfReservation,
    this.totalRooms,
    this.totalGuests,
    this.customerEmail,
  });

  Map<String, dynamic> toMap(){
    List<Map<String, dynamic>> includedRoomsMappedList = [];
    includedRooms?.forEach((element) {
      includedRoomsMappedList.add(element.toMap());
    });
    return {
      'customerName': customerName,
      'customerEmail': customerEmail,
      'hotelName': hotelName,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'noOfNightsReserved': noOfNightsReserved,
      'totalRooms': totalRooms,
      'totalGuests': totalGuests,
      'totalCostOfReservation': totalCostOfReservation,
      'includedRooms': includedRoomsMappedList,
    };
  }
}

class RoomForReservationModel {
  String? roomName;
  int? roomCountForOrder, noOfGuests;
  double? subTotal, rateInLkr;
  DocumentReference? accommodationReference;
  // DocumentReference? reference;
  int? availableRoomCount;

  RoomForReservationModel({
    required this.roomName,
    required this.roomCountForOrder,
    required this.noOfGuests,
    required this.subTotal,
    required this.rateInLkr,
    required this.accommodationReference,
    this.availableRoomCount,
  });

  RoomForReservationModel.fromMap(Map<String, dynamic> map,):
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
      : this.fromMap(snapshot.data() as Map<String, dynamic>);
}