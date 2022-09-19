import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../models/change_notifiers/administrative_units_change_notifer.dart';
import '../../../models/membership/membership_model.dart';
import '../../../services/membership_service.dart';

class MembershipListPage extends StatelessWidget {
  MembershipListPage({Key? key}) : super(key: key);

  final MembershipService _membershipService = GetIt.I<MembershipService>();
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Consumer<AdministrativeUnitsChangeNotifier>(
      builder: (BuildContext context, AdministrativeUnitsChangeNotifier pageViewNotifier, child) {
        if (pageViewNotifier.paramDivisionalSecretariatId == null ||
          pageViewNotifier.paramGramaNiladariDivisionId == null) {
        return Column(
          children: [
            const Text(";dlaYksl fodaYhla' kej; fmr msgqjg hkak'"), //තාක්ශනික දෝශයක්. නැවත පෙර පිටුවට යන්න.
            const SizedBox(height: 5.0),
            ElevatedButton(
              onPressed: () {
                pageViewNotifier.jumpToPreviousPage();
              },
              child: const Text(
                "wdmiq", //ආපසු
                style: TextStyle(color: AppColors.white, fontSize: 14.0),
              ),
            ),
          ],
        );
      }

      return ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 15.0),
                    child: Text(
                      'idudðlhska l<uKdlrKh',//සාමාජිකයින් කළමණාකරණය
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 15.0),
                  child: RawMaterialButton(
                      // onPressed: _createNewDivisionalSecretariatRecord,
                      onPressed: () => _navigateToAdministrativeUnitsPage(context),
                      fillColor: AppColors.nppPurple,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: const Icon(Icons.keyboard_backspace_outlined, size: 25.0, color: AppColors.white,)
                    // splashRadius: 10.0,

                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Container(color: AppColors.nppPurple,height: 2.0,),
            const SizedBox(height: 8.0),
            StreamBuilder(
              stream: _membershipService.getDivisionalSecretariatsStream(
                  pageViewNotifier.paramDivisionalSecretariatId!,
                  pageViewNotifier.paramGramaNiladariDivisionId!),
              builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
                  return const Text("idudðlhska lsisfjla lsisjla fkdue;"); //සාමාජිකයින් කිසිවෙක් නොමැත
                } else if (snapshot.hasData) {
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
                            headingTextStyle: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: SettingsSinhala.unicodeSinhalaFontFamily),
                            dataTextStyle: const TextStyle(fontSize: 12.0, fontFamily: SettingsSinhala.unicodeSinhalaFontFamily),
                            headingRowColor: MaterialStateProperty.all(AppColors.silverPurple),
                            columns: const [
                              DataColumn(label: Text('ජා.හැ.අංකය')),
                              DataColumn(label: Text('සම්පූර්ණ නම')),
                              DataColumn(label: Text('ප්‍රා ලේ කේතය')),
                              DataColumn(label: Text('ග්‍රාම සේවක කේතය')),
                              // DataColumn(label: Text(';SrKh')),
                            ],
                            rows: snapshot.data!.docs.map((data) => _membershipItemBuilder(context, data)).toList(),
                          )
                        ),
                      )
                    )
                  );
                }
                return const Text("idudðlhska lsisfjla lsisjla fkdue;"); //සාමාජිකයින් කිසිවෙක් නොමැත
              },
            )
          ],
        );
      }
    );
  }

  DataRow _membershipItemBuilder(BuildContext context, DocumentSnapshot data) {
    final membership = MembershipModel.fromSnapshot(data);

    return DataRow(cells: [
      DataCell(Text(membership.nicNumber)),
      DataCell(Text(membership.fullName)),
      DataCell(Text(membership.divisionalSecretariatId)),
      DataCell(Text(membership.gramaNiladariDivisionId)),
    ]);
  }

  void _navigateToAdministrativeUnitsPage(BuildContext context) {
    Provider.of<AdministrativeUnitsChangeNotifier>(context, listen: false)
        .drainSelectedAdministrativeIds();
    Provider.of<AdministrativeUnitsChangeNotifier>(context, listen: false).jumpToPreviousPage();
  }
}
