import 'dart:convert';

import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:http/http.dart' as http;

import '../config/app_settings.dart';
import '../models/authentication/lock_hood_user.dart';
import '../models/lock_hood_models/inventory_items.dart';
import '../models/lock_hood_models/kanban_task.dart';

class MainApiProvider {
  final FirebaseAuthWeb _firebaseAuthWeb = FirebaseAuthWeb.instance;

  Future<LockHoodUser?> getLockHoodUser(String? email) async {
    var url = Uri.parse('${AppSettings.webApiUrl}HumanResource/Employees/GetUser/$email');
    // var url1;
    print(url);
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Accept': '*/*'
      },
    );
    if (response.statusCode == 200) {
      var returnBody = jsonDecode(response.body);

      var lockHoodUser = LockHoodUser.fromMap(returnBody);
      return lockHoodUser;

    }
    return null;
  }

  Future<LockHoodUser?> getPermissionsForUser() async {
    var url = Uri.parse('${AppSettings.webApiUrl}HumanResource/Employees/GetUser/${_firebaseAuthWeb.currentUser!.email}');
    // var url1;
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Accept': '*/*'
      },
    );
    if (response.statusCode == 200) {
      var returnBody = jsonDecode(response.body);

      var lockHoodUser = LockHoodUser.fromMap(returnBody);
      return lockHoodUser;

    }
    return null;
  }

  Future<List<InventoryItems>?> getAllInventoryItems() async {
    var url = Uri.parse('${AppSettings.webApiUrl}Inventory/items');
    // var url1;
    print(url);
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Accept': '*/*'
      },
    );
    if (response.statusCode == 200) {

      var list = List<InventoryItems>.from(
          jsonDecode(response.body).map((it) => InventoryItems.fromMap(it)));
      // var returnBody = jsonDecode(response.body);
      // var list = returnBody.
      // returnBody.map((key, value) => null)

      // var lockHoodUser = LockHoodUser.fromMap(returnBody);
      return list;

    }
    return null;
  }

  Future<List<KanBanTask>?> getAllKanBanTasks() async {
    var url = Uri.parse('${AppSettings.webApiUrl}HumanResource/KanBanTasks/all');

    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Accept': '*/*'
      },
    );
    if (response.statusCode == 200) {

      var list = List<KanBanTask>.from(
          jsonDecode(response.body).map((it) => KanBanTask.fromMap(it)));
      // var returnBody = jsonDecode(response.body);
      // var list = returnBody.
      // returnBody.map((key, value) => null)

      // var lockHoodUser = LockHoodUser.fromMap(returnBody);
      return list;

    }
    return null;
  }
}