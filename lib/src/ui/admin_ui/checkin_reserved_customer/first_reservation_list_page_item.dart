import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../models/change_notifiers/checkin_customer_page_view_notifier.dart';
import '../../../models/reservation/reservation.dart';
import '../../../services/reservation_service.dart';

class FirstReservationListPageItem extends StatelessWidget {
  FirstReservationListPageItem({Key? key}) : super(key: key);

  final ReservationService _reservationService = GetIt.I<ReservationService>();
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: StreamBuilder(
            stream: _reservationService.getGeneralReservationsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                //InteractiveViewer for zooming
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  child: Scrollbar(
                    controller: _horizontalScrollController,
                    scrollbarOrientation: ScrollbarOrientation.top,
                    // trackVisibility: true,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _horizontalScrollController,
                      child: DataTable(
                        headingTextStyle: const TextStyle(fontSize: 12.0, fontFamily: "Oswald", fontWeight: FontWeight.bold),
                        dataTextStyle: const TextStyle(fontSize: 12.0, fontFamily: "Oswald"),
                        headingRowColor: MaterialStateProperty.all(AppColors.ashYellow),
                        columns: const [
                          DataColumn(label: Text('Assign Rooms')),
                          DataColumn(label: Text('Hotel Name')),
                          DataColumn(label: Text('Customer Name')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Check In')),
                          DataColumn(label: Text('Check Out')),
                          DataColumn(label: Text('Room Count')),
                          DataColumn(label: Text('No of Nights')),
                          DataColumn(label: Text('Total Cost')),
                        ],
                        rows: snapshot.data!.docs.map((data) => generalReservationItemBuilder(context, data)).toList(),
                      ),
                    ),
                  ),
                );
              }
              return const Text("No reservations available");
            },
          ),
        ),
      ],
    );
  }

  DataRow generalReservationItemBuilder(BuildContext context, DocumentSnapshot data) {
    final reservation = Reservation.fromSnapshot(data);

    return DataRow(cells: [

      DataCell(
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              )
          ),
          onPressed: () {},
          child: const Text(
            "Select",
            style: TextStyle(color: AppColors.goldYellow, fontSize: 14.0),
          ),
        ),
      ),
      DataCell(Text(reservation.hotelName)),
      DataCell(Text(reservation.customerName ?? "-")),
      DataCell(Text(reservation.customerEmail ?? "-")),
      DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkIn!))),
      DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkOut!))),
      DataCell(Text("${reservation.totalRooms ?? 0}")),
      DataCell(Text("${reservation.noOfNightsReserved ?? 0}")),
      DataCell(Text("${reservation.totalCostOfReservation ?? 0}")),
    ]);
  }

  Widget _buildToBillingButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<CheckInCustomerPageViewNotifier>(context, listen: false).jumpToNextPage();
      },
      child: const Text(
        "Next",
        style: TextStyle(color: AppColors.goldYellow, fontSize: 14.0),
      ),
    );
  }
}
