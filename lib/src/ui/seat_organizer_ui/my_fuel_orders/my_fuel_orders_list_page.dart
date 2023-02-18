import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../../models/enums/purchase_fuel_type.dart';
import '../../../models/enums/fuel_order_status.dart';

import '../../../api_providers/main_api_provider.dart';
import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../models/fuel_in_models/fuel_order.dart';
import '../../../utils/general_dialog_utils.dart';
import 'create_fuel_order_dialog.dart';

class MyFuelOrdersListPage extends StatefulWidget {
  const MyFuelOrdersListPage({Key? key}) : super(key: key);

  @override
  State<MyFuelOrdersListPage> createState() => _MyFuelOrdersListPageState();
}

class _MyFuelOrdersListPageState extends State<MyFuelOrdersListPage> {

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  final ValueNotifier<List<FuelOrder>> _inventoryItemsList = ValueNotifier<List<FuelOrder>>(<FuelOrder>[]);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _headerPanel(context),
        FutureBuilder(
            future: GetIt.I<MainApiProvider>().getAllFuelOrders(),
            builder: (BuildContext context, AsyncSnapshot<List<FuelOrder>?> snapshot) {
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
                _inventoryItemsList.value = List<FuelOrder>.from(snapshot.data ?? <FuelOrder>[]);
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
                          child: ValueListenableBuilder<List<FuelOrder>>(
                              valueListenable: _inventoryItemsList,
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
                                      DataColumn(label: Text('Id')),
                                      DataColumn(label: Text('Quantity (Litres)')),
                                      DataColumn(label: Text('Fuel Station Id')),
                                      DataColumn(label: Text('Order Status')),
                                      DataColumn(label: Text('Fuel Type')),
                                      DataColumn(label: Text('Expected Delivery Date')),
                                      DataColumn(label: Text('Population Density')),
                                    ],
                                    rows: snapshot.map((data) => _inventoryObjectItemBuilder(context, data)).toList(),
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
              return const Text(";k;=re b,a,Sï lsisjla fkdue;"); //තනතුරු ඉල්ලීම් කිසිවක් නොමැත
            }
        )
      ],
    );
  }

  DataRow _inventoryObjectItemBuilder(BuildContext context, FuelOrder data) {
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
              // onPressed: () => _selectReservationToAssignRooms(context, reservation),
              onPressed: () {},
              child: const Text(
                "Delete",
                style: TextStyle(color: AppColors.darkPurple, fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(data.id == null ? "-" : "${data.id}")),
      DataCell(Text(data.orderQuantityInLitres == null ? "-" : "${data.orderQuantityInLitres}")),
      DataCell(Text(data.fuelStationId == null ? "-" : "${data.fuelStationId}")),
      DataCell(Text(data.orderStatus == null ? "-" : "${data.orderStatus?.toDisplayString()}")),
      DataCell(Text(data.fuelType == null ? "-" : "${data.fuelType?.toDisplayString()}")),
      DataCell(Text(data.expectedDeliveryDate == null ? "-" : DateFormat('yyyy-MM-dd').format(data.expectedDeliveryDate!))),
      DataCell(Text(data.fuelStation?.populationDensity == null ? "-" : "${data.fuelStation?.populationDensity}")),
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
                        fontFamily: SettingsSinhala.legacySinhalaFontFamily,
                        color: AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "My Fuel Orders Management"
                        ),
                      ]
                  ),
                )
            ),
            ElevatedButton(
              onPressed: () {
                _createNewFuelOrderDialog(context);
              },
              child: const Text(
                "Create New Fuel Order",//ආපසු
                style: TextStyle(color: AppColors.white, fontSize: 14.0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        Container(color: AppColors.darkPurple,height: 2.0,),
        const SizedBox(height: 8.0),
      ],
    );
  }

  void _createNewFuelOrderDialog(BuildContext context) async {
    bool isProcessSuccessful = await GeneralDialogUtils().showCustomGeneralDialog(
      context: context,
      child: const CreateFuelOrderDialog(),
      title: "Allocate Resource to Task",
    );
  }

}
