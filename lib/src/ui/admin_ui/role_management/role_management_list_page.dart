import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/config/language_settings.dart';
import 'package:matara_division_system/src/models/change_notifiers/role_management_notifier.dart';
import 'package:matara_division_system/src/models/enums/user_types.dart';
import 'package:matara_division_system/src/utils/string_extention.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../models/authentication/system_user.dart';
import '../../../services/auth_service.dart';

class RoleManagementListPage extends StatelessWidget {
  RoleManagementListPage({Key? key}) : super(key: key);
  final AuthService _authService = GetIt.I<AuthService>();
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                    fontFamily: 'DL-Paras',
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
        Container(color: AppColors.nppPurple,height: 2.0,),
        const SizedBox(height: 8.0),
        StreamBuilder(
          stream: _authService.getUsersForAdminStream(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: AppColors.nppPurple,
                      ),
                    )),
              );
            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
              return const Text(";k;=re b,a,Sï lsisjla fkdue;"); //තනතුරු ඉල්ලීම් කිසිවක් නොමැත
            } else if (snapshot.hasData) {
              // employeeList = snapshot.data ?? <EmployeeModel>[];
              // return ListView(
              //   shrinkWrap: true,
              //   children: snapshot.data!.docs.map((data) => accessItemBuilder(context, data)).toList(),
              // );
              // return Text("Error: ${snapshot.error}");
              return Scrollbar(
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
                      child: DataTable(
                        headingTextStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, fontFamily: 'DL-Paras'),
                        dataTextStyle: const TextStyle(fontSize: 12.0, fontFamily: SettingsSinhala.engFontFamily),
                        headingRowColor: MaterialStateProperty.all(AppColors.silverPurple),
                        columns: const [
                          DataColumn(label: Text(';SrKh')),//තීරණය
                          DataColumn(label: Text('iïmQ¾K ku')),//සම්පූර්ණ නම
                          DataColumn(label: Text('Bfï,a ,smskh')),//ඊමේල් ලිපිනය
                          DataColumn(label: Text(';k;=r')),//තනතුර
                          DataColumn(label: Text('wjirhka')),//අවසරයන්
                          // DataColumn(label: Text('b,a¨ï l< Èkh')),//ඉල්ලුම් කළ දිනය
                          // DataColumn(label: Text('wjidk jrg\nfjkia l< Èkh')),//අවසාන වරට වෙනස් කළ දිනය
                        ],
                        rows: snapshot.data!.docs.map((data) => _roleItemBuilder(context, data)).toList(),
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

  DataRow _roleItemBuilder(BuildContext context, DocumentSnapshot data) {
    final systemUser = SystemUser.fromSnapshot(data);
    print("sysUsers: ${systemUser.email} | ${systemUser.type}");

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
                "bj;alrkak",//ඉවත්කරන්න
                style: TextStyle(color: AppColors.nppPurple, fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(systemUser.fullName ?? "-")),
      DataCell(Text(systemUser.email ?? "-")),
      // DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkIn!))),
      // DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkOut!))),
      DataCell(Text(
        (systemUser.type)?.authUserTypeEnumValue == null
            ? "-"
            : "${(systemUser.type)?.authUserTypeEnumValue!.toDisplaySinhalaString()}",
        style: const TextStyle(fontFamily: 'DL-Paras'),
      )),
      DataCell(
        Row(
          children: [
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                backgroundColor: MaterialStateProperty.all(AppColors.silverPurple),
              ),
              // onPressed: () => _selectReservationToAssignRooms(context, reservation),
              onPressed: () => _navigateToPermissionsPage(context, systemUser),
              child: const Text(
                "f;darkak",//තෝරන්න
                style: TextStyle(color: AppColors.nppPurple, fontSize: 14.0),
              ),
            ),
          ],
        ),
      )
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

  void _navigateToPermissionsPage(BuildContext context, SystemUser systemUser) {
    Provider.of<RoleManagementNotifier>(context, listen: false)
        .setSelectedUserForPermissions(systemUser);
    Provider.of<RoleManagementNotifier>(context, listen: false).jumpToNextPage();
  }
}
