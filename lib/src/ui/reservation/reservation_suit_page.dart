import 'package:flutter/material.dart';
import 'package:matara_division_system/src/models/enums/reservation_suit_type.dart';
import 'package:matara_division_system/src/models/reservation/reservation_suit.dart';
import 'package:matara_division_system/src/ui/reservation/reservation_suit_checkout_dialog.dart';

import '../../config/app_colors.dart';
import '../../utils/general_dialog_utils.dart';

class ReservationSuitePage extends StatelessWidget {
  ReservationSuitePage({Key? key}) : super(key: key);

  final ValueNotifier selectedHotelValue = ValueNotifier<String>("Unawatuna");
  final ReservationSuit _reservationSuitToBeProceeded = ReservationSuit(hotelName: "Unawatuna");

  final List<String> _hotelBranches = <String>[
    'Unawatuna',
    'Bentota',
    'Negombo',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.shiftGray,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              )
            ),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Select Hotel for Suite: ",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12.0),
                ValueListenableBuilder(
                  valueListenable: selectedHotelValue,
                  builder: (context, snapshot, child) {
                    return DropdownButton(
                      value: selectedHotelValue.value,
                      isExpanded: false,
                      hint: const Text(
                          'Select hotel'
                      ),
                      items: _hotelBranches.map((branch) => DropdownMenuItem(
                        value: branch,
                        child: Text(
                          branch,
                        ),
                      )).toList(),
                      onChanged: (selectedValue){
                        selectedHotelValue.value = selectedValue.toString();
                      },
                    );
                  }
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Card(
                elevation: 5,
                color: AppColors.lightGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(
                    color: AppColors.ashYellow,
                    width: 5.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ReservationSuitType.weekly.toDisplayString(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Subscribe to our weekly reservation suit'
                      ),
                      const SizedBox(height: 15.0),
                      const Text(
                        'LKR 38,000.00 per week',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      _buildSubscribeButton(context, subscriptionType: ReservationSuitType.weekly),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Card(
                elevation: 5,
                color: AppColors.lightGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(
                    color: AppColors.ashYellow,
                    width: 5.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ReservationSuitType.monthly.toDisplayString(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                          'Subscribe to our monthly reservation suit'
                      ),
                      const SizedBox(height: 15.0),
                      const Text(
                        'LKR 160,000.00 per month',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      _buildSubscribeButton(context, subscriptionType: ReservationSuitType.monthly),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSubscribeButton(BuildContext context, {required ReservationSuitType subscriptionType}) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        // backgroundColor: Colors.blue,
      ),
      onPressed: () => proceedToCheckoutReservation(context, subscriptionType),
      child: const Text(
        "Subscribe Now",
        style: TextStyle(color: AppColors.darkPurple, fontSize: 14.0),
      ),
    );
  }

  void proceedToCheckoutReservation(BuildContext context, ReservationSuitType subscriptionType) async {
    _reservationSuitToBeProceeded.reservationSuitType = subscriptionType.toDisplayString();
    _reservationSuitToBeProceeded.hotelName = selectedHotelValue.value;
    _reservationSuitToBeProceeded.totalCost = subscriptionType == ReservationSuitType.weekly ? 38000.00 : 160000.00;
    bool isPaymentDone = await GeneralDialogUtils().showCustomGeneralDialog(
      context: context,
      child: ReservationSuitCheckoutDialog(reservationSuitToBeProceeded: _reservationSuitToBeProceeded),
      title: "Proceed Checkout",
    );
  }

}
