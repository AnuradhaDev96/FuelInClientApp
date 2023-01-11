import 'package:matara_division_system/src/models/lock_hood_models/kanban_task.dart';

import '../production_batch.dart';

class SummaryProductionBatchDto {
  String? reportName, description, reportHeading, reportFooter;
  DateTime? reportDate;
  List<ProductionBatch>? productionBatchResult;

  SummaryProductionBatchDto(
      {this.reportName, this.reportHeading, this.reportFooter, this.reportDate, this.description, this.productionBatchResult,});

  SummaryProductionBatchDto.fromMap(Map<String, dynamic> map):
        reportName = map["reportName"],
        reportHeading = map["reportHeading"],
        reportFooter = map["reportFooter"],
        reportDate = DateTime.parse(map["reportDate"]),
        productionBatchResult =  List<ProductionBatch>.from(map["productionBatchResult"].map((it) => ProductionBatch.fromMap(it))),
        description = map["description"];
}