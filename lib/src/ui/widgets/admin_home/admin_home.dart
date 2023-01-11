import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/ui/admin_ui/access_requests/access_requests_page_view.dart';
import '../../../config/app_colors.dart';
import '../../../utils/common_utils.dart';
import '../../admin_ui/access_requests/anonymous_access_requests_page.dart';

import 'package:matara_division_system/src/ui/reservation/reservation_page.dart';
import 'package:matara_division_system/src/ui/widgets/reader_home/home_content.dart';

import '../../../config/assets.dart';
import '../../../models/change_notifiers/side_drawer_notifier.dart';
import '../../../models/enums/admin_screen_buckets.dart';
import '../../admin_ui/administrative_divisions/administrative_divisions_list.dart';
import '../../admin_ui/administrative_divisions/administrative_units_page_view.dart';
import '../../admin_ui/reporting_arena/reporting_arena_menu_page.dart';
import '../../admin_ui/role_management/role_management_list_page.dart';
import '../../admin_ui/role_management/role_management_page_view.dart';
import '../../admin_ui/schedule_task_for_production_batch/schedule_task_module_page_view.dart';
import 'admin_side_drawer.dart';
import '../reader_home/side_drawer.dart';
import '../../accommodation/accommodation_list.dart';
import '../../admin_ui/accommodation/accommodation_management_page.dart';
import '../../admin_ui/checkin_reserved_customer/checkin_reserved_customer_page.dart';
import '../../dining/dining_page.dart';
import '../../gallery/gallery_grid_view.dart';
import '../../hotel_service/hotel_services_list.dart';
import '../../reservation/reservation_history.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late final SideDrawerNotifier _sideDrawerNotifier;
  final PageStorageBucket screenBucket = PageStorageBucket();
  AdminScreenBuckets _selectedPageIndex = AdminScreenBuckets.overview;
  String _selectedPageTitle = AdminScreenBuckets.overview.toDisplayString();

  @override
  void initState() {
    _sideDrawerNotifier = GetIt.I<SideDrawerNotifier>();

    _sideDrawerNotifier.addListener(() {
      if(mounted) {
        setState(() {
          _selectedPageIndex = _sideDrawerNotifier.selectedPageTypeByAdmin ?? AdminScreenBuckets.overview;
          _selectedPageTitle = _sideDrawerNotifier.selectedPageTitleByAdmin();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sideDrawerNotifier.adminScaffoldKey,
      backgroundColor: AppColors.lightPurpleBackground,
      drawer: AdminSideDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!CommonUtils.isMobileUI(context))
            Expanded(
                flex: 1,
                child: AdminSideDrawer()
            ),
          Expanded(
              flex: 4,
              child: Container(
                // margin: const EdgeInsets.only(left: 350),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.3,
                      //   width: MediaQuery.of(context).size.width * 0.7,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(15.0),
                      //     child: Image.asset(
                      //       Assets.hotelCoverPhotoWithLogo,
                      //       fit: BoxFit.fitWidth,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 8.0),
                      (CommonUtils.isMobileUI(context))
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _sideDrawerNotifier.operateAdminDrawer();
                                  },
                                  icon: const Icon(
                                    Icons.menu_rounded,
                                  ),
                                  splashRadius: 25.0,
                                  color: AppColors.darkPurple,
                                  // hoverColor: AppColors.appBarColor,
                                ),
                                const Expanded(
                                  child: Center(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              "",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: PageStorage(
                          bucket: screenBucket,
                          child: buildPages(),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
                      //   child: Material(
                      //     borderRadius: BorderRadius.circular(15.0),
                      //     color: Colors.white,
                      //     elevation: 5.0,
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(5.0),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             ''
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   height: 10.0,
                      //   color: Colors.blue,
                      // )
                    ],
                  ),
                ),
              )
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     height: 250.0,
          //     color: Colors.yellow,
          //   ),
          // )
        ],
      ),
    );
  }

  Widget buildPages() {
    switch (_selectedPageIndex) {
      case AdminScreenBuckets.overview:
        return const AccessRequestPageView();
      case AdminScreenBuckets.inventory:
        return const RoleManagementPageView();
      case AdminScreenBuckets.workMonitoring:
        return const AdministrativeUnitsPageView();
      case AdminScreenBuckets.scheduleTasks:
        return const ScheduleTaskModulePageView();
      case AdminScreenBuckets.reportingArena:
        return const ReportingArenaMenuPage();
      default:
        return const SizedBox(width: 0, height: 0);
    }
  }
}
