import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/change_notifiers/access_requests_page_view_notifier.dart';
import 'anonymous_access_requests_page.dart';
import 'register_user_for_access_request_page.dart';

class AccessRequestPageView extends StatelessWidget {
  const AccessRequestPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessRequestsPageViewNotifier>(
        builder: (BuildContext context, AccessRequestsPageViewNotifier accessRequestsPageViewNotifier, child) {
          return PageView(
            controller: accessRequestsPageViewNotifier.pageController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            children: [
              const AnonymousAccessRequestsPage(),
              RegisterUserForAccessRequestPage(),
            ],
          );
        }
    );
  }
}
