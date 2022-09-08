import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../services/reservation_service.dart';
import '../accommodation/accommodation.dart';
import '../reservation/reservation.dart';

class ReservationNotifier extends ChangeNotifier {
  List<RoomForReservationModel>? _includedRoomsForReservationList;

  // if the list attributes are updated this value should be updated to false
  bool _isTotalCostPanelVisible = false;

  final ReservationService _reservationService = GetIt.I<ReservationService>();

  bool get isTotalCostPanelVisible => _isTotalCostPanelVisible;

  // set isTotalCostEditedAfterCalculation(bool value) {
  //   print("###vTrigeered");
  //   _isTotalCostEditedAfterCalculation = value;
  //   notifyListeners();
  // }

  void notifyTotalCostPanelVisibilityChanged({required bool visibility}) {
    print("rrrrrrrrrrrrrrigereted");
    _isTotalCostPanelVisible = visibility;
    notifyListeners();
  }

  List<RoomForReservationModel> get includedRoomsForReservationList =>
      _includedRoomsForReservationList ?? <RoomForReservationModel>[];

  void addRoomForReservationClientList(Accommodation selectedAccommodation) {
    int totalRooms = selectedAccommodation.noOfRooms ?? 0;
    int reservedRoomCount = selectedAccommodation.tempReservedRoomCountForResultSet ?? 0;
    int availableRoomCount = totalRooms - reservedRoomCount;
    _includedRoomsForReservationList ??= <RoomForReservationModel>[];

    _includedRoomsForReservationList?.add(
        RoomForReservationModel(roomName: selectedAccommodation.roomName,
          roomCountForOrder: 1,
          noOfGuests: 2,
          subTotal: selectedAccommodation.rateInLkr,
          rateInLkr: selectedAccommodation.rateInLkr,
          accommodationReference: selectedAccommodation.reference,
          availableRoomCount: availableRoomCount,
        )
    );
    notifyListeners();
  }

  void removeRoomFromReservationClientList(Accommodation selectedAccommodation) {
    _includedRoomsForReservationList ??= <RoomForReservationModel>[];

    _includedRoomsForReservationList
        ?.removeWhere((element) => element.accommodationReference == selectedAccommodation.reference);
    notifyListeners();
  }

  void updateSubTotalOfRoomByIndex(RoomForReservationModel roomForReservationModel, int index) {
    _includedRoomsForReservationList!.elementAt(index).subTotal = roomForReservationModel.subTotal;
    notifyListeners();
  }

  void updateNoOfGuestsOfRoomByIndex(RoomForReservationModel roomForReservationModel, int index) {
    _includedRoomsForReservationList!.elementAt(index).noOfGuests = roomForReservationModel.noOfGuests;
    notifyListeners();
  }

  void updateRoomCountForOrderOfRoomByIndex(RoomForReservationModel roomForReservationModel, int index) {
    _includedRoomsForReservationList!.elementAt(index).roomCountForOrder = roomForReservationModel.roomCountForOrder;
    notifyListeners();
  }

  // void calculateTotalCost() {
  //   print("rechecking a subTotal: ${_includedRoomsForReservationList?[0].subTotal}");
  //   // print("rechecking noOfGuests: ${_includedRoomsForReservationList?[1].noOfGuests}");
  //   // _reservationService
  // }

}