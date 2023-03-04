import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/config/language_settings.dart';
import 'package:matara_division_system/src/models/change_notifiers/role_management_notifier.dart';
import 'package:matara_division_system/src/models/enums/user_types.dart';
import 'package:matara_division_system/src/utils/string_extention.dart';
import 'package:provider/provider.dart';

import '../../../api_providers/main_api_provider.dart';
import '../../../config/app_colors.dart';
import '../../../models/authentication/system_user.dart';
import '../../../models/fuel_in_models/fuel_station.dart';
import '../../../models/lock_hood_models/inventory_items.dart';
import '../../../services/auth_service.dart';

class FuelStationsListPage extends StatelessWidget {
  FuelStationsListPage({Key? key}) : super(key: key);
  final AuthService _authService = GetIt.I<AuthService>();
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  final ValueNotifier<List<FuelStation>> _inventoryItemsList = ValueNotifier<List<FuelStation>>(<FuelStation>[]);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // _headerPanel(context),
        FutureBuilder(
          future: GetIt.I<MainApiProvider>().getAllFuelStations(),
          builder: (BuildContext context, AsyncSnapshot<List<FuelStation>?> snapshot) {
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
              _inventoryItemsList.value = List<FuelStation>.from(snapshot.data ?? <FuelStation>[]);
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
                        child: ValueListenableBuilder<List<FuelStation>>(
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
                                  DataColumn(label: Text('District')),
                                  DataColumn(label: Text('Local Authority')),
                                  DataColumn(label: Text('License Id')),
                                  DataColumn(label: Text('Address')),
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

  DataRow _inventoryObjectItemBuilder(BuildContext context, FuelStation data) {
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
      DataCell(Text(data.district ?? "-")),
      DataCell(Text(data.localAuthority ?? "-")),
      DataCell(Text(data.licenseId ?? "-")),
      DataCell(Text(data.address ?? "-")),
      // DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkIn!))),
      // DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkOut!))),
      DataCell(Text(data.populationDensity == null ? "-" : "${data.populationDensity}")),
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
                          text: ";k;=re iy wjirhka ",//තනතුරු සහ අවසරයන්
                        ),
                        TextSpan(
                            text: "(Permissions) ",
                            style: TextStyle(fontFamily: SettingsSinhala.engFontFamily)
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

  void _navigateToPermissionsPage(BuildContext context, SystemUser systemUser) {
    Provider.of<RoleManagementNotifier>(context, listen: false)
        .setSelectedUserForPermissions(systemUser);
    Provider.of<RoleManagementNotifier>(context, listen: false).jumpToNextPage();
  }
}
