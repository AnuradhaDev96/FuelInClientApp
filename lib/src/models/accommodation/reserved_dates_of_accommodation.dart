// SyncedReservation collection for each accommodation

import 'package:cloud_firestore/cloud_firestore.dart';

class ReservedDatesOfAccommodation {
  int reservedRoomCount;
  DocumentReference? reservationReferenceElement;

  ReservedDatesOfAccommodation({
    required this.reservedRoomCount,
    required this.reservationReferenceElement,
  });

  Map<String, dynamic> toMap(){
    return {
      'reservedRoomCount': reservedRoomCount,
      'reservationReferenceElementList': FieldValue.arrayUnion([reservationReferenceElement]),
    };
  }

  Map<String, dynamic> toMapForUpdate(){
    return {
      'reservedRoomCount': FieldValue.increment(reservedRoomCount),
      'reservationReferenceElementList': FieldValue.arrayUnion([reservationReferenceElement]),
    };
  }

  ReservedDatesOfAccommodation.fromMap(Map<String, dynamic> map) : reservedRoomCount = map["reservedRoomCount"];

  ReservedDatesOfAccommodation.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>);
}