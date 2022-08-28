class Reservation {
  String hotelName, checkIn, checkOut, roomId, refUserID, roomName;
  int noOfRooms, noOfGuests;

  Reservation({
    required this.refUserID,
    required this.hotelName,
    required this.checkIn,
    required this.checkOut,
    required this.roomId,
    required this.roomName,
    required this.noOfRooms,
    required this.noOfGuests,
  });
}