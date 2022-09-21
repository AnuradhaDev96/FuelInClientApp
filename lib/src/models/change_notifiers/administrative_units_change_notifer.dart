import 'package:flutter/material.dart';
import 'package:matara_division_system/src/models/administrative_units/divisional_secretariats.dart';
import 'package:matara_division_system/src/models/administrative_units/grama_niladari_divisions.dart';

import '../membership/membership_model.dart';

class AdministrativeUnitsChangeNotifier extends ChangeNotifier {
  List<bool> _expansionPanelExpandStatusList = <bool>[];

  List<bool> get expansionPanelExpandStatusList => _expansionPanelExpandStatusList;

  void addValueToList(bool value) {
    _expansionPanelExpandStatusList.add(value);
    print("Build is called and length of list is ${_expansionPanelExpandStatusList.length}");
    notifyListeners();
  }

  void setValueByIndex(int index, bool value) {
    _expansionPanelExpandStatusList[index] = value;
    print("#### changeVal: ${_expansionPanelExpandStatusList[index]} || ${_expansionPanelExpandStatusList.length}");
    notifyListeners();
  }

  void drainList() {
    _expansionPanelExpandStatusList.clear();
    notifyListeners();
  }

  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  //administrative unit details
  // MembershipModel? _membershipModelToBeSaved;
  DivisionalSecretariats? _paramDivisionalSecretariat;
  GramaNiladariDivisions? _paramGramaNiladariDivision;

  // MembershipModel? get membershipModelToBeSaved => _membershipModelToBeSaved;
  DivisionalSecretariats? get paramDivisionalSecretariat => _paramDivisionalSecretariat;
  GramaNiladariDivisions? get paramGramaNiladariDivision => _paramGramaNiladariDivision;

  // void setSelectedMembershipModel(MembershipModel requestAccessModel) {
  //   _membershipModelToBeSaved = requestAccessModel;
  //   notifyListeners();
  // }

  // void drainSelectedMembershipModel() {
  //   _membershipModelToBeSaved = null;
  //   notifyListeners();
  // }

  void setSelectedAdministrativeUnits(DivisionalSecretariats divisionalSecretariat, GramaNiladariDivisions gramaNiladariDivision) {
    _paramDivisionalSecretariat = divisionalSecretariat;
    _paramGramaNiladariDivision = gramaNiladariDivision;
    notifyListeners();
  }

  void drainSelectedAdministrativeUnits() {
    _paramDivisionalSecretariat = null;
    _paramGramaNiladariDivision = null;
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
          .whenComplete(() => drainSelectedAdministrativeUnits());
    }
  }
}