import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rh_reader/src/models/reservation/reservation.dart';
import 'package:rh_reader/src/utils/string_extention.dart';

import '../../config/app_colors.dart';
import '../../models/change_notifiers/credit_card_notifier.dart';
import '../../models/change_notifiers/reservation_notifier.dart';
import '../../services/reservation_service.dart';

class ReservationProceedCheckoutDialog extends StatefulWidget {
  const ReservationProceedCheckoutDialog({Key? key, required this.reservationToBeProceeded}) : super(key: key);
  final Reservation reservationToBeProceeded;

  @override
  State<ReservationProceedCheckoutDialog> createState() => _ReservationProceedCheckoutDialogState();
}

class _ReservationProceedCheckoutDialogState extends State<ReservationProceedCheckoutDialog> {
  late final ReservationNotifier _reservationNotifier;
  late final ReservationService _reservationService;
  late final CreditCardNotifier _creditCardNotifier;

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardNoController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvcNoController = TextEditingController();

  @override
  void initState() {
    _reservationNotifier = GetIt.I<ReservationNotifier>();
    _reservationService = GetIt.I<ReservationService>();
    _creditCardNotifier = GetIt.I<CreditCardNotifier>();

    widget.reservationToBeProceeded.includedRooms = _reservationNotifier.includedRoomsForReservationList;

    widget.reservationToBeProceeded.totalCostOfReservation = _reservationService.calculateTotalCostOfOrder(
        widget.reservationToBeProceeded.checkIn!,
        widget.reservationToBeProceeded.checkOut!,
        widget.reservationToBeProceeded.includedRooms!);

    widget.reservationToBeProceeded.noOfNightsReserved = _reservationService.calculateNoOfNightsForReservation(
        widget.reservationToBeProceeded.checkIn!, widget.reservationToBeProceeded.checkOut!);

    widget.reservationToBeProceeded.totalGuests = _reservationService.calculateTotalGuestsForReservation(
        widget.reservationToBeProceeded.includedRooms!);

    widget.reservationToBeProceeded.totalRooms = _reservationService.calculateTotalRoomsForReservation(
        widget.reservationToBeProceeded.includedRooms!);

    // _creditCardNotifier.addListener(() {
    //   _expiryDateController.text = _creditCardNotifier.expiryDate;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text(
          "Summary",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Card(
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.19,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        bottomLeft: Radius.circular(12.0),
                      ),
                      color: AppColors.shiftGray,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Hotel: ${widget.reservationToBeProceeded.hotelName}'
                        ),
                        Text(
                          'No of rooms:  ${widget.reservationToBeProceeded.totalRooms}',
                        ),
                        Text(
                          'No of guests:  ${widget.reservationToBeProceeded.totalGuests}',
                        ),
                        Text(
                          'No of nights:  ${widget.reservationToBeProceeded.noOfNightsReserved}',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.19,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                      color: AppColors.shiftGray,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Check In:  ${DateFormat('yyyy-MM-dd').format(widget.reservationToBeProceeded.checkIn!)}'
                        ),
                        Text(
                            'Check Out:  ${DateFormat('yyyy-MM-dd').format(widget.reservationToBeProceeded.checkOut!)}'
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total Cost:  LKR ${widget.reservationToBeProceeded.totalCostOfReservation}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ),
              ],
            )
          ),
        ),
        // Card(
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: _buildPaymentDetailsForm(),
        //     )
        // ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.5,
          child: _buildPaymentDetailsForm(),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _submitPaymentButton(),
              _declinePaymentButton(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPaymentDetailsForm() {
    return Form(
      key: _formStateKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Customer Information",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Expanded(child: _buildCustomerName()),
              Expanded(child: _buildCustomerEmail()),
            ],
          ),
          const SizedBox(width: 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Payment Information",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Expanded(child: _buildCardNoField()),
              Expanded(child: _buildCardExpiryField()),
              Expanded(child: _buildCVCNoField()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Full name:"
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            height: 35.0,
            child: TextFormField(
              controller: _fullNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Full name cannot be empty';
                }
                return null;
              },
              autofocus: true,
              onChanged: (String emailAddress) {
                // _emailAddressBloc.onChangeEmail(emailAddress);
              },
              style: const TextStyle(fontSize: 12.0),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(width: 1, color: AppColors.darkGrey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: AppColors.darkGrey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: const EdgeInsets.all(8.0),
                hintText: "Full Name",
                hintStyle: const TextStyle(fontSize: 12.0),
                // helperText: ' ',
                // errorText: snapshot.error as String?,

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Email:"
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            height: 35.0,
            child: TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email cannot be empty';
                }
                return null;
              },
              autofocus: true,
              onChanged: (String emailAddress) {
                // _emailAddressBloc.onChangeEmail(emailAddress);
              },
              style: const TextStyle(fontSize: 12.0),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(width: 1, color: AppColors.darkGrey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: AppColors.darkGrey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: const EdgeInsets.all(8.0),
                hintText: "Email",
                hintStyle: const TextStyle(fontSize: 12.0),
                // helperText: ' ',
                // errorText: snapshot.error as String?,

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardNoField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Card Number:"
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            height: 50.0,
            child: TextFormField(
              controller: _cardNoController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Card no cannot be empty';
                }
                if (!value.isInteger) {
                  return 'Enter integer value';
                }
                return null;
              },
              autofocus: true,
              maxLength: 16,
              onChanged: (String emailAddress) {
                // _emailAddressBloc.onChangeEmail(emailAddress);
              },
              style: const TextStyle(fontSize: 12.0),
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(width: 1, color: AppColors.darkGrey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: AppColors.darkGrey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: const EdgeInsets.all(8.0),
                hintText: "xxxx-xxxx-xxxx-xxxx",
                hintStyle: const TextStyle(fontSize: 12.0),
                // helperText: ' ',
                // errorText: snapshot.error as String?,

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardExpiryField() {
    return Consumer<CreditCardNotifier>(
      builder: (BuildContext context, CreditCardNotifier creditCardNotifier, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Expiry Date:  ${creditCardNotifier.expiryDate}"
              ),
              SizedBox(
                width: 120.0,
                height: 50.0,
                child: TextFormField(
                  controller: _expiryDateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Expiry date cannot be empty';
                    }
                    if (!value.isInteger) {
                      return 'Enter numbers only';
                    }
                    return null;
                  },
                  autofocus: true,
                  maxLength: 4,
                  onChanged: (String value) {
                    creditCardNotifier.setExpiryDate(value);
                  },
                  style: const TextStyle(fontSize: 12.0),
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(width: 1, color: AppColors.darkGrey)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: AppColors.darkGrey),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: const EdgeInsets.all(8.0),
                    hintText: "xx/xx",
                    hintStyle: const TextStyle(fontSize: 12.0),
                    // helperText: ' ',
                    // errorText: snapshot.error as String?,

                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildCVCNoField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "CVC:"
          ),
          SizedBox(
            width: 120.0,
            height: 50.0,
            child: TextFormField(
              controller: _cvcNoController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'cvc no cannot be empty';
                }
                if (!value.isInteger) {
                  return 'Enter integer value';
                }
                return null;
              },
              autofocus: true,
              maxLength: 3,
              onChanged: (String emailAddress) {
                // _emailAddressBloc.onChangeEmail(emailAddress);
              },
              style: const TextStyle(fontSize: 12.0),
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(width: 1, color: AppColors.darkGrey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: AppColors.darkGrey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: const EdgeInsets.all(8.0),
                hintText: "000",
                hintStyle: const TextStyle(fontSize: 12.0),
                // helperText: ' ',
                // errorText: snapshot.error as String?,

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitPaymentButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        // style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        //     shape: MaterialStateProperty.all(
        //       RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(4.0),
        //       ),
        //     ),
        //   // backgroundColor:
        // ),
        onPressed: proceedPaymentAction,
        child: const Text(
          "Proceed Payment",
          style: TextStyle(color: AppColors.goldYellow, fontSize: 16.0),
        ),
      ),
    );
  }

  void proceedPaymentAction() async {
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(true);
    });
  }

  Widget _declinePaymentButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            // shape: MaterialStateProperty.all(
            //   RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(4.0),
            //   ),
            // ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.ashYellow
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        child: const Text(
          "Go back",
          style: TextStyle(color: AppColors.indigoMaroon, fontSize: 16.0),
        ),
      ),
    );
  }

}
