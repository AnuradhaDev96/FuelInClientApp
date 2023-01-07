import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../config/assets.dart';
import '../../../config/language_settings.dart' as lang_settings;
import '../../../config/language_settings.dart';
import '../../../models/change_notifiers/application_auth_notifier.dart';
import '../../../models/change_notifiers/side_drawer_notifier.dart';
import '../../../models/enums/admin_screen_buckets.dart';
import '../../../services/auth_service.dart';
import '../../authentication/signin_page.dart';

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
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
      decoration: const BoxDecoration(
        color: AppColors.darkPurple,
          borderRadius: BorderRadius.all(Radius.circular(30.0))
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.grayForPrimaryDark,
          //     blurRadius: 12.0,
          //   ),
          // ]
      ),
      child: Drawer(
        backgroundColor: AppColors.darkPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SvgPicture.asset(
                    Assets.drawerLogoSvg,
                    width: 310 * 0.6,
                    height: 64 * 0.6,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25.0, bottom: 8.0),
                  child: Text(
                    "Admin Tools",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.silverPurple
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  child: ListTile(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    // hoverColor: Colors.red,
                    tileColor: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.overview
                        ? AppColors.white
                        : AppColors.darkPurple,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Assets.overviewLogoSvg,
                          width: 25 * 0.8,
                          height: 24 * 0.8,
                          color: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.overview
                              ? AppColors.darkPurple
                              : AppColors.white,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          "Overview",
                          style: TextStyle(
                              color: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.overview
                                  ? AppColors.black
                                  : AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                      ],
                    ),
                    onTap: () {
                      _sideDrawerNotifier.selectedPageTypeByAdmin = AdminScreenBuckets.overview;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  child: ListTile(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    // hoverColor: Colors.red,
                    tileColor: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.inventory
                        ? AppColors.white
                        : AppColors.darkPurple,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Assets.inventoryLogoSvg,
                          width: 25 * 0.8,
                          height: 24 * 0.8,
                          color: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.inventory
                              ? AppColors.darkPurple
                              : AppColors.white,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          "Inventory",
                          style: TextStyle(
                              color: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.inventory
                                  ? AppColors.black
                                  : AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                      ],
                    ),
                    onTap: () {
                      _sideDrawerNotifier.selectedPageTypeByAdmin = AdminScreenBuckets.inventory;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  child: ListTile(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    // hoverColor: Colors.red,
                    tileColor: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.workMonitoring
                        ? AppColors.white
                        : AppColors.darkPurple,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Assets.workMonitoringLogoSvg,
                          width: 25 * 0.8,
                          height: 24 * 0.8,
                          color: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.workMonitoring
                              ? AppColors.darkPurple
                              : AppColors.white,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          "Work Monitoring",
                          style: TextStyle(
                              color: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.workMonitoring
                                  ? AppColors.black
                                  : AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                      ],
                    ),
                    onTap: () {
                      _sideDrawerNotifier.selectedPageTypeByAdmin = AdminScreenBuckets.workMonitoring;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  child: ListTile(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    // hoverColor: Colors.red,
                    tileColor: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.workMonitoring
                        ? AppColors.white
                        : AppColors.darkPurple,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Assets.scheduleTaskLogoSvg,
                          width: 25 * 0.8,
                          height: 24 * 0.8,
                          color: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.workMonitoring
                              ? AppColors.darkPurple
                              : AppColors.white,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          "Scheduling Tasks",
                          style: TextStyle(
                              color: _sideDrawerNotifier.selectedPageTypeByAdmin == AdminScreenBuckets.workMonitoring
                                  ? AppColors.black
                                  : AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                      ],
                    ),
                    onTap: () {
                      _sideDrawerNotifier.selectedPageTypeByAdmin = AdminScreenBuckets.workMonitoring;
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _logOutAction,
                      child: const Text(
                        "Log Out",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontFamily: SettingsSinhala.engFontFamily,
                        ),
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
