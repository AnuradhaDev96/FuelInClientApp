import 'package:matara_division_system/src/models/lock_hood_models/kanban_task.dart';

class SummaryTaskDto {
  String? reportName, description, reportHeading, reportFooter;
  DateTime? reportDate;
  List<KanBanTask>? kanBanTaskResult;

  SummaryTaskDto(
      {this.reportName, this.reportHeading, this.reportFooter, this.reportDate, this.description, this.kanBanTaskResult,});

  SummaryTaskDto.fromMap(Map<String, dynamic> map):
        reportName = map["reportName"],
        reportHeading = map["reportHeading"],
        reportFooter = map["reportFooter"],
        reportDate = DateTime.parse(map["reportDate"]),
        kanBanTaskResult =  List<KanBanTask>.from(map["kanBanTaskResult"].map((it) => KanBanTask.fromMap(it))),
        description = map["description"];
}