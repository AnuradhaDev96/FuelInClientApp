import 'package:cloud_firestore/cloud_firestore.dart';

class ProductionBatch {
  int? id, workshopId, createdManagerId, amount, testedAmount, passedAmount;
  DateTime? deadline, estimatedScheduledDate;

  ProductionBatch({
    this.id,
    this.workshopId,
    this.createdManagerId,
    this.amount,
    this.deadline,
    this.estimatedScheduledDate,
    this.testedAmount,
    this.passedAmount
  });

  ProductionBatch.fromMap(Map<String, dynamic> map):
        id = map["id"],
        workshopId = map["workshopId"],
        createdManagerId = map["createdManagerId"],
        deadline = DateTime.parse( map["deadline"]),
        estimatedScheduledDate = map["estimatedScheduledDate"] == null ? null : DateTime.parse(map["estimatedScheduledDate"]),
        testedAmount = map["testedAmount"],
        passedAmount = map["passedAmount"],
        amount = map["amount"];

  Map<String, dynamic> toMap(){
    return {
      'workshopId': workshopId,
      'createdManagerId': createdManagerId,
      'deadline': deadline,
      'estimatedScheduledDate': estimatedScheduledDate,
      'amount': amount,
    };
  }

  Map<String, dynamic> toUpdateMap(){
    return {
      'id': id,
      'testedAmount': testedAmount,
      'passedAmount': passedAmount,
    };
  }
}