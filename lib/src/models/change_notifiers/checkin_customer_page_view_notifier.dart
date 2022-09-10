import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../reservation/reservation.dart';

class CheckInCustomerPageViewNotifier extends ChangeNotifier {
  final PageController _pageController = PageController(initialPage: 0);
  Reservation? _reservationToBeCheckedIn;

  PageController get pageController => _pageController;

  Reservation? get reservationToBeCheckIn => _reservationToBeCheckedIn;

  void setSelectedReservation(Reservation reservation) {
    _reservationToBeCheckedIn = reservation;
    notifyListeners();
  }

  void drainSelected() {
    _reservationToBeCheckedIn = null;
    notifyListeners();
  }

  void jumpToNextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(duration: const Duration(milliseconds: 700), curve: Curves.easeInCirc);
    }
  }

  void jumpToPreviousPage() {
    if (_pageController.hasClients) {
      _pageController.previousPage(duration: const Duration(milliseconds: 700), curve: Curves.easeInCirc);
    }
  }
}