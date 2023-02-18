class GeneralResultResponse {
  String? responseMessage;
  int? statusCode;

  GeneralResultResponse({this.responseMessage, this.statusCode});

  // GeneralResultResponse.fromMap(Map<String, dynamic> map):
  //       responseMessage = map["isResourceAllocatedToTask"],
  //       isAutomatedInventoryRequestCreated = map["isAutomatedInventoryRequestCreated"];
}