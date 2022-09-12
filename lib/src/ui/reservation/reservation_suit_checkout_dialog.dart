import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../../utils/string_extention.dart';

import '../../config/app_colors.dart';
import '../../models/change_notifiers/credit_card_notifier.dart';
import '../../models/reservation/reservation_suit.dart';
import '../../services/reservation_service.dart';
import '../../utils/message_utils.dart';

class ReservationSuitCheckoutDialog extends StatefulWidget {
  const ReservationSuitCheckoutDialog({Key? key, required this.reservationSuitToBeProceeded}) : super(key: key);
  final ReservationSuit reservationSuitToBeProceeded;

  @override
  State<ReservationSuitCheckoutDialog> createState() => _ReservationSuitCheckoutDialogState();
}

class _ReservationSuitCheckoutDialogState extends State<ReservationSuitCheckoutDialog> {
  late final ReservationService _reservationService;

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardNoController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvcNoController = TextEditingController();

  @override
  void initState() {
    _reservationService = GetIt.I<ReservationService>();
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
                            'Hotel: ${widget.reservationSuitToBeProceeded.hotelName}'
                          ),
                          Text(
                            'Subscription:  ${widget.reservationSuitToBeProceeded.reservationSuitType}',
                          ),
                          Text(
                            'Cost:  LKR ${widget.reservationSuitToBeProceeded.totalCost}',
                          ),
                        ],
                      ),
                    ),
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
          style: TextStyle(color: AppColors.nppPurple, fontSize: 16.0),
        ),
      ),
    );
  }

  void proceedPaymentAction() async {
    if (_formStateKey.currentState!.validate()) {
      _formStateKey.currentState!.save();
      widget.reservationSuitToBeProceeded.customerName = _fullNameController.text;
      widget.reservationSuitToBeProceeded.customerEmail = _emailController.text;
      // Reservation reservation = Reservation(hotelName: hotelName, checkIn: checkIn, checkOut: checkOut)
      final bool result = await _reservationService.createReservationSuitByCustomer(widget.reservationSuitToBeProceeded);
      if (result) {
        // await EmailJsUtil.sendPaymentConfirmedForGeneralReservation(widget.reservationToBeProceeded).then((int statusCode) {
        //   if (statusCode == 200) {
        //     dismissDialog(true);
        //     showCreateReservationMessage(true);
        //   } else {
        //     showConfirmationEmailForReservationLaterMessage();
        //   }
        // });

        //test
        dismissDialog(true);
        showCreateReservationSuitMessage(true);
      } else {
        showCreateReservationSuitMessage(false);
      }
    }

  }

  void dismissDialog(bool returnValue) {
    Navigator.of(context).pop(returnValue);
  }

  void showConfirmationEmailForSuitReservationLaterMessage() {
    MessageUtils.showSuccessInFlushBar(context,
        "Thank you! Reservation suit subscribed and email will be been sent to ${widget.reservationSuitToBeProceeded.customerEmail} later.",
        appearFromTop: false, duration: 4);
  }

  void showCreateReservationSuitMessage(bool statusOfRequest) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context,
        "Thank you! Confirmation email of suit reservation has been sent to ${widget.reservationSuitToBeProceeded.customerEmail} ",
        appearFromTop: false, duration: 4)
        : MessageUtils.showErrorInFlushBar(context, "Reservation suit subscription failed.", appearFromTop: false, duration: 4);
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
          style: TextStyle(color: AppColors.silverPurple, fontSize: 16.0),
        ),
      ),
    );
  }

}
