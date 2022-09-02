import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/app_colors.dart';
import '../../models/enums/branch_name.dart';
import '../../models/reservation/reservation.dart';

class ReservationHistory extends StatelessWidget {
  ReservationHistory({Key? key}) : super(key: key);
  final List<Reservation> reservationHistoryList = [
    Reservation(
      customerName: "User001",
      checkIn: DateTime(2022,6,20),
      checkOut: DateTime(2022,6,21),
      hotelName: BranchNames.bentota.toDisplayString(),
    ),
    Reservation(
      customerName: "User001",
      checkIn: DateTime(2022,8,15),
      checkOut: DateTime(2022,8,16),
      hotelName: BranchNames.negombo.toDisplayString(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: ListView.builder(
        itemCount: reservationHistoryList.length,
        itemBuilder: serviceItemBuilder,
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
                      DateFormat('yyyy-MM-dd').format(reservation.checkIn!) ,
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
                      DateFormat('yyyy-MM-dd').format(reservation.checkOut!),
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
