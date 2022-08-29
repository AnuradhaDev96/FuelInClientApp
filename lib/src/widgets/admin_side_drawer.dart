import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rh_reader/src/utils/navigation_utils.dart';

import '../config/app_colors.dart';
import '../config/language_settings.dart' as lang_settings;
import '../models/change_notifiers/side_drawer_notifier.dart';
import '../models/enums/admin_screen_buckets.dart';
import '../ui/authentication/signin_page.dart';
import '../utils/web_router.dart';

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
        backgroundColor: AppColors.shiftGray,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: const [
                      Text(
                          lang_settings.SettingsEnglish.hotelNameText,
                          style: TextStyle(
                              fontSize: 20.0
                          )
                      ),
                      Text(
                        "Management Console",
                          style: TextStyle(
                              fontSize: 14.0,
                            fontWeight: FontWeight.w500,
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
                  tileColor: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.employeeManagement ? AppColors.white : null,
                  title: const Text(
                    "Employee Management"
                  ),
                  onTap: () {
                    _sideDrawerNotifier.selectedPageTypeByAdmin = AdminScreenBuckets.employeeManagement;
                  },
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  ),
                  // hoverColor: Colors.red,
                  tileColor: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.roomManagement ? AppColors.white : null,
                  title: const Text(
                      "Accommodation Management"
                  ),
                  onTap: () {
                    _sideDrawerNotifier.selectedPageTypeByAdmin = AdminScreenBuckets.roomManagement;
                  },
                ),
                const ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  ),
                  title: Text(
                    "Contact Us",
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(
                          color: AppColors.goldYellow
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
