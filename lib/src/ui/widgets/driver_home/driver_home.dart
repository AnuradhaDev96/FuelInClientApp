import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/ui/admin_ui/access_requests/access_requests_page_view.dart';
import '../../../config/app_colors.dart';
import '../../../models/enums/driver_screen_buckets.dart';
import '../../../utils/common_utils.dart';

import '../../../config/assets.dart';
import '../../../models/change_notifiers/side_drawer_notifier.dart';
import '../../driver_ui/my_fuel_requests/my_fuel_requests_list_page.dart';
import 'driver_side_drawer.dart';
import '../reader_home/side_drawer.dart';
import '../../accommodation/accommodation_list.dart';
import '../../dining/dining_page.dart';
import '../../gallery/gallery_grid_view.dart';
import '../../hotel_service/hotel_services_list.dart';
import '../../reservation/reservation_history.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  late final SideDrawerNotifier _sideDrawerNotifier;
  final PageStorageBucket screenBucket = PageStorageBucket();
  DriverScreenBuckets _selectedPageIndex = DriverScreenBuckets.fuelRequest;

  @override
  void initState() {
    _sideDrawerNotifier = GetIt.I<SideDrawerNotifier>();

    _sideDrawerNotifier.addListener(() {
      if(mounted) {
        setState(() {
          _selectedPageIndex = _sideDrawerNotifier.selectedPageTypeByDriver ?? DriverScreenBuckets.fuelRequest;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sideDrawerNotifier.driverScaffoldKey,
      backgroundColor: AppColors.lightPurpleBackground,
      drawer: DriverSideDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!CommonUtils.isMobileUI(context))
            Expanded(
                flex: 1,
                child: DriverSideDrawer()
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
                              _sideDrawerNotifier.operateDriverDrawer();
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
      case DriverScreenBuckets.fuelRequest:
        return const MyFuelOrdersListPage();
      // case AdminScreenBuckets.inventory:
      //   return const FuelStationManagementPageView();
      // case AdminScreenBuckets.workMonitoring:
      //   return const AdministrativeUnitsPageView();
      // case AdminScreenBuckets.scheduleTasks:
      //   return const ScheduleTaskModulePageView();
      // case AdminScreenBuckets.reportingArena:
      //   return const ReportingArenaMenuPage();
      default:
        return const SizedBox(width: 0, height: 0);
    }
  }
}
