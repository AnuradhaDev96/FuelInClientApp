import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/change_notifiers/administrative_units_change_notifer.dart';

// import '../../admin_ui/membership/membership_list_page.dart';
import '../membership/membership_list_page.dart';
import 'administrative_divisions_list.dart';

class SeatOrgAdministrativeUnitsPageView extends StatelessWidget {
  const SeatOrgAdministrativeUnitsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AdministrativeUnitsChangeNotifier>(
        builder: (BuildContext context, AdministrativeUnitsChangeNotifier accessRequestsPageViewNotifier, child) {
          return PageView(
            controller: accessRequestsPageViewNotifier.pageController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            children: [
              PermissionBasedAdministrativeDivListWidget(),
              MembershipListPage(),
            ],
          );
        }
    );
  }
}
