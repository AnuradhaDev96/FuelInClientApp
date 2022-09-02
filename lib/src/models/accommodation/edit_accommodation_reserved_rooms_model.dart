import 'package:cloud_firestore/cloud_firestore.dart';

class EditAccommodationReservedRoomsModel {
  int reservedRoomCount;

  EditAccommodationReservedRoomsModel({required this.reservedRoomCount});

  Map<String, dynamic> toMap(){
    return {
      'reservedRoomCount': FieldValue.increment(reservedRoomCount),
    };
  }
}