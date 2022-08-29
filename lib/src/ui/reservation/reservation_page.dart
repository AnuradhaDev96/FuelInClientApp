import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rh_reader/src/models/accommodation/accommodation.dart';

import '../../config/app_colors.dart';
import '../widgets/custom_input_field.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final List<Accommodation> availableAccommodationsList = Accommodation.systemRoomList;
  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkOutDateController = TextEditingController();
  // TextEditingController checkOutDateController = TextEditingController();

  String selectedHotel = 'Unawatuna';
  DateTime? selectedCheckInDate;
  List<String> hotelBranches = <String>[
    'Unawatuna',
    'Bentota',
    'Negombo',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.74,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
            child: Container(
              color: AppColors.shiftGray,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hotel",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      DropdownButton(
                        value: selectedHotel,
                        isExpanded: false,
                        hint: const Text(
                            'Select hotel'
                        ),
                        items: hotelBranches.map((branch) => DropdownMenuItem(
                          value: branch,
                          child: Text(
                            branch,
                          ),
                        )).toList(),
                        onChanged: (selectedValue){
                          setState(() {
                            selectedHotel = selectedValue.toString();
                            print(selectedHotel);
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Check In Date",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      Material(
                        child: CustomInputField(
                          borderRadius: 14.0,
                          borderColor: AppColors.lightGray,
                          width: 0.12,
                          height: 0.05,
                          icon: Icons.calendar_month,
                          iconColor: AppColors.indigoMaroon,
                          hintText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          hintColor: AppColors.indigoMaroon,
                          fontSize: 15,
                          obsecureText: false,
                          textEditingController: checkInDateController,
                          onPressedAction: onTapCheckInDateField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Check Out Date",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      Material(
                        child: CustomInputField(
                          borderRadius: 14.0,
                          borderColor: AppColors.lightGray,
                          width: 0.12,
                          height: 0.05,
                          icon: Icons.calendar_month,
                          iconColor: AppColors.indigoMaroon,
                          hintText: DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1))),
                          hintColor: AppColors.indigoMaroon,
                          fontSize: 15,
                          obsecureText: false,
                          textEditingController: checkOutDateController,
                          onPressedAction: onTapCheckOutDateField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8.0),
                  SizedBox(
                    width: 100.0,
                    height: 40.0,
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        )
                      ),
                      child: const Text(
                        "Search",
                        style: TextStyle(
                            color: AppColors.lightGray
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.28,
                height: MediaQuery.of(context).size.height * 0.345,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Available Rooms",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Container(color: AppColors.indigoMaroon,height: 2.0,),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: availableAccommodationsList.length,
                        itemBuilder: searchItemBuilder
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget searchItemBuilder(BuildContext context, int index) {
    final accommodation = availableAccommodationsList[index];

    return Card(
      elevation: 5,
      color: AppColors.lightGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: AppColors.indigoMaroon,
                  width: 200.0,
                  height: 25.0,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    accommodation.roomName ?? "-",
                    style: const TextStyle(
                        color: AppColors.goldYellow
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    const Text(
                      "No of rooms:",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      "${accommodation.noOfRooms}",
                      style: const TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Floor Number: ",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      "${accommodation.floorNo}",
                      style: const TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Size of room: ",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      "${accommodation.size}",
                      style: const TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              child: const Text(
                "Add",
                style: TextStyle(
                    color: AppColors.lightGray
                ),
              ),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  void onTapCheckInDateField() async {
    DateTime? checkInDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
        // selectableDayPredicate: (DateTime val) =>
        // val.compareTo(DateTime.now()) > 0 ? true : false
    );

    if (checkInDate != null) {
      checkInDateController.text = DateFormat('yyyy-MM-dd').format(checkInDate);
      checkOutDateController.text = DateFormat('yyyy-MM-dd').format(checkInDate.add(const Duration(days: 1)));
      selectedCheckInDate = checkInDate;
    }
  }

  void onTapCheckOutDateField() async {
    DateTime? checkOutDate = await showDatePicker(
      context: context,
      initialDate: selectedCheckInDate != null
          ? selectedCheckInDate!.add(const Duration(days: 1))
          : DateTime.now().add(const Duration(days: 1)),
      firstDate: selectedCheckInDate != null ? selectedCheckInDate!.add(const Duration(days: 1)) : DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (checkOutDate != null) {
      // checkInDateController.text = DateFormat('yyyy-MM-dd').format(checkInDate);
      checkOutDateController.text = DateFormat('yyyy-MM-dd').format(checkOutDate);
      // selectedCheckInDate = checkInDate;
    }

  }

}
