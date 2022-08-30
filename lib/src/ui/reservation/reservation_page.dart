import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:rh_reader/src/models/accommodation/accommodation.dart';
import 'package:rh_reader/src/models/reservation/reservation.dart';

import '../../config/app_colors.dart';
import '../../services/accommodation_service.dart';
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
  List<RoomForReservationModel>? _includedRoomsForReservation;
  late final AccommodationService _accommodationService;

  String selectedHotel = 'Unawatuna';
  DateTime? selectedCheckInDate;
  List<String> hotelBranches = <String>[
    'Unawatuna',
    'Bentota',
    'Negombo',
  ];

  @override
  void initState() {
    _accommodationService = GetIt.I<AccommodationService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
              // height: MediaQuery.of(context).size.height * 0.345,
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
                  // TODO: Implement stream based on search giving branch params
                  StreamBuilder(
                    stream: _accommodationService.getAccommodationsStream(),
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
                        // employeeList = snapshot.data ?? <EmployeeModel>[];
                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((data) => searchItemBuilder(context, data)).toList(),
                        );
                        // return Text("Error: ${snapshot.error}");
                      }
                      return const Text("No rooms available");
                    },
                  ),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: availableAccommodationsList.length,
                  //   itemBuilder: searchItemBuilder
                  // )
                ],
              ),
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.28,
            //   // height: MediaQuery.of(context).size.height * 0.345,
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       const Text(
            //         "Available Rooms",
            //         style: TextStyle(
            //           fontSize: 14.0,
            //         ),
            //       ),
            //       Container(color: AppColors.indigoMaroon,height: 2.0,),
            //       ListView.builder(
            //           shrinkWrap: true,
            //           itemCount: availableAccommodationsList.length,
            //           itemBuilder: searchItemBuilder
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ],
    );
  }

  Widget searchItemBuilder(BuildContext context, DocumentSnapshot data) {
    final accommodation = Accommodation.fromSnapshot(data);
    int totalRooms = accommodation.noOfRooms ?? 0;
    int reservedRoomCount = accommodation.reservedRoomCount ?? 0;
    int availableRoomCount = totalRooms - reservedRoomCount;

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AppColors.ashBlue,
                      ),
                      child: Text(
                        "$availableRoomCount rooms available",
                        style: const TextStyle(
                          color: AppColors.goldYellow,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AppColors.ashMaroon,
                      ),
                      child: Text(
                        "$totalRooms total rooms",
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AppColors.ashMaroon,
                      ),
                      child: Text(
                        "Floor No: ${accommodation.floorNo}",
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AppColors.ashMaroon,
                      ),
                      child: Text(
                        accommodation.size == null ? "Size: N/A" : "Size: ${accommodation.size} m²",
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AppColors.shiftGray,
                      ),
                      child: Text(
                        "LKR ${accommodation.rateInLkr}",
                        style: const TextStyle(
                          color: AppColors.indigoMaroon,
                          fontSize: 12.0,
                        ),
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
