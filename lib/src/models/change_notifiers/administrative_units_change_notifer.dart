import 'package:flutter/material.dart';

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

}