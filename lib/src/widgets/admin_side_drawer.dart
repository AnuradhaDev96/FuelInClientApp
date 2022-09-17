import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../config/app_colors.dart';
import '../config/assets.dart';
import '../config/language_settings.dart' as lang_settings;
import '../config/language_settings.dart';
import '../models/change_notifiers/application_auth_notifier.dart';
import '../models/change_notifiers/side_drawer_notifier.dart';
import '../models/enums/admin_screen_buckets.dart';
import '../services/auth_service.dart';
import '../ui/authentication/signin_page.dart';

class AdminSideDrawer extends StatefulWidget {
  AdminSideDrawer({Key? key}) : super(key: key);

  @override
  State<AdminSideDrawer> createState() => _AdminSideDrawerState();
}

class _AdminSideDrawerState extends State<AdminSideDrawer> {
  final List<bool> _expansionPanelExpandStatus = <bool>[true];
  late SideDrawerNotifier _sideDrawerNotifier;

  @override
  void initState() {
    _sideDrawerNotifier = GetIt.I<SideDrawerNotifier>();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25.0), bottomRight: Radius.circular(25.0)),
          boxShadow: [
            BoxShadow(
              color: AppColors.grayForPrimaryDark,
              blurRadius: 12.0,
            ),
          ]
      ),
      child: Drawer(
        backgroundColor: AppColors.appBarColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      // Text(
                      //     lang_settings.SettingsEnglish.hotelNameText,
                      //     style: TextStyle(
                      //         fontSize: 20.0
                      //     )
                      // ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: Image.asset(Assets.triLanguageLogo, fit: BoxFit.fill, color: AppColors.white,),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        "moaO;s m%OdkS",// පද්ධති ප්‍රධානී
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          )
                      )
                    ],
                  ),
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  ),
                  // hoverColor: Colors.red,
                  tileColor: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.systemAccessRequests ? AppColors.nppPurple : null,
                  title: Text(
                    AdminScreenBuckets.systemAccessRequests.toDisplayString(),
                    style: const TextStyle(color: AppColors.white),
                  ),
                  onTap: () {
                    _sideDrawerNotifier.selectedPageTypeByAdmin = AdminScreenBuckets.systemAccessRequests;
                  },
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  ),
                  // hoverColor: Colors.red,
                  tileColor: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.systemRoleManagement ? AppColors.nppPurple : null,
                  title: Text(
                    AdminScreenBuckets.systemRoleManagement.toDisplayString(),
                    style: const TextStyle(color: AppColors.white),
                  ),
                  onTap: () {
                    _sideDrawerNotifier.selectedPageTypeByAdmin = AdminScreenBuckets.systemRoleManagement;
                  },
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  ),
                  title: Text(
                    AdminScreenBuckets.administrativeUnitManagement.toDisplayString(),
                    style: const TextStyle(color: AppColors.white),
                  ),
                  tileColor:
                      _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.administrativeUnitManagement
                          ? AppColors.nppPurple
                          : null,
                  onTap: () {
                    _sideDrawerNotifier.selectedPageTypeByAdmin = AdminScreenBuckets.administrativeUnitManagement;
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _logOutAction,
                    child: const Text(
                      "Log Out",
                      style: TextStyle(
                        color: AppColors.white,
                        fontFamily: SettingsSinhala.engFontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  void _logOutAction() async {
    try {
      await GetIt.I<AuthService>().signOutUser().then((value) => notifyAppIsAuthenticated());
    } catch (e) {
      return;
    }
  }
  
  void notifyAppIsAuthenticated() {
    Provider.of<ApplicationAuthNotifier>(context, listen: false).setAppUnAuthenticated();
  }
}
