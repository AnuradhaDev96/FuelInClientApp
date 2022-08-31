import '../models/reservation/reservation.dart';

class ReservationService {
  double calculateSubTotalForSelectedRoom(RoomForReservationModel roomForReservationModel) {
    if (roomForReservationModel.roomCountForOrder != null && roomForReservationModel.rateInLkr != null) {
      return roomForReservationModel.roomCountForOrder! * roomForReservationModel.rateInLkr!;
    }
    return 0;
  }
}