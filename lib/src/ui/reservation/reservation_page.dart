import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rh_reader/src/models/accommodation/accommodation.dart';
import 'package:rh_reader/src/models/reservation/reservation.dart';
import 'package:rh_reader/src/services/reservation_service.dart';
import 'package:rh_reader/src/ui/reservation/reservation_proceed_checkout_dialog.dart';
import 'package:rh_reader/src/utils/general_dialog_utils.dart';

import '../../config/app_colors.dart';
import '../../models/change_notifiers/accommodation_search_result_notifier.dart';
import '../../models/change_notifiers/reservation_notifier.dart';
import '../../services/accommodation_service.dart';
import '../widgets/custom_input_field.dart';
import 'room_for_reservation_item_builder.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  // main search results
  List<Accommodation>? availableAccommodationsList;
  bool _isAccommodationSearchLoading = false;

  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkOutDateController = TextEditingController();
  // TextEditingController checkOutDateController = TextEditingController();
  List<RoomForReservationModel> _includedRoomsForReservationList = [];
  late final ReservationNotifier _reservationNotifier;
  late final AccommodationService _accommodationService;
  late final ReservationService _reservationService;
  late final AccommodationSearchResultNotifier _accommodationSearchResultNotifier;

  String selectedHotel = 'Unawatuna';
  late DateTime _selectedCheckInDate, _selectedCheckoutDate;
  double? _totalCostForReservation;
  int? _noOfNightsForReservation;

  //TODO: load initial accommodation list by giving checkin/out dates
  late Reservation _reservationToBeProceeded;
  // bool _isTotalCostPanelVisible = false;

  List<String> hotelBranches = <String>[
    'Unawatuna',
    'Bentota',
    'Negombo',
  ];

  @override
  void initState() {
    _accommodationService = GetIt.I<AccommodationService>();
    _reservationNotifier = GetIt.I<ReservationNotifier>();
    _reservationService = GetIt.I<ReservationService>();
    _accommodationSearchResultNotifier = GetIt.I<AccommodationSearchResultNotifier>();

    _reservationNotifier.addListener(() {
      _includedRoomsForReservationList = _reservationNotifier.includedRoomsForReservationList;
      // _isTotalCostPanelVisible = _reservationNotifier.isTotalCostEditedAfterCalculation;
    });

    //initial checkInDate and checkOut are following until user changes
    _selectedCheckInDate = DateTime.now();
    _selectedCheckoutDate = DateTime.now().add(const Duration(days: 1));
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   _asyncMethod();
    // });

    _reservationToBeProceeded = Reservation(
      hotelName: selectedHotel,
      checkIn: _selectedCheckInDate,
      checkOut: _selectedCheckoutDate,
    );

    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   getData();
    // });
    super.initState();

  }

  Future<void> _searchAccommodationsByHotelAndCheckIn() async {
    setState((){
      _isAccommodationSearchLoading = true;
    });
    await _accommodationService.getAccommodationsListBasedOnReservations(selectedHotel, _selectedCheckInDate).then((accommodationResultsList) {
      setState(() {
        if (availableAccommodationsList != null) {
          availableAccommodationsList!.clear();
          availableAccommodationsList = List.from(accommodationResultsList);
        } else {
          availableAccommodationsList = <Accommodation>[];
          availableAccommodationsList = List.from(accommodationResultsList);
        }
        _isAccommodationSearchLoading = false;
      });
    });

  }

  @override
  void dispose() {
    _includedRoomsForReservationList.clear();
    if (availableAccommodationsList != null) {
      availableAccommodationsList!.clear();
    }
    super.dispose();
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
                    onPressed: _searchAccommodationsByHotelAndCheckIn,
                    child: const Text(
                      "Search",
                      style: TextStyle(
                          color: AppColors.lightGray
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  // StreamBuilder(
                  //   stream: _accommodationService.getAccommodationsStream(),
                  //   builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const Center(
                  //         child: Padding(
                  //             padding: EdgeInsets.all(8.0),
                  //             child: SizedBox(
                  //               width: 40,
                  //               height: 40,
                  //               child: CircularProgressIndicator(
                  //                 strokeWidth: 1,
                  //                 color: AppColors.indigoMaroon,
                  //               ),
                  //             )),
                  //       );
                  //     } else if (snapshot.hasError) {
                  //       return Text("Error: ${snapshot.error}");
                  //     } else if (snapshot.hasData) {
                  //       // employeeList = snapshot.data ?? <EmployeeModel>[];
                  //       return ListView(
                  //         shrinkWrap: true,
                  //         children: snapshot.data!.docs.map((data) => searchItemBuilder(context, data)).toList(),
                  //       );
                  //       // return Text("Error: ${snapshot.error}");
                  //     }
                  //     return const Text("No rooms available");
                  //   },
                  // ),
                  _isAccommodationSearchLoading
                      ? const Center(
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
                        )
                      : availableAccommodationsList == null
                          ? const Text("Please search for rooms.")
                          : availableAccommodationsList!.isEmpty
                              ? const Text("No rooms available for search")
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: availableAccommodationsList!.length,
                                  itemBuilder: searchItemBuilder),
                ],
              ),
            ),
            const SizedBox(width: 15.0),
            (_includedRoomsForReservationList.isEmpty)
              ? const SizedBox(
                  width: 0,
                  height: 0,
                )
              : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Selected Rooms",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Container(
                          color: AppColors.indigoMaroon,
                          height: 2.0,
                        ),
                        ListView.builder(
                          key: Key(_includedRoomsForReservationList.length.toString()),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          itemCount: _includedRoomsForReservationList.length,
                          itemBuilder: (context, index) => RoomForReservationItemBuilder(
                            roomForReservationModel: _includedRoomsForReservationList[index],
                            indexOfRoomForReservation: index,
                          ),
                        ),
                      ],
                    ),
                  ),
            // const SizedBox(width: 15.0),
            const SizedBox(width: 15.0),
            (_includedRoomsForReservationList.isEmpty)
              ? const SizedBox(
            width: 0,
            height: 0,
          )
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Final Cost",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      Container(color: AppColors.indigoMaroon,height: 2.0,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          child: const Text(
                            "Calculate Total",
                            style: TextStyle(
                                color: AppColors.goldYellow
                            ),
                          ),
                          onPressed: () => calculateTotalCost(),
                        ),
                      ),
                      Consumer<ReservationNotifier>(
                        builder: (BuildContext context, ReservationNotifier reservationNotifier, child) {
                          return Visibility(
                            visible: reservationNotifier.isTotalCostPanelVisible,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Card(
                                elevation: 5.0,
                                color: AppColors.lightGray,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "*dates and hotel are above choices",
                                            style: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic),
                                          ),
                                          const Text(
                                            "**total room cost X number of nights",
                                            style: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "No of nights: ",
                                                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "$_noOfNightsForReservation",
                                                style: const TextStyle(fontSize: 14.0),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Total Cost:  LKR ",
                                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "$_totalCostForReservation",
                                                style: const TextStyle(fontSize: 14.0),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5.0),
                                          ElevatedButton(
                                            child: const Text(
                                              "Proceed to checkout",
                                              style: TextStyle(
                                                  color: AppColors.goldYellow
                                              ),
                                            ),
                                            onPressed: () => proceedToCheckoutReservation(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                      ],
                  ),
               )
          ],
        ),
      ],
    );
  }

  // Widget searchItemBuilder(BuildContext context, Accommodation data) {
  Widget searchItemBuilder(BuildContext context, int index) {

    // print("render item stat: ${data.roomName}");
    final accommodation = availableAccommodationsList![index];
    int totalRooms = accommodation.noOfRooms ?? 0;
    int reservedRoomCount = accommodation.tempReservedRoomCountForResultSet ?? 0;
    int availableRoomCount = totalRooms - reservedRoomCount;

    bool isAccommodationIncludedInReservationList = false;

    // if (_reservationNotifier.includedRoomsForReservationList != null) {
      if (_includedRoomsForReservationList.isNotEmpty) {
        var accommodationIncludedInReservationList = _includedRoomsForReservationList
            .where((element) => element.accommodationReference == accommodation.reference,);
        if (accommodationIncludedInReservationList.isNotEmpty) {
          isAccommodationIncludedInReservationList = true;
        } else {
          isAccommodationIncludedInReservationList = false;
        }
      }
    // }

    return Card(
      key: ValueKey(accommodation.reference),
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
              child: Text(
                isAccommodationIncludedInReservationList ? "Remove" : "Add",
                style: TextStyle(
                    color: isAccommodationIncludedInReservationList ? AppColors.ashRed : AppColors.lightGray
                ),
              ),
              onPressed: () => isAccommodationIncludedInReservationList
                  ? removeRoomFromReservationClientList(accommodation)
                  : addRoomForReservationClientList(accommodation),
            ),
          ],
        ),
      ),
    );
  }

  void onTapCheckInDateField() async {
    DateTime? checkInDate = await showDatePicker(
      context: context,
      initialDate: _selectedCheckInDate,
      firstDate: _selectedCheckInDate,
      lastDate: DateTime(2030),
        // selectableDayPredicate: (DateTime val) =>
        // val.compareTo(DateTime.now()) > 0 ? true : false
    );

    if (checkInDate != null) {
      checkInDateController.text = DateFormat('yyyy-MM-dd').format(checkInDate);
      checkOutDateController.text = DateFormat('yyyy-MM-dd').format(checkInDate.add(const Duration(days: 1)));
      _selectedCheckInDate = checkInDate;
    }
  }

  void onTapCheckOutDateField() async {
    DateTime? checkOutDate = await showDatePicker(
      context: context,
      initialDate: _selectedCheckInDate.add(const Duration(days: 1)),
      firstDate: _selectedCheckInDate.add(const Duration(days: 1)),
      lastDate: DateTime(2030),
    );

    if (checkOutDate != null) {
      // checkInDateController.text = DateFormat('yyyy-MM-dd').format(checkInDate);
      checkOutDateController.text = DateFormat('yyyy-MM-dd').format(checkOutDate);
      _selectedCheckoutDate = checkOutDate;
      // _isTotalCostPanelVisible = false;
    }
  }

  void addRoomForReservationClientList(Accommodation selectedAccommodation) {
    print("before: ${_includedRoomsForReservationList.length}");
    setState(() {
      _reservationNotifier.addRoomForReservationClientList(selectedAccommodation);
      // _reservationNotifier.isTotalCostPanelVisible = false;
      Provider.of<ReservationNotifier>(context, listen: false)
          .notifyTotalCostPanelVisibilityChanged(visibility: false);
    });


    // Provider.of<ReservationNotifier>(context, listen: false).addRoomForReservationClientList(selectedAccommodation);
    print("after: ${_includedRoomsForReservationList.length}");
  }

  void removeRoomFromReservationClientList(Accommodation selectedAccommodation) {
    setState(() {
      _reservationNotifier.removeRoomFromReservationClientList(selectedAccommodation);
      // _reservationNotifier.isTotalCostPanelVisible = false;
      Provider.of<ReservationNotifier>(context, listen: false)
          .notifyTotalCostPanelVisibilityChanged(visibility: false);
    });
  }

  void calculateTotalCost() {
    setState(() {
      _totalCostForReservation =
          _reservationService.calculateTotalCostOfOrder(
              _reservationToBeProceeded.checkIn!, _reservationToBeProceeded.checkOut!,
              _includedRoomsForReservationList);

      _noOfNightsForReservation =
          _reservationService.calculateNoOfNightsForReservation(
              _reservationToBeProceeded.checkIn!, _reservationToBeProceeded.checkOut!);
      // _reservationNotifier.isTotalCostPanelVisible = true;
      Provider.of<ReservationNotifier>(context, listen: false)
          .notifyTotalCostPanelVisibilityChanged(visibility: true);
    });
  }

  void proceedToCheckoutReservation() async {
    bool isPaymentDone = await GeneralDialogUtils().showCustomGeneralDialog(
      context: context,
      child: ReservationProceedCheckoutDialog(reservationToBeProceeded: _reservationToBeProceeded),
      title: "Proceed Checkout",
    );

  }

  void searchAvailableRooms() {
    _reservationToBeProceeded.hotelName = selectedHotel;
    _reservationToBeProceeded.checkIn = _selectedCheckInDate;
    _reservationToBeProceeded.checkOut = _selectedCheckoutDate;
   //TODO: implement search
  }
}
