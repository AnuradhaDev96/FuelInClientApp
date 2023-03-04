import 'dart:math';

import 'package:intl/intl.dart';

import '../../config/app_settings.dart';
import '../enums/fuel_order_status.dart';
import '../enums/purchase_fuel_type.dart';
import 'fuel_station.dart';

class FuelOrder {
  int? id, orderQuantityInLitres, fuelStationId;
  FuelOrderStatus? orderStatus;
  PurchaseFuelType? fuelType;
  DateTime? expectedDeliveryDate;
  FuelStation? fuelStation;

  FuelOrder(
      {this.id, this.orderQuantityInLitres, this.orderStatus, this.fuelType, this.expectedDeliveryDate, this.fuelStation, this.fuelStationId});

  FuelOrder.fromMap(Map<String, dynamic> map):
        id = map["id"],
        orderQuantityInLitres = map["orderQuantityInLitres"],
        fuelStationId = map["fuelStationId"],
        expectedDeliveryDate = DateTime.parse(map["expectedDeliveryDate"]),
        orderStatus = AppSettings.getEnumValueForFuelOrderStatusString(map["orderStatus"]),
        fuelType = AppSettings.getEnumValueForPurchaseFuelTypeString(map["fuelType"]),
        fuelStation = FuelStation.fromMap(map["fuelStation"]);

  Map<String, dynamic> toMap(){
    return {
      'orderQuantityInLitres': orderQuantityInLitres,
      'expectedDeliveryDate': expectedDeliveryDate == null ? null : DateFormat('yyyy-MM-dd').format(expectedDeliveryDate!),
      'orderStatus': orderStatus == null ? FuelOrderStatus.paymentDone.toDTOString() : orderStatus?.toDTOString(),
      'fuelType': fuelType == null ? PurchaseFuelType.petrol92.toDTOString() : fuelType?.toDTOString(),
    };

  }
}