import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../config/app_colors.dart';
import '../config/language_settings.dart' as lang_settings;
import '../models/change_notifiers/side_drawer_notifier.dart';
import '../models/enums/screen_bucket_enum.dart';

class SideDrawer extends StatefulWidget {
  SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
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
      backgroundColor: AppColors.goldYellow,
        child: Column(
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
              tileColor: AppColors.ashYellow,
              title: const Text(
                lang_settings.SettingsEnglish.homeText,
              ),
              onTap: () {
                _sideDrawerNotifier.selectedPageType = ScreenBuckets.home;
              },
            ),
            const ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
              ),
              title: Text(
                lang_settings.SettingsEnglish.bookingText,
              ),
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

            const ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
              ),
              title: Text(
                "Gallery",
              ),
            ),
            const ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
              ),
              title: Text(
                "Services",
              ),
            ),
            const ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
              ),
              title: Text(
                "Booking History",
              ),
            ),
            const ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
              ),
              title: Text(
                "Contact Us",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0, left: 10.0, right: 10.0),
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
                    onPressed: (){},
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
