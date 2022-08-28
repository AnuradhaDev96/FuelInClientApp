import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rh_reader/src/utils/navigation_utils.dart';

import '../config/app_colors.dart';
import '../config/language_settings.dart' as lang_settings;
import '../models/change_notifiers/side_drawer_notifier.dart';
import '../models/enums/screen_bucket_enum.dart';
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                      lang_settings.SettingsEnglish.hotelNameText,
                      style: TextStyle(
                          fontSize: 20.0
                      )
                  ),
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: const Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  ),
                  // hoverColor: Colors.red,
                  tileColor: _sideDrawerNotifier.selectedPageType == ScreenBuckets.home ? AppColors.ashYellow : null,
                  title: const Text(
                    lang_settings.SettingsEnglish.homeText,
                  ),
                  onTap: () {
                    _sideDrawerNotifier.selectedPageType = ScreenBuckets.home;
                  },
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  ),
                  tileColor: _sideDrawerNotifier.selectedPageType == ScreenBuckets.booking ? AppColors.ashYellow : null,
                  title: const Text(
                    lang_settings.SettingsEnglish.bookingText,
                  ),
                  onTap: () {
                    _sideDrawerNotifier.selectedPageType = ScreenBuckets.booking;
                  },
                ),
                ExpansionPanelList(
                  elevation: 0,
                  expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                  dividerColor: AppColors.black,
                  expansionCallback: (int panelIndex, bool isExpanded) {
                    setState(() {
                      _expansionPanelExpandStatus[panelIndex] = !_expansionPanelExpandStatus[panelIndex];
                    });
                  },
                  children: [
                    ExpansionPanel(
                        backgroundColor: AppColors.goldYellow,
                        canTapOnHeader: true,
                        isExpanded: _expansionPanelExpandStatus[0],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return const ListTile(
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                            ),
                            title: Text(
                              "Accommodation",
                            ),
                          );
                        },
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _sideDrawerNotifier.selectedPageType = ScreenBuckets.accommodation;
                                });
                              },
                              child: const Text(
                                  'Unawatuna'
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                  'Bentota'
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                  'Negombo'
                              ),
                            )
                          ],
                        )
                    ),
                  ],
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  ),
                  title: const Text(
                    "Dining",
                  ),
                  tileColor: _sideDrawerNotifier.selectedPageType == ScreenBuckets.dining ? AppColors.ashYellow : null,
                  onTap: () {
                    setState(() {
                      _sideDrawerNotifier.selectedPageType = ScreenBuckets.dining;
                    });
                  },
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  ),
                  title: const Text(
                    "Gallery",
                  ),
                  tileColor: _sideDrawerNotifier.selectedPageType == ScreenBuckets.galleryPage ? AppColors.ashYellow : null,
                  onTap: () {
                    setState(() {
                      _sideDrawerNotifier.selectedPageType = ScreenBuckets.galleryPage;
                    });
                  },
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  ),
                  title: const Text(
                    "Services",
                  ),
                  tileColor: _sideDrawerNotifier.selectedPageType == ScreenBuckets.services ? AppColors.ashYellow : null,
                  onTap: () {
                    setState(() {
                      _sideDrawerNotifier.selectedPageType = ScreenBuckets.services;
                    });
                  },
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: const BorderRadius.only(topRight: const Radius.circular(15.0), bottomRight: const Radius.circular(15.0))
                  ),
                  title: const Text(
                    "Booking History",
                  ),
                  tileColor: _sideDrawerNotifier.selectedPageType == ScreenBuckets.reservationHistory ? AppColors.ashYellow : null,
                  onTap: () {
                    setState(() {
                      _sideDrawerNotifier.selectedPageType = ScreenBuckets.reservationHistory;
                    });
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
                      "Sign In",
                      style: TextStyle(
                          color: AppColors.goldYellow
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                    },
                  ),
                  const SizedBox(width: 25.0),
                  ElevatedButton(
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: AppColors.goldYellow
                      ),
                    ),
                    onPressed: (){},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
