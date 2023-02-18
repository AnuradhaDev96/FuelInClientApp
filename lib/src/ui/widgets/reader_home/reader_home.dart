import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/ui/reservation/reservation_page.dart';
import 'package:matara_division_system/src/ui/reservation/reservation_suit_page.dart';
import 'package:matara_division_system/src/ui/widgets/reader_home/home_content.dart';

import '../../../config/assets.dart';
import '../../../models/change_notifiers/side_drawer_notifier.dart';
import '../../../models/enums/screen_bucket_enum.dart';
import 'side_drawer.dart';
import '../../accommodation/accommodation_list.dart';
import '../../dining/dining_page.dart';
import '../../gallery/gallery_grid_view.dart';
import '../../hotel_service/hotel_services_list.dart';
import '../../reservation/reservation_history.dart';

class ReaderHome extends StatefulWidget {
  const ReaderHome({Key? key}) : super(key: key);

  @override
  State<ReaderHome> createState() => _ReaderHomeState();
}

class _ReaderHomeState extends State<ReaderHome> {
  late final SideDrawerNotifier _sideDrawerNotifier;
  final PageStorageBucket screenBucket = PageStorageBucket();
  ScreenBuckets _selectedPageIndex = ScreenBuckets.myFuelOrders;
  String _selectedPageTitle = ScreenBuckets.myFuelOrders.toDisplayString();

  @override
  void initState() {
    _sideDrawerNotifier = GetIt.I<SideDrawerNotifier>();

    _sideDrawerNotifier.addListener(() {
      if(mounted) {
        setState(() {
          _selectedPageIndex = _sideDrawerNotifier.selectedPageType ?? ScreenBuckets.myFuelOrders;
          _selectedPageTitle = _sideDrawerNotifier.selectedPageTitle();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sideDrawerNotifier.mainScaffoldKey,
      drawer: SideDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO: Check for desktop and remove side menu for mobile
          Expanded(
            flex: 1,
            child: SideDrawer()
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          Assets.hotelCoverPhotoWithLogo,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
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
      case ScreenBuckets.myFuelOrders:
        return HomeContent();
      case ScreenBuckets.booking:
        return const ReservationPage();
      case ScreenBuckets.accommodation:
        return AccommodationList();
      case ScreenBuckets.services:
        return HotelServicesList();
      case ScreenBuckets.galleryPage:
        return GalleryGridView();
      case ScreenBuckets.dining:
        return DiningPage();
      case ScreenBuckets.reservationHistory:
        return ReservationHistory();
      case ScreenBuckets.reservationSuits:
        return ReservationSuitePage();
      default:
        return const SizedBox(width: 0, height: 0);
    }
  }
}
