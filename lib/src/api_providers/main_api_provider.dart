import 'dart:convert';

import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../config/app_settings.dart';
import '../models/authentication/authenticated_user.dart';
import '../models/authentication/fuel_in_user.dart';
import '../models/authentication/lock_hood_user.dart';
import '../models/fuel_in_models/create_driver_account.dart';
import '../models/fuel_in_models/create_fuel_station_manager_account.dart';
import '../models/fuel_in_models/fuel_order.dart';
import '../models/fuel_in_models/fuel_station.dart';
import '../models/fuel_in_models/fuel_token_request.dart';
import '../models/fuel_in_models/general_result_response.dart';
import '../models/lock_hood_models/inventory_items.dart';
import '../models/lock_hood_models/kanban_task.dart';
import '../models/lock_hood_models/production_batch.dart';
import '../models/lock_hood_models/response_dto/summary_production_batch_dto.dart';
import '../models/lock_hood_models/response_dto/summary_task_dto.dart';
import '../models/lock_hood_models/response_dto/task_allocated_resource_dto.dart';
import '../models/lock_hood_models/task_allocated_resource.dart';
import '../utils/local_storage_utils.dart';

class MainApiProvider {
  final FirebaseAuthWeb _firebaseAuthWeb = FirebaseAuthWeb.instance;

  Future<FuelInUser?> getFuelInUser(String? email) async {
    var url = Uri.parse('${AppSettings.webApiUrl}UserManagement/Users/GetUser/$email');
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

      var lockHoodUser = FuelInUser.fromMap(returnBody);
      return lockHoodUser;

    }
    return null;
  }

  Future<FuelInUser?> getPermissionsForUser() async {
    var url = Uri.parse('${AppSettings.webApiUrl}UserManagement/Users/GetUser/${_firebaseAuthWeb.currentUser!.email}');
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

      var lockHoodUser = FuelInUser.fromMap(returnBody);
      return lockHoodUser;

    }
    return null;
  }

  Future<GeneralResultResponse> registerAsDriver(CreateDriverAccount createDriverAccount) async {
    var url = Uri.parse('${AppSettings.webApiUrl}UserManagement/FuelInVehicleOwner');

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(createDriverAccount.toMap()),
    );

    GeneralResultResponse generalResultResponse = GeneralResultResponse(
        statusCode: response.statusCode, responseMessage: response.body);

    return generalResultResponse;
  }

  Future<GeneralResultResponse> registerAsFuelStationManager(CreateFuelStationManagerAccount createManagerAccount) async {
    var url = Uri.parse('${AppSettings.webApiUrl}UserManagement/FuelStationManager');

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(createManagerAccount.toMap()),
    );

    GeneralResultResponse generalResultResponse = GeneralResultResponse(
        statusCode: response.statusCode, responseMessage: response.body);

    return generalResultResponse;
  }

  Future<GeneralResultResponse> createFuelOrder(FuelOrder fuelOrder) async {
    AuthenticatedUser loggedUser = await GetIt.I<LocalStorageUtils>().hiveDbBox?.get(AppSettings.hiveKeyAuthenticatedUser, defaultValue: null);
    var url = Uri.parse('${AppSettings.webApiUrl}FuelStationManagement/FuelStation/FuelOrder/${loggedUser.userId}');
    DateTime xD = DateFormat("yyyy-MM-dd").parse(fuelOrder.expectedDeliveryDate.toString());

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(fuelOrder.toMap()),
    );

    GeneralResultResponse generalResultResponse = GeneralResultResponse(
        statusCode: response.statusCode, responseMessage: response.body);

    return generalResultResponse;
  }

  Future<GeneralResultResponse> createFuelTokenRequest(FuelTokenRequest request) async {
    AuthenticatedUser loggedUser = await GetIt.I<LocalStorageUtils>().hiveDbBox?.get(AppSettings.hiveKeyAuthenticatedUser, defaultValue: null);
    request.driverId = loggedUser.userId;
    var url = Uri.parse('${AppSettings.webApiUrl}FuelStationManagement/FuelTokenRequest');
    // DateTime xD = DateFormat("yyyy-MM-dd").parse(fuelOrder.expectedDeliveryDate.toString());

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(request.toMap()),
    );

    GeneralResultResponse generalResultResponse = GeneralResultResponse(
        statusCode: response.statusCode, responseMessage: response.body);

    return generalResultResponse;
  }

  Future<List<FuelStation>?> getAllFuelStations() async {
    var url = Uri.parse('${AppSettings.webApiUrl}FuelStationManagement/FuelStation');
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

      var list = List<FuelStation>.from(
          jsonDecode(response.body).map((it) => FuelStation.fromMap(it)));
      // var returnBody = jsonDecode(response.body);
      // var list = returnBody.
      // returnBody.map((key, value) => null)

      // var lockHoodUser = LockHoodUser.fromMap(returnBody);
      return list;

    }
    return null;
  }

  Future<List<FuelOrder>?> getAllFuelOrders() async {
    var url = Uri.parse('${AppSettings.webApiUrl}FuelStationManagement/FuelStation/FuelOrder');
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

      var list = List<FuelOrder>.from(
          jsonDecode(response.body).map((it) => FuelOrder.fromMap(it)));
      // var returnBody = jsonDecode(response.body);
      // var list = returnBody.
      // returnBody.map((key, value) => null)

      // var lockHoodUser = LockHoodUser.fromMap(returnBody);
      return list;

    }
    return null;
  }

  Future<List<FuelTokenRequest>?> getFuelTokenRequestsByDriverId() async {
    AuthenticatedUser loggedUser = await GetIt.I<LocalStorageUtils>().hiveDbBox?.get(AppSettings.hiveKeyAuthenticatedUser, defaultValue: null);

    var url = Uri.parse('${AppSettings.webApiUrl}FuelStationManagement/FuelTokenRequest/${loggedUser.userId}');
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

      var list = List<FuelTokenRequest>.from(
          jsonDecode(response.body).map((it) => FuelTokenRequest.fromMap(it)));
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

  // Report Management
  Future<SummaryTaskDto?> getNewTasksSummaryReport() async {
    var url = Uri.parse('${AppSettings.webApiUrl}ReportArena/KanBanTasksSummary/NewTasks');
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

      var summary = SummaryTaskDto.fromMap(returnBody);
      return summary;

    }
    return null;
  }

  Future<SummaryProductionBatchDto?> getProductionBatchSummaryReport() async {
    var url = Uri.parse('${AppSettings.webApiUrl}ReportArena/ProductionBatchSummary/Overview');
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

      var summary = SummaryProductionBatchDto.fromMap(returnBody);
      return summary;

    }
    return null;
  }
}