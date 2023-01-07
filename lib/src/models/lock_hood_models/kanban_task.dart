class KanBanTask {
  int? id, expectedAmount, batchId, labourerId;
  String? name;
  int? status;

  KanBanTask({this.id, this.expectedAmount, this.batchId, this.labourerId, this.status, this.name});

  KanBanTask.fromMap(Map<String, dynamic> map):
        id = map["id"],
        expectedAmount = map["expectedAmount"],
        batchId = map["batchId"],
        labourerId = map["labourerId"],
        status = map["status"],
        name = map["name"];

  Map<String, dynamic> toMap(){
    return {
      'expectedAmount': expectedAmount,
      'batchId': batchId,
      'labourerId': labourerId,
      'status': status,
      'name': name,
    };
  }
}