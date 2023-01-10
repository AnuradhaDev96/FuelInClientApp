import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/change_notifiers/schedule_task_page_notifier.dart';
import 'production_batch_list_page.dart';

class ScheduleTaskModulePageView extends StatelessWidget {
  const ScheduleTaskModulePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleTaskPageViewNotifier>(
        builder: (BuildContext context, ScheduleTaskPageViewNotifier accessRequestsPageViewNotifier, child) {
          return PageView(
            controller: accessRequestsPageViewNotifier.pageController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            children: [
              ProductionBatchListPage(),
              // MembershipListPage(),
            ],
          );
        }
    );
  }
}