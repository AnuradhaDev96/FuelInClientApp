import 'package:flutter/material.dart';
import '../authentication/system_user.dart';

class RoleManagementNotifier extends ChangeNotifier {
  final PageController _pageController = PageController(initialPage: 0);
  SystemUser? _selectedUserForPermissions;

  PageController get pageController => _pageController;
  SystemUser? get selectedUserForPermissions => _selectedUserForPermissions;

  void setSelectedUserForPermissions(SystemUser systemUser) {
    _selectedUserForPermissions = systemUser;
    notifyListeners();
  }

  void drainSelectedUserForPermissions() {
    _selectedUserForPermissions = null;
    notifyListeners();
  }

  void jumpToNextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(duration: const Duration(milliseconds: 1200), curve: Curves.fastOutSlowIn);
    }
  }

  void jumpToPreviousPage() {
    if (_pageController.hasClients) {
      _pageController
          .previousPage(duration: const Duration(milliseconds: 1200), curve: Curves.fastOutSlowIn)
          .whenComplete(() => drainSelectedUserForPermissions());
    }
  }
}