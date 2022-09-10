import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  String hotelName;
  String? customerName;
  String? customerEmail;
  List<RoomForReservationModel>? includedRooms;
  DateTime? checkIn, checkOut;
  int? noOfNightsReserved, totalRooms, totalGuests;
  double? totalCostOfReservation;
  DocumentReference? reference;

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
      // 'includedRooms': includedRooms?.map((e) => e.toMap()).toList(),
    };
  }

  Reservation.fromMap(Map<String, dynamic> map, {required this.reference}):
        hotelName = map["hotelName"],
        customerName = map["customerName"],
        customerEmail = map["customerEmail"],
        checkIn = map["checkIn"] == null ? null : (map["checkIn"] as Timestamp).toDate(),
        checkOut = map["checkOut"] == null ? null : (map["checkOut"] as Timestamp).toDate(),
        noOfNightsReserved = map["noOfNightsReserved"],
        totalRooms = map["totalRooms"],
        totalGuests = map["totalGuests"],
        totalCostOfReservation = map["totalCostOfReservation"],
        includedRooms = map["includedRooms"] == null
            ? null
            : List<RoomForReservationModel>.from(map["includedRooms"].map((it) => RoomForReservationModel.fromMap(it)));

  Reservation.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);
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

  RoomForReservationModel.fromMap(Map<String, dynamic> map):
    roomName = map["roomName"],
    roomCountForOrder = map["roomCountForOrder"],
    noOfGuests = map["noOfGuests"],
    subTotal = map["subTotal"],
    rateInLkr = map["rateInLkr"],
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