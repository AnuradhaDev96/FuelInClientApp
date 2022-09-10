import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../models/change_notifiers/checkin_customer_page_view_notifier.dart';
import 'first_reservation_list_page_item.dart';
import 'second_assign_rooms_page_item.dart';

class CheckInReservedCustomer extends StatefulWidget {
  const CheckInReservedCustomer({Key? key}) : super(key: key);

  @override
  State<CheckInReservedCustomer> createState() => _CheckInReservedCustomerState();
}

class _CheckInReservedCustomerState extends State<CheckInReservedCustomer> {
  // late final PageController _pageController;
  late final CheckInCustomerPageViewNotifier _checkInCustomerPageViewNotifier;

  @override
  void initState() {
    // _pageController = PageController();
    _checkInCustomerPageViewNotifier = GetIt.I<CheckInCustomerPageViewNotifier>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInCustomerPageViewNotifier>(
      builder: (BuildContext context, CheckInCustomerPageViewNotifier checkInCustomerPageViewNotifier, child) {
        return PageView(
          controller: checkInCustomerPageViewNotifier.pageController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          children: [
            FirstReservationListPageItem(),
            const SecondAssignRoomsPageItem(),
          ],
        );
      }
    );
  }
}
