import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/models/administrative_units/divisional_secretariats.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../models/authentication/system_user.dart';
import '../../../models/change_notifiers/role_management_notifier.dart';
import '../../../services/administrative_units_service.dart';
import '../../../services/auth_service.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/message_utils.dart';

class PermissionManagementPage extends StatelessWidget {
  PermissionManagementPage({Key? key}) : super(key: key);

  final AdministrativeUnitsService _administrativeUnitsService = GetIt.I<AdministrativeUnitsService>();
  // final AuthService _authService = GetIt.I<AuthService>();

  final ValueNotifier<List<String>> _assignedPermissionsListNotifier = ValueNotifier<List<String>>(<String>[]);


  @override
  Widget build(BuildContext context) {
    return Consumer<RoleManagementNotifier>(
      builder: (BuildContext context, RoleManagementNotifier pageViewNotifier, child) {
        if (pageViewNotifier.selectedUserForPermissions == null) {
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

        _assignedPermissionsListNotifier.value =
            List<String>.from(pageViewNotifier.selectedUserForPermissions!.authPermissions ?? <String>[]);

        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.person,
                    color: AppColors.appBarColor,
                    size: 14.0,
                  ),
                  Text(
                    pageViewNotifier.selectedUserForPermissions!.fullName ?? "-",
                    style: const TextStyle(
                        fontFamily: SettingsSinhala.engFontFamily, color: AppColors.nppPurpleLight),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(
                    Icons.mail,
                    color: AppColors.appBarColor,
                    size: 14.0,
                  ),
                  Text(
                    pageViewNotifier.selectedUserForPermissions!.email ?? "-",
                    style: const TextStyle(
                        fontFamily: SettingsSinhala.engFontFamily, color: AppColors.nppPurpleLight),
                  ),
                ],
              ),
            ),
            (CommonUtils.isMobileUI(context))
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 5.0),
                        child: Text(
                          'hdj;ald,Sk lsÍfï wjirhka l<uKdlrKh', //යාවත්කාලීන කිරීමේ අවසරයන් කළමණාකරණය
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ValueListenableBuilder<List<String>>(
                                valueListenable: _assignedPermissionsListNotifier,
                                builder: (context, snapshot, child) {
                                  if (listEquals(
                                      pageViewNotifier.selectedUserForPermissions!.authPermissions, snapshot)) {
                                    return const SizedBox(width: 0, height: 0);
                                  }
                                  return IconButton(
                                    onPressed: () => _savePermissionUpdatesByUser(
                                        context, pageViewNotifier.selectedUserForPermissions!),
                                    icon: const Icon(
                                      Icons.save,
                                      size: 32.0,
                                    ),
                                    splashRadius: 6.0,
                                    color: AppColors.nppPurple,
                                    // tooltip: "kj iduðlfhla", //නව සාමජිකයෙක්
                                  );
                                }),
                            const SizedBox(width: 8.0),
                            RawMaterialButton(
                                // onPressed: _createNewDivisionalSecretariatRecord,
                                onPressed: () => _navigateToRoleManagementListPage(context),
                                fillColor: AppColors.nppPurple,
                                shape:
                                    const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                child: const Icon(
                                  Icons.keyboard_backspace_outlined,
                                  size: 25.0,
                                  color: AppColors.white,
                                )
                                // splashRadius: 10.0,

                                ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 5.0),
                        child: Text(
                          'hdj;ald,Sk lsÍfï wjirhka l<uKdlrKh', //යාවත්කාලීන කිරීමේ අවසරයන් කළමණාකරණය
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ValueListenableBuilder<List<String>>(
                                valueListenable: _assignedPermissionsListNotifier,
                                builder: (context, snapshot, child) {
                                  if (listEquals(
                                      pageViewNotifier.selectedUserForPermissions!.authPermissions, snapshot)) {
                                    return const SizedBox(width: 0, height: 0);
                                  }
                                  return IconButton(
                                    onPressed: () => _savePermissionUpdatesByUser(
                                        context, pageViewNotifier.selectedUserForPermissions!),
                                    icon: const Icon(
                                      Icons.save,
                                      size: 32.0,
                                    ),
                                    splashRadius: 6.0,
                                    color: AppColors.nppPurple,
                                    // tooltip: "kj iduðlfhla", //නව සාමජිකයෙක්
                                  );
                                }),
                            const SizedBox(width: 8.0),
                            RawMaterialButton(
                                // onPressed: _createNewDivisionalSecretariatRecord,
                                onPressed: () => _navigateToRoleManagementListPage(context),
                                fillColor: AppColors.nppPurple,
                                shape:
                                    const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                child: const Icon(
                                  Icons.keyboard_backspace_outlined,
                                  size: 25.0,
                                  color: AppColors.white,
                                )
                                // splashRadius: 10.0,

                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 5.0),
            Container(color: AppColors.nppPurple,height: 2.0,),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Material(
                    elevation: 3.0,
                    color: AppColors.lightGray,
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ValueListenableBuilder<List<String>>(
                        valueListenable: _assignedPermissionsListNotifier,
                        builder: (context, snapshot, child) {
                          if (snapshot.isEmpty) {
                            return const Center(
                              child: Text(
                                "යාවත්කාලීන කිරීමේ අවසරයන් කිසිවක් ලබා දී නැත.",
                                style: TextStyle(fontFamily: SettingsSinhala.unicodeSinhalaFontFamily),
                              ),
                            );
                          }
                          return Wrap(
                            alignment: WrapAlignment.start,
                            children: snapshot.map((permissionCode) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Chip(
                                label: Text(
                                    permissionCode,
                                    style: const TextStyle(
                                        fontFamily: SettingsSinhala.engFontFamily, color: AppColors.white),
                                  ),
                                padding: const EdgeInsets.all(5.0),
                                backgroundColor: AppColors.nppPurpleLight,
                                elevation: 3.0,
                                onDeleted: () {
                                  _assignedPermissionsListNotifier.value
                                                .removeWhere((element) => element == permissionCode);
                                  _assignedPermissionsListNotifier.value =
                                                List<String>.from(_assignedPermissionsListNotifier.value);
                                },
                              ),
                            )).toList(),
                          );
                        },
                      ),
                    )
                  ),
                )
              ],
            ),
            StreamBuilder(
              stream: _administrativeUnitsService.getDivisionalSecretariatsStream(),
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
                  return const Text("mßmd,k tAll lsisjla fkdue;"); //පරිපාලන ඒකක කිසිවක් නොමැත
                } else if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Text("mßmd,k tAll lsisjla fkdue;"); //පරිපාලන ඒකක කිසිවක් නොමැත
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((division) => _divisionalSecretariatItemBuilder(context, division)).toList(),
                  );
                }
                return const Text("mßmd,k tAll lsisjla fkdue;"); //පරිපාලන ඒකක කිසිවක් නොමැත
              }
            ),
          ],
        );
      },
    );
  }

  Widget _divisionalSecretariatItemBuilder(BuildContext context, DocumentSnapshot data) {
    final division = DivisionalSecretariats.fromSnapshot(data);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      padding: const EdgeInsets.fromLTRB(25.0, 8.0, 10.0, 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        // gradient: LinearGradient(colors: [AppColors.nppPurpleLight, Colors.white], stops: [0.02, 0.02]),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                division.id,
                style: const TextStyle(
                  fontFamily: SettingsSinhala.engFontFamily,
                  color: AppColors.appBarColor,
                ),
              ),
              Text(
                division.sinhalaValue,
                style: const TextStyle(
                  fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                  color: AppColors.nppPurple,
                ),
              ),
            ],
          ),
          ValueListenableBuilder<List<String>>(
            valueListenable: _assignedPermissionsListNotifier,
            builder: (context, snapshot, child) {
              if (snapshot.contains(division.id)) {
                return IconButton(
                  onPressed: () {
                    // _assignedPermissionsListNotifier.value.remove(division.id);
                    // snapshot.remove(division.id);
                    _assignedPermissionsListNotifier.value.removeWhere((element) => element == division.id);
                    _assignedPermissionsListNotifier.value = List<String>.from(_assignedPermissionsListNotifier.value);
                  },
                  // onPressed: () => _deleteSelectedGramaNiladariDivision(context, divisionalSecretariat.id, division),
                  icon: const Icon(
                    Icons.remove_circle,
                  ),
                  splashRadius: 20.0,
                  color: AppColors.nppPurple,
                );
              }
              return IconButton(
                onPressed: () {
                  _assignedPermissionsListNotifier.value = [..._assignedPermissionsListNotifier.value, division.id];
                  // snapshot.add(division.id);
                },
                // onPressed: () => _deleteSelectedGramaNiladariDivision(context, divisionalSecretariat.id, division),
                icon: const Icon(
                  Icons.add_circle,
                ),
                splashRadius: 20.0,
                color: AppColors.nppPurple.withOpacity(0.4),
              );
            }
          ),
        ],
      ),
    );
  }

  void _navigateToRoleManagementListPage(BuildContext context) {
    Provider.of<RoleManagementNotifier>(context, listen: false).jumpToPreviousPage();
  }

  void _savePermissionUpdatesByUser(BuildContext context, SystemUser userToBeUpdated) {
    print("###perm: ${_assignedPermissionsListNotifier.value}");
    GetIt.I<AuthService>()
        .assignPermissionsForUser(userToBeUpdated, _assignedPermissionsListNotifier.value)
        .then(
          (value) {
        if (value) {
          // clearInputFields();
          //අවසරයන් යාවත්කාලීන කිරීම සාර්ථකයි.
          showSaveResultMessage(context, true, "wjirhka hdj;ald,Sk lsÍu id¾:lhs'");
          _navigateToRoleManagementListPage(context);
        } else {
          //අවසරයන් යාවත්කාලීන කිරීම අසාර්ථකයි.
          showSaveResultMessage(context, false, "wjirhka hdj;ald,Sk lsÍu wd¾:lhs'");
        }
      },
      onError: (e) {
        //තාක්ශනික දෝශයක්. නැවත උත්සහ කරන්න.
        showSaveResultMessage(context, false, ";dlaYksl fodaYhla' kej; W;aiy lrkak'");
      },
    );
  }

  void showSaveResultMessage(BuildContext context, bool statusOfRequest, String message) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, message, appearFromTop: false,
        duration: 4)
        : MessageUtils.showErrorInFlushBar(context, message, appearFromTop: false, duration: 4);
  }
}
