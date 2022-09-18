import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/models/administrative_units/grama_niladari_divisions.dart';
import '../../../models/change_notifiers/administrative_units_change_notifer.dart';

import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../models/administrative_units/divisional_secretariats.dart';
import '../../../services/administrative_units_service.dart';

class AdministrativeDivisionsList extends StatefulWidget {
  const AdministrativeDivisionsList({Key? key}) : super(key: key);

  @override
  State<AdministrativeDivisionsList> createState() => _AdministrativeDivisionsListState();
}

class _AdministrativeDivisionsListState extends State<AdministrativeDivisionsList> {
  late final AdministrativeUnitsService _administrativeUnitsService;
  List<bool> _expansionPanelExpandStatus = <bool>[];
  @override
  void initState() {
    _administrativeUnitsService = GetIt.I<AdministrativeUnitsService>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  // final ValueNotifier<List<bool>> _expansionPanelExpandStatus = ValueNotifier<List<bool>>(<bool>[]);
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
                      children: [
                        TextSpan(
                          text: "m%dfoaYsh f,alï ld¾hd, jiï ",//ප්‍රාදේශිය ලේකම් කාර්යාල වසම්
                          style: TextStyle(fontFamily: 'DL-Paras')
                        ),
                        TextSpan(
                            text: "| Divisional Secretariats",
                            style: TextStyle(fontFamily: SettingsSinhala.engFontFamily)
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
          stream: _administrativeUnitsService.getDivisionalSecretariatsStream(),
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
              return const Text("o;a; lsisjla fkdue;"); //දත්ත කිසිවක් නොමැත
            } else if (snapshot.hasData) {
              print("### length of divsecStream: ${snapshot.data!.docs.length}");
              var panels = <ExpansionPanel>[];
              //
              if (_expansionPanelExpandStatus.isEmpty) {
                for (int index = 0; index < snapshot.data!.docs.length; index++) {
                  _expansionPanelExpandStatus.add(false);
                }
              }

              for (int index = 0; index < snapshot.data!.docs.length; index++) {
                panels.add(_divSecretariatItemBuilder(context, snapshot.data!.docs[index], index));
              }


              return ExpansionPanelList(
                // shrinkWrap: true,
                expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 5.0),
                dividerColor: AppColors.nppPurple,
                animationDuration: const Duration(milliseconds: 1200),
                expansionCallback: (int panelIndex, bool isExpanded) {
                  setState(() {
                  _expansionPanelExpandStatus[panelIndex] = !_expansionPanelExpandStatus[panelIndex];

                  });
                  // _administrativeUnitsChangeNotifier.setValueByIndex(
                  //     panelIndex, !_administrativeUnitsChangeNotifier.expansionPanelExpandStatusList[panelIndex]);
                },
                // elevation: 5.0,
                // children: snapshot.data!.docs.map((data) =>
                //     _divSecretariatItemBuilder(context, data, snapshot.data!.docs.indexOf(data),)).toList(),
                children: panels,


              );
            }
            return const Text("o;a; lsisjla fkdue;");

          },
        ),
      ],
    );
  }

  ExpansionPanel _divSecretariatItemBuilder(BuildContext context, DocumentSnapshot data, int index) {
    print("##index of sent data: $index");
    final divisionalSecretariat = DivisionalSecretariats.fromSnapshot(data);
    return ExpansionPanel(
        canTapOnHeader: true,
        backgroundColor: AppColors.lightGray,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            // tileColor: AppColors.nppPurpleDark,
            // dense: false,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))
            ),
            title: Text(
              divisionalSecretariat.sinhalaValue,
              style: const TextStyle(
                fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                color: AppColors.nppPurple,
              ),
            ),
          );
        },
        isExpanded: _expansionPanelExpandStatus[index],
        body: DivisionalSecretariatExpansionPanelContent(divisionalSecretariatId: divisionalSecretariat.id),
    );
  }
}

class DivisionalSecretariatExpansionPanelContent extends StatelessWidget {
  DivisionalSecretariatExpansionPanelContent({Key? key, required this.divisionalSecretariatId}) : super(key: key);
  final String divisionalSecretariatId;
  final AdministrativeUnitsService _administrativeUnitsService = GetIt.I<AdministrativeUnitsService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
            future: _administrativeUnitsService.getGramaNiladiriDivisionsList(divisionalSecretariatId),
            builder: (BuildContext context, AsyncSnapshot<List<GramaNiladariDivisions>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: LinearProgressIndicator(
                        // strokeWidth: 5,
                        backgroundColor: AppColors.silverPurple,
                        color: AppColors.nppPurple,
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                return const Text("o;a; lsisjla fkdue;"); //දත්ත කිසිවක් නොමැත
              } else if (snapshot.hasData) {
                return ListView(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  shrinkWrap: true,
                  children: snapshot.data!.map((division) => Text(division.name)).toList(),
                );
              }

              return const Text("o;a; lsisjla fkdue;"); //දත්ත කිසිවක් නොමැත
            },
        ),
      ],
    );
  }


}

