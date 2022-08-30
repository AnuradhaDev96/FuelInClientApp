class Reservation {
  String hotelName, checkIn, checkOut, refUserID;
  double? totalCostInLkr;
  List<RoomForReservationModel>? includedRooms;

  Reservation({
    required this.refUserID,
    required this.hotelName,
    required this.checkIn,
    required this.checkOut,
    this.includedRooms,
    this.totalCostInLkr,
  });
}

class RoomForReservationModel {
  String? roomName;
  int? roomCountForOrder, noOfGuests;
  double? subTotal, rateInLkr;

  RoomForReservationModel({
    required this.roomName,
    required this.roomCountForOrder,
    required this.noOfGuests,
    required this.subTotal,
    required this.rateInLkr,
  });
}