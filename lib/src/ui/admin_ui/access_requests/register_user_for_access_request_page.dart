import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../models/enums/access_request_status.dart';
import '../../../models/enums/user_types.dart';
import '../../../models/authentication/request_access_model.dart';
import '../../../models/change_notifiers/access_requests_page_view_notifier.dart';
import 'register_access_request_with_user_form.dart';

class RegisterUserForAccessRequestPage extends StatelessWidget {
  RegisterUserForAccessRequestPage({Key? key}) : super(key: key);

  final ScrollController _horizontalScrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Consumer<AccessRequestsPageViewNotifier>(
      builder: (BuildContext context, AccessRequestsPageViewNotifier pageViewNotifier, child) {
        if (pageViewNotifier.requestAccessModelToBeSaved == null) {
          return Column(
            children: [
              const Text(";dlaYksl fodaYhla' kej; fmr msgqjg hkak'"),//තාක්ශනික දෝශයක්. නැවත පෙර පිටුවට යන්න.
              const SizedBox(height: 5.0),
              ElevatedButton(
                onPressed: () {
                  pageViewNotifier.jumpToPreviousPage();
                },
                child: const Text(
                  "wdmiq",//ආපසු
                  style: TextStyle(color: AppColors.white, fontSize: 14.0),
                ),
              ),
            ],
          );
        }

        RequestAccessModel requestAccessModel = pageViewNotifier.requestAccessModelToBeSaved!;
        return ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 15.0),
                  child: Text(
                    'f;dard.;a m%fõY b,a,Su',//තෝරාගත් ප්‍රවේශ ඉල්ලීම
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 15.0),
                  child: RawMaterialButton(
                      onPressed: () {
                        pageViewNotifier.jumpToPreviousPage();
                      },
                      // iconSize: 15.0,
                      // color: AppColors.nppPurple,
                      // padding: const EdgeInsets.all(5.0),
                      fillColor: AppColors.nppPurple,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: const Icon(Icons.keyboard_backspace_outlined, size: 25.0, color: AppColors.white,),

                    // splashRadius: 10.0,

                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Container(color: AppColors.nppPurple,height: 2.0,),
            const SizedBox(height: 8.0),
            Scrollbar(
              controller: _horizontalScrollController,
              scrollbarOrientation: ScrollbarOrientation.top,
              thumbVisibility: true,
              trackVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _horizontalScrollController,
                physics: const ClampingScrollPhysics(),
                child: DataTable(
                  headingTextStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: SettingsSinhala.legacySinhalaFontFamily,
                    color: AppColors.black),
                dataTextStyle:
                    const TextStyle(fontSize: 12.0, fontFamily: SettingsSinhala.engFontFamily, color: AppColors.black),
                headingRowColor: MaterialStateProperty.all(AppColors.silverPurple),
                  columns: const [
                    DataColumn(label: Text('iïmQ¾K ku')),//සම්පූර්ණ නම
                    DataColumn(label: Text('Bfï,a ,smskh')),//ඊමේල් ලිපිනය
                    DataColumn(label: Text('ÿ\'l\' wxlh')),//දු.ක. අංකය
                    DataColumn(label: Text('b,a,Sï lrk ;k;=r')),//ඉල්ලීම් කරන තනතුර
                    DataColumn(
                      label: Text(
                        "Status",
                        style: TextStyle(
                            fontFamily: SettingsSinhala.engFontFamily
                        ),
                      ),
                    ),
                    DataColumn(label: Text('b,a¨ï l< Èkh')),//ඉල්ලුම් කළ දිනය
                    DataColumn(label: Text('wjidk jrg\nfjkia l< Èkh')),//අවසාන වරට වෙනස් කළ දිනය
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(requestAccessModel.fullName)),
                      DataCell(Text(requestAccessModel.email)),
                      DataCell(Text("${requestAccessModel.waPhoneNumber}")),
                      DataCell(Text(
                        "${requestAccessModel.userType?.toDisplaySinhalaString()}",
                        style: const TextStyle(fontFamily: 'DL-Paras'),
                      )),
                      DataCell(Text("${requestAccessModel.accessRequestStatus?.toDbValue()}")),
                      DataCell(
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontFamily: SettingsSinhala.engFontFamily, color: AppColors.black),
                            children: [
                              TextSpan(text: DateFormat.yMd().format(requestAccessModel.requestedDate!)),
                              const TextSpan(text: "  "),
                              TextSpan(
                                text: DateFormat.jms().format(requestAccessModel.requestedDate!),
                                style: const TextStyle(color: AppColors.createdDateColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontFamily: SettingsSinhala.engFontFamily, color: AppColors.black),
                            children: [
                              TextSpan(
                                text: DateFormat.yMd().format(requestAccessModel.lastUpdatedDate!),
                              ),
                              const TextSpan(text: "  "),
                              TextSpan(
                                text: DateFormat.jms().format(requestAccessModel.lastUpdatedDate!),
                                style: const TextStyle(color: AppColors.updatedDateColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      // DataCell(Text("${reservation.noOfNightsReserved ?? 0}")),
                      // DataCell(Text("${reservation.totalCostOfReservation ?? 0}")),
                    ])
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            RegisterAccessRequestWithUserForm(selectedRequestAccess: requestAccessModel,),
          ],
        );
      }
    );
  }
}
