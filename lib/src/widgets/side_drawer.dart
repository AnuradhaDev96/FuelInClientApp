import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../config/language_settings.dart' as lang_settings;

class SideDrawer extends StatefulWidget {
  SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final List<bool> _expansionPanelExpandStatus = <bool>[true];

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
            const ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
              ),
              // hoverColor: Colors.red,
              tileColor: AppColors.ashYellow,
              title: Text(
                lang_settings.SettingsEnglish.homeText,
              ),
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
                          onTap: () {},
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
