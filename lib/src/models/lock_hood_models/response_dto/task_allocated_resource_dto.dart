class TaskAllocatedResourceDto {
  bool? isResourceAllocatedToTask, isAutomatedInventoryRequestCreated;
  int? statusCode;

  TaskAllocatedResourceDto({this.isResourceAllocatedToTask, this.isAutomatedInventoryRequestCreated, this.statusCode});

  TaskAllocatedResourceDto.fromMap(Map<String, dynamic> map):
        isResourceAllocatedToTask = map["isResourceAllocatedToTask"],
        isAutomatedInventoryRequestCreated = map["isAutomatedInventoryRequestCreated"];
}