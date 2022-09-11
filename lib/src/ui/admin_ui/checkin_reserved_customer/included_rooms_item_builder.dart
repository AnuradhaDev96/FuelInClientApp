import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:rh_reader/src/models/accommodation/accommodation.dart';
import 'package:rh_reader/src/models/reservation/reservation.dart';

import '../../../config/app_colors.dart';
import '../../../models/change_notifiers/checkin_customer_page_view_notifier.dart';
import '../../../services/accommodation_service.dart';

class IncludedRoomsItemBuilder extends StatelessWidget {
  IncludedRoomsItemBuilder({Key? key, required this.room}) : super(key: key);
  final RoomForReservationModel room;
  final AccommodationService _accommodationService = GetIt.I<AccommodationService>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.lightGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Requested name:",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "${room.roomName}",
                  style: const TextStyle(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2.0),
            Row(
              children: [
                const Text(
                  "Requested room count:",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "${room.roomCountForOrder}",
                  style: const TextStyle(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2.0),
            Row(
              children: [
                const Text(
                  "Guest Count:",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "${room.noOfGuests}",
                  style: const TextStyle(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2.0),
            FutureBuilder(
              future: _accommodationService.getAccommodationByReference(room.accommodationReference),
              builder: (BuildContext context, AsyncSnapshot<Accommodation?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: AppColors.indigoMaroon,
                          ),
                        )),
                  );
                } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                  return const Text("No rooms requested.");
                } else if (snapshot.hasData) {
                  Accommodation accommodation = snapshot.data!;
                  if (accommodation.roomNumbers == null || accommodation.roomNumbers!.isEmpty) {
                    return const Text("No rooms requested.");
                  }
                  return Container(
                    height: 60.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          width: 2.0,
                          color: AppColors.indigoMaroon,
                        )
                    ),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.trackpad,
                      }),
                      child: Scrollbar(
                        controller: _scrollController,
                        child: ListView(
                          controller: _scrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          // itemCount: _roomNumbersList.value.length,
                          // itemBuilder: ,
                          children: accommodation.roomNumbers!.map((roomNumber) => roomNumbersChipBuilder(context, roomNumber)).toList(),
                        ),
                      ),
                    ),
                  );
                }
                return const Text("No rooms requested.");
              },
            )
          ],
        ),
      ),
    );
  }

  Widget roomNumbersChipBuilder(BuildContext context, int roomNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Consumer<CheckInCustomerPageViewNotifier>(
        builder: (BuildContext context, CheckInCustomerPageViewNotifier checkInCustomerPageViewNotifier, child) {
          return ChoiceChip(
            backgroundColor: AppColors.ashMaroon,
            padding: const EdgeInsets.all(4.0),
            label: Text("$roomNumber"),
            elevation: 4.0,
            selected: checkInCustomerPageViewNotifier.assignedRoomNumberList.contains(roomNumber),
            selectedColor: AppColors.enabledGreenColor,
          avatar: checkInCustomerPageViewNotifier.assignedRoomNumberList.contains(roomNumber)
              ? const CircleAvatar(
                  radius: 15.0,
                  child: Icon(
                    Icons.check,
                    size: 14.0,
                  ),
                )
              : null,
          pressElevation: 5.0,
            onSelected: (bool selected) {
              if (checkInCustomerPageViewNotifier.assignedRoomNumberList.contains(roomNumber)) {
                checkInCustomerPageViewNotifier.removeRoomNumberFromRoomNumberList(roomNumber);
              } else {
                checkInCustomerPageViewNotifier.assignNewRoomNumberToRoomNumberList(roomNumber);
              }
            },

          );
        }
      ),
    );
  }
}
