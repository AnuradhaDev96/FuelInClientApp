import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../../../api_providers/main_api_provider.dart';
import '../../../config/app_colors.dart';
import '../../../config/assets.dart';
import '../../../services/pdf_generator_service.dart';
import '../../../utils/message_utils.dart';

class ReportingArenaMenuPage extends StatelessWidget {
  const ReportingArenaMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 38.0,
          child: Material(
            // elevation: 3.0,
            clipBehavior: Clip.hardEdge,
            color: AppColors.darkPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 15.0, top: 8.0),
              child: Text(
                "Lock Hood Reports",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: 100,
              child: Material(
                elevation: 5.0,
                clipBehavior: Clip.hardEdge,
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GestureDetector(
                  onTap: () => _newTasksButtonAction(context),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _getReportTypeContent(Assets.newTasksIconSvg, "New Tasks", "Task Summary Report"),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: 100,
              child: Material(
                elevation: 5.0,
                clipBehavior: Clip.hardEdge,
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GestureDetector(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _getReportTypeContent(Assets.newTasksIconSvg, "Automated Requests", "Inventory Request Report"),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: 100,
              child: Material(
                elevation: 5.0,
                clipBehavior: Clip.hardEdge,
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GestureDetector(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _getReportTypeContent(Assets.newTasksIconSvg, "Sale & Marketing", "Sales Report"),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: 100,
              child: Material(
                elevation: 5.0,
                clipBehavior: Clip.hardEdge,
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GestureDetector(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _getReportTypeContent(Assets.newTasksIconSvg, "Inventory Resources", "Resource Report"),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: 100,
              child: Material(
                elevation: 5.0,
                clipBehavior: Clip.hardEdge,
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GestureDetector(
                  onTap: () => _productionBatchesButtonAction(context),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _getReportTypeContent(Assets.newTasksIconSvg, "Production Batches", "Production Report"),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: 100,
              child: Material(
                elevation: 5.0,
                clipBehavior: Clip.hardEdge,
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GestureDetector(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _getReportTypeContent(Assets.newTasksIconSvg, "Test Information", "Production Test Report"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getReportTypeContent(String iconName, String reportDomain, String reportType) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              iconName,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10.0,),
            Text(
              reportDomain,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0,),
        Center(child: Text(
          reportType,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),)
      ],
    );
  }

  Future<void> _newTasksButtonAction(BuildContext context) async {
    var summaryTask = await GetIt.I<MainApiProvider>().getNewTasksSummaryReport();

    if (summaryTask != null) {
      var generatedPdf = await GenerateKanBanTaskReportsService.generateTaskSummaryReportAndWeView(
          summaryTask, "KanBan Tasks in New Status");
      generatedPdf.click();
      // Navigator.pop(context);
    } else {
      showSaveResultMessage(context, false, "Something went wrong");
    }
  }

  Future<void> _productionBatchesButtonAction(BuildContext context) async {
    var summaryProduct = await GetIt.I<MainApiProvider>().getProductionBatchSummaryReport();

    if (summaryProduct != null) {
      var generatedPdf = await GenerateProductionBatchReportsService.generateProductionSummaryReportAndWeView(
          summaryProduct, "KanBan Tasks in New Status");
      generatedPdf.click();
      // Navigator.pop(context);
    } else {
      showSaveResultMessage(context, false, "Something went wrong");
    }
  }

  void showSaveResultMessage(BuildContext context, bool statusOfRequest, String message) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, message, appearFromTop: false,
        duration: 4)
        : MessageUtils.showErrorInFlushBar(context, message, appearFromTop: false, duration: 4);
  }
}
