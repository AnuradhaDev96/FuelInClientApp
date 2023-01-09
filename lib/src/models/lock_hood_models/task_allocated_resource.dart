class TaskAllocatedResource {
  int? id, inventoryItemId, kanBanTaskId;
  double? allocatedAmount;

  TaskAllocatedResource({this.id, this.inventoryItemId, this.kanBanTaskId, this.allocatedAmount,});

  TaskAllocatedResource.fromMap(Map<String, dynamic> map):
        id = map["id"],
        inventoryItemId = map["inventoryItemId"],
        kanBanTaskId = map["kanBanTaskId"],
        allocatedAmount = map["allocatedAmount"];

  Map<String, dynamic> toMap(){
    return {
      'inventoryItemId': inventoryItemId,
      'kanBanTaskId': kanBanTaskId,
      'allocatedAmount': allocatedAmount,
    };
  }
}