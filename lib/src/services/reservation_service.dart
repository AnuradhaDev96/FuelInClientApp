import 'package:get_it/get_it.dart';
import 'package:rh_reader/src/models/change_notifier/reservation_notifier.dart';

import '../models/reservation/reservation.dart';

class ReservationService {
  // final ReservationNotifier _reservationNotifier = GetIt.I<ReservationNotifier>();
  
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
}