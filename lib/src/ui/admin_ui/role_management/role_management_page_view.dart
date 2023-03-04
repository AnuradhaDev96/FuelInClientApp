import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/change_notifiers/role_management_notifier.dart';
import 'permission_management_page.dart';
import 'role_management_list_page.dart';
// inventory
class FuelStationManagementPageView extends StatelessWidget {
  const FuelStationManagementPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RoleManagementNotifier>(
        builder: (BuildContext context, RoleManagementNotifier roleManagementNotifier, child) {
          return PageView(
            controller: roleManagementNotifier.pageController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            children: [
              FuelStationsListPage(),
              PermissionManagementPage(),
            ],
          );
        }
    );
  }
}
