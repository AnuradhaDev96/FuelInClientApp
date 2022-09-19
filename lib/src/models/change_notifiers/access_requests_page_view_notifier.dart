import 'package:flutter/material.dart';
import 'package:matara_division_system/src/models/authentication/request_access_model.dart';

class AccessRequestsPageViewNotifier extends ChangeNotifier {
  final PageController _pageController = PageController(initialPage: 0);
  RequestAccessModel? _requestAccessModelToBeSaved;

  PageController get pageController => _pageController;
  RequestAccessModel? get requestAccessModelToBeSaved => _requestAccessModelToBeSaved;

  void setSelectedRequestAccess(RequestAccessModel requestAccessModel) {
    _requestAccessModelToBeSaved = requestAccessModel;
    notifyListeners();
  }

  void drainSelectedRequestAccess() {
    _requestAccessModelToBeSaved = null;
    notifyListeners();
  }

  void jumpToNextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(duration: const Duration(milliseconds: 1200), curve: Curves.fastOutSlowIn);
    }
  }

  void jumpToPreviousPage() {
    if (_pageController.hasClients) {
      _pageController.previousPage(duration: const Duration(milliseconds: 1200), curve: Curves.fastOutSlowIn);
    }
  }

}