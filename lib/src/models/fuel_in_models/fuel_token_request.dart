import 'package:intl/intl.dart';

import '../../config/app_settings.dart';
import '../enums/purchase_fuel_type.dart';

class FuelTokenRequest {
  int? id, requestedQuotaInLitres, fuelStationId, driverId, fuelOrderId;
  String? token;
  PurchaseFuelType? requestedFuelType;
  DateTime? scheduledFillingDate, tolerenceUntil, paymentDoneOn, fuelCollectedOn;
  // FuelStation? fuelStation;

  FuelTokenRequest({
    this.id,
    this.requestedQuotaInLitres,
    this.fuelStationId,
    this.driverId,
    this.fuelOrderId,
    this.token,
    this.requestedFuelType,
    this.scheduledFillingDate,
    this.tolerenceUntil,
    this.paymentDoneOn,
    this.fuelCollectedOn,
  });

  FuelTokenRequest.fromMap(Map<String, dynamic> map):
        id = map["id"],
        requestedQuotaInLitres = map["requestedQuotaInLitres"],
        fuelStationId = map["fuelStationId"],
        driverId = map["driverId"],
        fuelOrderId = map["fuelOrderId"],
        token = map["token"],
        scheduledFillingDate = DateTime.parse(map["scheduledFillingDate"]),
        tolerenceUntil = DateTime.parse(map["tolerenceUntil"]),
        paymentDoneOn = DateTime.parse(map["paymentDoneOn"]),
        fuelCollectedOn = DateTime.parse(map["fuelCollectedOn"]),
        requestedFuelType = AppSettings.getEnumValueForPurchaseFuelTypeString(map["requestedFuelType"]);

  Map<String, dynamic> toMap(){
    return {
      'token': token,
      'requestedQuotaInLitres': requestedQuotaInLitres,
      'fuelStationId': fuelStationId,
      'driverId': driverId,
      'scheduledFillingDate': scheduledFillingDate == null ? null : DateFormat('yyyy-MM-dd').format(scheduledFillingDate!),
      'requestedFuelType': requestedFuelType == null ? PurchaseFuelType.petrol92.toDTOString() : requestedFuelType?.toDTOString(),
    };

  }
}