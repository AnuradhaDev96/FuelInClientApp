import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:matara_division_system/src/models/enums/kanban_status.dart';
import 'package:provider/provider.dart';

import '../../../api_providers/main_api_provider.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_settings.dart';
import '../../../models/lock_hood_models/kanban_task.dart';
import '../../../models/lock_hood_models/production_batch.dart';
import '../../../utils/general_dialog_utils.dart';
import 'update_test_info_of_batch_dialog.dart';

class ProductionBatchListPage extends StatelessWidget {
  ProductionBatchListPage({Key? key}) : super(key: key);
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  final ValueNotifier<List<ProductionBatch>> _batchList = ValueNotifier<List<ProductionBatch>>(<ProductionBatch>[]);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // _headerPanel(context),
        FutureBuilder(
            future: GetIt.I<MainApiProvider>().getAllProductionBatches(),
            builder: (BuildContext context, AsyncSnapshot<List<ProductionBatch>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          color: AppColors.darkPurple,
                        ),
                      )),
                );
              } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text("No data found"));
              } else if (snapshot.hasData) {
                _batchList.value = List<ProductionBatch>.from(snapshot.data ?? <ProductionBatch>[]);
                // employeeList = snapshot.data ?? <EmployeeModel>[];
                // return ListView(
                //   shrinkWrap: true,
                //   children: snapshot.data!.docs.map((data) => accessItemBuilder(context, data)).toList(),
                // );
                // return Text("Error: ${snapshot.error}");
                return Material(
                  elevation: 3.0,
                  clipBehavior: Clip.hardEdge,
                  color: AppColors.themeGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Scrollbar(
                    controller: _verticalScrollController,
                    scrollbarOrientation: ScrollbarOrientation.right,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: SingleChildScrollView(
                      controller: _verticalScrollController,
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      child: Scrollbar(
                        controller: _horizontalScrollController,
                        scrollbarOrientation: ScrollbarOrientation.top,
                        thumbVisibility: true,
                        trackVisibility: true,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: _horizontalScrollController,
                          child: ValueListenableBuilder<List<ProductionBatch>>(
                              valueListenable: _batchList,
                              builder: (context, snapshot, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: DataTable(
                                    headingTextStyle: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black),
                                    dataTextStyle: const TextStyle(
                                        fontSize: 12.0, color: AppColors.black),
                                    // headingRowColor: MaterialStateProperty.all(AppColors.silverPurple),
                                    // border: const TableBorder(
                                    //   bottom: BorderSide(color: AppColors.silverPurple),
                                    // ),
                                    columns: const [
                                      DataColumn(label: Text('Action')),
                                      DataColumn(label: Text('Batch Id')),
                                      DataColumn(label: Text('Production Amount')),
                                      DataColumn(label: Text('Tested Amount')),
                                      DataColumn(label: Text('Passed Amount')),
                                      DataColumn(label: Text('Deadline')),
                                      DataColumn(label: Text('Estimated Schedule Date')),
                                      DataColumn(label: Text('Workshop Id')),
                                      DataColumn(label: Text('Created Manager Id')),
                                    ],
                                    rows: snapshot.map((data) => _productionBatchItemBuilder(context, data)).toList(),
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const Center(child: Text("No data found"));
            }
        )
      ],
    );
  }

  DataRow _productionBatchItemBuilder(BuildContext context, ProductionBatch data) {
    // final systemUser = SystemUser.fromSnapshot(data);

    return DataRow(cells: [

      DataCell(
        Row(
          children: [
            // ElevatedButton(
            //   onPressed: () => _selectAccessRequestToCreateUser(context, systemUser),
            //   child: const Text(
            //     "n|jd.kak",//බඳවාගන්න
            //     style: TextStyle(color: AppColors.white, fontSize: 14.0),
            //   ),
            // ),
            // const SizedBox(width: 5.0),
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                backgroundColor: MaterialStateProperty.all(AppColors.silverPurple),
              ),
              onPressed: () => {},
              // onPressed: () => _openAllocateResourceDialog(context, data.batchId ?? -1, data.id ?? -1),
              child: const Text(
                "Evaluate Production",
                style: TextStyle(color: AppColors.darkPurple, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(data.id == null ? "-" : "${data.id}")),
      DataCell(Text(data.amount == null ? "-" : "${data.amount}")),
      DataCell(
        Text(data.testedAmount == null ? "-" : "${data.testedAmount}"),
        showEditIcon: true,
        onTap: () => _updateTestedProductInfo(context, data.id ?? 0, data.testedAmount ?? 0, data.passedAmount ?? 0),
      ),
      DataCell(
        Text(data.passedAmount == null ? "-" : "${data.passedAmount}"),
        showEditIcon: true,
        onTap: () => _updateTestedProductInfo(context, data.id ?? 0, data.testedAmount ?? 0, data.passedAmount ?? 0),
      ),
      DataCell(Text(data.deadline == null ? "-" : DateFormat('yyyy-MM-dd').format(data.deadline!))),
      DataCell(Text(data.estimatedScheduledDate == null
          ? "Production evaluation\nnot yet done"
          : DateFormat('yyyy-MM-dd').format(data.estimatedScheduledDate!))),
      DataCell(Text(data.workshopId == null ? "-" : "${data.workshopId}")),
      // DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkIn!))),
      // DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkOut!))),
      DataCell(Text(data.createdManagerId == null ? "-" : "${data.createdManagerId}")),
      // DataCell(
      //   Row(
      //     children: [
      //       ElevatedButton(
      //         style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
      //           backgroundColor: MaterialStateProperty.all(AppColors.darkPurple),
      //         ),
      //         // onPressed: () => _selectReservationToAssignRooms(context, reservation),
      //         onPressed: () => _navigateToPermissionsPage(context, systemUser),
      //         child: const Text(
      //           "f;darkak",//තෝරන්න
      //           style: TextStyle(color: AppColors.white, fontSize: 14.0),
      //         ),
      //       ),
      //     ],
      //   ),
      // )
      // DataCell(
      //   RichText(
      //     text: TextSpan(
      //       style: const TextStyle(fontFamily: SettingsSinhala.engFontFamily),
      //       children: [
      //         TextSpan(text: DateFormat.yMd().format(systemUser.requestedDate!)),
      //         const TextSpan(text: "  "),
      //         TextSpan(
      //           text: DateFormat.jms().format(systemUser.requestedDate!),
      //           style: const TextStyle(color: AppColors.createdDateColor),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // DataCell(
      //   RichText(
      //     text: TextSpan(
      //       style: const TextStyle(fontFamily: SettingsSinhala.engFontFamily),
      //       children: [
      //         TextSpan(
      //           text: DateFormat.yMd().format(systemUser.lastUpdatedDate!),
      //         ),
      //         const TextSpan(text: "  "),
      //         TextSpan(
      //           text: DateFormat.jms().format(systemUser.lastUpdatedDate!),
      //           style: const TextStyle(color: AppColors.updatedDateColor),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      // DataCell(Text("${reservation.noOfNightsReserved ?? 0}")),
      // DataCell(Text("${reservation.totalCostOfReservation ?? 0}")),
    ]);
  }

  // void _openAllocateResourceDialog(BuildContext context, int batchId, int kanbanTaskId) async {
  //   bool isProcessSuccessful = await GeneralDialogUtils().showCustomGeneralDialog(
  //     context: context,
  //     child: KanBanTaskAllocateResourcesDialog(productionBatchId: batchId, kanbantaskId: kanbanTaskId,),
  //     title: "Allocate Resource to Task",
  //   );
  // }

  void _updateTestedProductInfo(BuildContext context, int batchId, int testedAmount, int passedAmount) async {
    bool isProcessSuccessful = await GeneralDialogUtils().showCustomGeneralDialog(
      context: context,
      child: UpdateTestInfoOfBatchDialog(batchId: batchId, testedAmount: testedAmount, passedAmount: passedAmount),
      title: "Update Test Information of Batch Id: $batchId",
    );
  }

  Widget _headerPanel(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 15.0),
                child: RichText(
                  text: const TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: ";k;=re iy wjirhka ",//තනතුරු සහ අවසරයන්
                        ),
                        TextSpan(
                          text: "(Permissions) ",
                        ),
                        TextSpan(
                          text: "l<uKdlrKh",//කළමණාකරණය
                        ),
                      ]
                  ),
                )
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        Container(color: AppColors.darkPurple,height: 2.0,),
        const SizedBox(height: 8.0),
      ],
    );
  }

// void _navigateToPermissionsPage(BuildContext context, SystemUser systemUser) {
//   Provider.of<RoleManagementNotifier>(context, listen: false)
//       .setSelectedUserForPermissions(systemUser);
//   Provider.of<RoleManagementNotifier>(context, listen: false).jumpToNextPage();
// }
}
