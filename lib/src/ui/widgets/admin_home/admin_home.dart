import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rh_reader/src/ui/admin_ui/employees/employee_management_page.dart';
import 'package:rh_reader/src/ui/reservation/reservation_page.dart';
import 'package:rh_reader/src/ui/widgets/reader_home/home_content.dart';

import '../../../config/assets.dart';
import '../../../models/change_notifiers/side_drawer_notifier.dart';
import '../../../models/enums/admin_screen_buckets.dart';
import '../../../widgets/admin_side_drawer.dart';
import '../../../widgets/side_drawer.dart';
import '../../accommodation/accommodation_list.dart';
import '../../admin_ui/accommodation/accommodation_management_page.dart';
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
  AdminScreenBuckets _selectedPageIndex = AdminScreenBuckets.employeeManagement;
  String _selectedPageTitle = AdminScreenBuckets.employeeManagement.toDisplayString();

  @override
  void initState() {
    _sideDrawerNotifier = GetIt.I<SideDrawerNotifier>();

    _sideDrawerNotifier.addListener(() {
      if(mounted) {
        setState(() {
          _selectedPageIndex = _sideDrawerNotifier.selectedPageTypeByAdmin ?? AdminScreenBuckets.employeeManagement;
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
      drawer: AdminSideDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO: Check for desktop and remove side menu for mobile
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
                      Text(
                        _selectedPageTitle,
                        style: const TextStyle(
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
      case AdminScreenBuckets.employeeManagement:
        return const EmployeeManagementPage();
      case AdminScreenBuckets.roomManagement:
        return const AccommodationManagementPage();
      default:
        return const SizedBox(width: 0, height: 0);
    }
  }
}
