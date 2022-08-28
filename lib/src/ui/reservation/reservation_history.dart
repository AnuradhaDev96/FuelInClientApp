import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../models/enums/branch_name.dart';
import '../../models/reservation/reservation.dart';

class ReservationHistory extends StatelessWidget {
  ReservationHistory({Key? key}) : super(key: key);
  final List<Reservation> reservationHistoryList = [
    Reservation(
      refUserID: "User001",
      noOfRooms: 2,
      roomId: "R001",
      roomName: "Presidential Suite",
      checkIn: "2022-06-20",
      checkOut: "2022-06-21",
      hotelName: BranchNames.bentota.toDisplayString(),
      noOfGuests: 4
    ),
    Reservation(
        refUserID: "User001",
        noOfRooms: 1,
        roomId: "R002",
        roomName: "Superior Room",
        checkIn: "2022-08-15",
        checkOut: "2022-08-16",
        hotelName: BranchNames.negombo.toDisplayString(),
        noOfGuests: 4
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: ListView.builder(
          itemCount: reservationHistoryList.length,
          itemBuilder: serviceItemBuilder,
        ),
      ),
    );
  }

  Widget serviceItemBuilder(BuildContext context, int index) {
    final reservation = reservationHistoryList[index];

    return Card(
      elevation: 5,
      color: AppColors.lightGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: AppColors.indigoMaroon,
              width: 150.0,
              height: 100.0,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: reservation.hotelName,
                    style: const TextStyle(
                        color: AppColors.ashYellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Checked In: ",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      reservation.checkIn,
                      style: const TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Checked Out: ",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      reservation.checkOut,
                      style: const TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Room Name: ",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      reservation.roomName,
                      style: const TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "No of rooms: ",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      "${reservation.noOfRooms}",
                      style: const TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Guests count: ",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      "${reservation.noOfGuests}",
                      style: const TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
