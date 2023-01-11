import 'dart:io';
import 'dart:math';

import 'package:intl/intl.dart';


import '../config/app_settings.dart';
import '../models/enums/kanban_status.dart';
import '../models/lock_hood_models/response_dto/summary_production_batch_dto.dart';
import '../models/lock_hood_models/response_dto/summary_task_dto.dart';

// import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:html' as html;

import 'pdf_file_manager.dart';

class GenerateKanBanTaskReportsService {
  static Future<File> generateTaskSummaryReport(SummaryTaskDto summaryData, String fileName) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
        build: (context) => [
              _buildTitle(summaryData),
            ]));

    final randomIndex = Random().nextInt(1000);
    return PdfFileManager.saveDocument(name: "$fileName-$randomIndex", pdf: pdf);
  }

  static Future<html.AnchorElement> generateTaskSummaryReportAndWeView(
      SummaryTaskDto summaryData, String fileName) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
        build: (context) => [
              _buildHeading(summaryData),
              SizedBox(height: PdfPageFormat.cm * 1.2),
              Text(
                "Report Created Date: ${DateFormat('yyyy-MM-dd').format(summaryData.reportDate?.subtract(const Duration(days: 5)) ?? DateTime.now().subtract(const Duration(days: 5)))}",
                style: const TextStyle(
                  fontSize: 9.0,
                ),
              ),
              _buildTitle(summaryData),
              SizedBox(height: PdfPageFormat.cm * 0.9),
              _buildTaskTable(summaryData),
              SizedBox(height: PdfPageFormat.cm * 1.2),
              _buildFooter(summaryData),
            ]));

    final randomIndex = Random().nextInt(1000);
    return PdfFileManager.webViewDocument(name: "$fileName-$randomIndex", pdf: pdf);
  }

  static Widget _buildTitle(SummaryTaskDto summaryData) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          summaryData.reportName ?? "N/A",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: PdfPageFormat.cm * 0.2),
        Text(
          summaryData.description ?? "N/A",
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
      ]);

  static Widget _buildTaskTable(SummaryTaskDto summaryData) {
    final headerRaw = [
      "Task Id",
      "Task Name",
      "Expected Product Count",
      "Task Status",
      "Production Batch Id",
      "Assignee Id",
    ];
    
    final tableData = summaryData.kanBanTaskResult?.map((item) {
      return [
        "${item.id}",
        "${item.name}",
        "${item.expectedAmount}",
        "${AppSettings.getKanBanTaskStatusEnumValueForInteger(item.status).toDisplayString()}",
        "${item.batchId}",
        "${item.labourerId}",
      ];
    }).toList();

    if (tableData == null) {
      return Text(
        "No data found",
        style: const TextStyle(
          fontSize: 12.0,
        ),
      );
    } else {
      return Table.fromTextArray(headers: headerRaw, data: tableData);
    }

  }

  static Widget _buildHeading(SummaryTaskDto summaryData) =>
      Center(
        child: Text(
          summaryData.reportHeading ?? "N/A",
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  static Widget _buildFooter(SummaryTaskDto summaryData) =>
      Center(
        child: Text(
          summaryData.reportFooter ?? "N/A",
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}

class GenerateProductionBatchReportsService {
  // static Future<File> generateProductionSummaryReport(SummaryTaskDto summaryData, String fileName) async {
  //   final pdf = Document();
  //
  //   pdf.addPage(MultiPage(
  //       build: (context) => [
  //             _buildTitle(summaryData),
  //           ]));
  //
  //   final randomIndex = Random().nextInt(1000);
  //   return PdfFileManager.saveDocument(name: "$fileName-$randomIndex", pdf: pdf);
  // }

  static Future<html.AnchorElement> generateProductionSummaryReportAndWeView(
      SummaryProductionBatchDto summaryData, String fileName) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
        build: (context) => [
              _buildHeading(summaryData),
              SizedBox(height: PdfPageFormat.cm * 1.2),
              Text(
                "Report Created Date: ${DateFormat('yyyy-MM-dd').format(summaryData.reportDate?.subtract(const Duration(days: 5)) ?? DateTime.now().subtract(const Duration(days: 5)))}",
                style: const TextStyle(
                  fontSize: 9.0,
                ),
              ),
              _buildTitle(summaryData),
              SizedBox(height: PdfPageFormat.cm * 0.9),
              _buildTaskTable(summaryData),
              SizedBox(height: PdfPageFormat.cm * 1.2),
              _buildFooter(summaryData),
            ]));

    final randomIndex = Random().nextInt(1000);
    return PdfFileManager.webViewDocument(name: "$fileName-$randomIndex", pdf: pdf);
  }

  static Widget _buildTitle(SummaryProductionBatchDto summaryData) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          summaryData.reportName ?? "N/A",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: PdfPageFormat.cm * 0.2),
        Text(
          summaryData.description ?? "N/A",
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
      ]);

  static Widget _buildTaskTable(SummaryProductionBatchDto summaryData) {
    final headerRaw = [
      "Batch Id",
      "Product Count",
      "Original Deadline",
      "Scheduled Deadline",
      "Tested Products",
      "Good Products",
      "Failed Products",
      "Remaining Products"
    ];

    final tableData = summaryData.productionBatchResult?.map((item) {
      int tested = item.testedAmount ?? 0;
      int passed = item.passedAmount ?? 0;
      int requirement = item.amount ?? 0;
      return [
        "${item.id}",
        "${item.amount}",
        item.deadline == null ? "N/A" : DateFormat('yyyy-MM-dd').format(item.deadline!),
        item.estimatedScheduledDate == null ? "N/A" : DateFormat('yyyy-MM-dd').format(item.estimatedScheduledDate!),
        "${item.testedAmount}",
        "${item.passedAmount}",
        "${tested - passed}",
        "${requirement - passed}",
      ];
    }).toList();

    if (tableData == null) {
      return Text(
        "No data found",
        style: const TextStyle(
          fontSize: 12.0,
        ),
      );
    } else {
      return Table.fromTextArray(headers: headerRaw, data: tableData);
    }

  }

  static Widget _buildHeading(SummaryProductionBatchDto summaryData) =>
      Center(
        child: Text(
          summaryData.reportHeading ?? "N/A",
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  static Widget _buildFooter(SummaryProductionBatchDto summaryData) =>
      Center(
        child: Text(
          summaryData.reportFooter ?? "N/A",
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );


}
