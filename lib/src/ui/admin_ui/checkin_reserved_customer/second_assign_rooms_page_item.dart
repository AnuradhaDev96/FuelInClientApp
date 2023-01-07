import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../models/change_notifiers/checkin_customer_page_view_notifier.dart';
import '../../../models/reservation/reservation.dart';
import 'included_rooms_item_builder.dart';

class SecondAssignRoomsPageItem extends StatelessWidget {
  const SecondAssignRoomsPageItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInCustomerPageViewNotifier>(
        builder: (BuildContext context, CheckInCustomerPageViewNotifier checkInCustomerPageViewNotifier, child) {
      if (checkInCustomerPageViewNotifier.reservationToBeCheckIn == null) {
        return Column(
          children: [
            const Text("An error occurred please go back!"),
            const SizedBox(height: 5.0),
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  )),
              onPressed: () {
                checkInCustomerPageViewNotifier.jumpToPreviousPage();
              },
              child: const Text(
                "Back to Reservations Page",
                style: TextStyle(color: AppColors.darkPurple, fontSize: 14.0),
              ),
            ),
          ],
        );
      }
      Reservation reservation = checkInCustomerPageViewNotifier.reservationToBeCheckIn!;
      return ListView(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 80.0,
              color: AppColors.ashMaroon,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Hotel: ${reservation.hotelName}",
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        "Customer: ${reservation.customerName}",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Total rooms: ${reservation.totalRooms}",
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        "Total Guests: ${reservation.totalGuests}",
                      ),
                    ],
                  ),
                ],
              )),
          (reservation.includedRooms == null || reservation.includedRooms!.isEmpty)
              ? const Center(child: Text("No rooms requested"))
              : _roomAssigningPool(context, reservation, checkInCustomerPageViewNotifier),
          // ListView.builder(
          //   itemCount: reservation.includedRooms!.length,
          //   itemBuilder: _includedRoomsItemBuilder
          // ),
        ],
      );
    });
  }

  Widget _roomAssigningPool(BuildContext context, Reservation reservation, CheckInCustomerPageViewNotifier checkInCustomerPageViewNotifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.42,
              child: ListView(
                shrinkWrap: true,
                children: reservation.includedRooms!.map((room) => IncludedRoomsItemBuilder(room: room)).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Assigned Rooms"),
            Container(color: AppColors.silverPurple,height: 2.0,width: MediaQuery.of(context).size.width * 0.2,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: ListView(
                shrinkWrap: true,
                children: checkInCustomerPageViewNotifier.assignedRoomNumberList
                    .map((assignedRoomNumber) => _assignedRoomsItemBuilder(assignedRoomNumber))
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _assignedRoomsItemBuilder(int roomNumber) {
    return Container(
      height: 40.0,
      // width: 30.0,
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.all(Radius.circular(15.0)),
        border: Border(
          left: BorderSide(
            color: AppColors.silverPurple,
            width: 10.0,
          ),
          right: BorderSide(
            color: AppColors.silverPurple,
            width: 10.0,
          ),
        ),
        color: AppColors.ashYellow
      ),
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          "$roomNumber"
        ),
      ),
    );
  }
}
