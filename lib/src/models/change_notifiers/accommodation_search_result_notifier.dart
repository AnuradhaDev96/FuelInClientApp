import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../services/accommodation_service.dart';
import '../accommodation/accommodation.dart';

class AccommodationSearchResultNotifier extends ChangeNotifier {
  final AccommodationService _accommodationService = GetIt.I<AccommodationService>();

  // rxdart object
  final _searchResultBehaviorSubject = BehaviorSubject<List<Accommodation>?>();

  // stream
  Stream<List<Accommodation>?> get searchResultStream => _searchResultBehaviorSubject.stream;

  // properties
  List<Accommodation>? get searchResults => _searchResultBehaviorSubject.value;

  @override
  void dispose() {
    _searchResultBehaviorSubject.close();
    super.dispose();
  }


  Stream<List<Accommodation>?> getAccommodationsBasedOnReservationsStream() {
    return searchResultStream;
    // notifyListeners();
  }

  Future<void> retrieveAccommodationsBasedOnReservations(String hotelName, DateTime checkInDateToSearch) async {
    //List<Accommodation>? accommodationSearchList =
    await _accommodationService
        .getAccommodationsListBasedOnReservations(hotelName, checkInDateToSearch)
        .then((accommodationSearchList) => _searchResultBehaviorSubject.sink.add(accommodationSearchList));
    // notifyListeners();
  }


}