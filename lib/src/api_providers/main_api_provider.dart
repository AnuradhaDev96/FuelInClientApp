import 'dart:convert';

import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:http/http.dart' as http;

import '../config/app_settings.dart';
import '../models/authentication/lock_hood_user.dart';
import '../models/lock_hood_models/inventory_items.dart';
import '../models/lock_hood_models/kanban_task.dart';
import '../models/lock_hood_models/production_batch.dart';
import '../models/lock_hood_models/response_dto/task_allocated_resource_dto.dart';
import '../models/lock_hood_models/task_allocated_resource.dart';

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

  Future<List<InventoryItems>?> getInventoryItemsByProductBatchId(int batchId) async {
    var url = Uri.parse('${AppSettings.webApiUrl}HumanResource/KanBanTasks/InventoryItemsByBatch/$batchId');
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

  Future<List<TaskAllocatedResource>?> getAllocatedResourcesByTaskId(int taskId) async {
    var url = Uri.parse('${AppSettings.webApiUrl}HumanResource/KanBanTasks/AllocateResource/$taskId');
    print(url);
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Accept': '*/*'
      },
    );
    print("###code: ${response.statusCode}");
    if (response.statusCode == 200) {
      print("###suceses");
      var list = List<TaskAllocatedResource>.from(
          jsonDecode(response.body).map((it) => TaskAllocatedResource.fromMap(it)));
      // var returnBody = jsonDecode(response.body);
      // var list = returnBody.
      // returnBody.map((key, value) => null)

      // var lockHoodUser = LockHoodUser.fromMap(returnBody);
      print("####arCount: ${list.length}");
      return list;

    }
    return null;
  }

  Future<TaskAllocatedResourceDto> createAllocatedResourceForTask(TaskAllocatedResource data) async{
    var url = Uri.parse('${AppSettings.webApiUrl}HumanResource/KanBanTasks/AllocateResource');

    var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data.toMap()),
    );

    if (response.statusCode == 200) {

      // var list = List<KanBanTask>.from(
      //     jsonDecode(response.body).map((it) => KanBanTask.fromMap(it)));
      var returnBody = jsonDecode(response.body);
      // var list = returnBody.
      // returnBody.map((key, value) => null)
      var taskAllocatedResourceDto = TaskAllocatedResourceDto.fromMap(returnBody);
      taskAllocatedResourceDto.statusCode = response.statusCode;

      return taskAllocatedResourceDto;

    }

    TaskAllocatedResourceDto errorResponse = TaskAllocatedResourceDto(statusCode: response.statusCode);
    return errorResponse;
  }

  Future<bool> updateTestInformationOfProductionBatch(ProductionBatch data) async{
    var url = Uri.parse('${AppSettings.webApiUrl}HumanResource/ProductionBatches/UpdateTestInformation');

    var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data.toUpdateMap()),
    );

    if (response.statusCode == 204) {

      // var list = List<KanBanTask>.from(
      //     jsonDecode(response.body).map((it) => KanBanTask.fromMap(it)));
      // var returnBody = jsonDecode(response.body);
      // var list = returnBody.
      // returnBody.map((key, value) => null)
      // var taskAllocatedResourceDto = TaskAllocatedResourceDto.fromMap(returnBody);
      // taskAllocatedResourceDto.statusCode = response.statusCode;

      return true;

    }
    return false;
  }

  Future<bool> scheduleNewDateBasedOnOEEForProductionBatch(int batchId) async{
    var url = Uri.parse('${AppSettings.webApiUrl}HumanResource/ProductionBatches/ScheduleNewDateBasedOnOEE/$batchId');

    var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
        },
    );

    if (response.statusCode == 204) {

      // var list = List<KanBanTask>.from(
      //     jsonDecode(response.body).map((it) => KanBanTask.fromMap(it)));
      // var returnBody = jsonDecode(response.body);
      // var list = returnBody.
      // returnBody.map((key, value) => null)
      // var taskAllocatedResourceDto = TaskAllocatedResourceDto.fromMap(returnBody);
      // taskAllocatedResourceDto.statusCode = response.statusCode;

      return true;

    }
    return false;
  }

  Future<List<ProductionBatch>?> getAllProductionBatches() async {
    var url = Uri.parse('${AppSettings.webApiUrl}HumanResource/ProductionBatches');
    // var url1;
    print(url);
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Accept': '*/*'
      },
    );
    print("##prodB: ${response.statusCode}");
    if (response.statusCode == 200) {

      var list = List<ProductionBatch>.from(
          jsonDecode(response.body).map((it) => ProductionBatch.fromMap(it)));
      print(list[0].toMap());
      return list;

    }
    return null;
  }
}