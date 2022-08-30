import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../models/accommodation/accommodation.dart';
import '../../../services/accommodation_service.dart';
import '../../../config/app_colors.dart';
import '../../../utils/message_utils.dart';
import '../../../utils/string_extention.dart';

class AccommodationManagementPage extends StatefulWidget {
  const AccommodationManagementPage({Key? key}) : super(key: key);

  @override
  State<AccommodationManagementPage> createState() => _AccommodationManagementPageState();
}

class _AccommodationManagementPageState extends State<AccommodationManagementPage> {
  final TextEditingController _floorNoController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _noOfRoomsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _refBranchController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  // final TextEditingController _assigned = TextEditingController();
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  late final AccommodationService _accommodationService;
  bool _isUpdateMode = false;
  Accommodation? _elementToBeEdited;

  @override
  void initState() {
    _accommodationService = GetIt.I<AccommodationService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Material(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Container(
              color: AppColors.grayForPrimaryLight,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Register Accommodation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  // Container(color: AppColors.black,height: 2.0),
                  Form(
                    key: _formStateKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildHotelNameField()),
                            Expanded(child: buildHotelField()),
                            Expanded(child: buildRoomCountField()),
                            // Expanded(
                            //   child: Column(
                            //     children: [
                            //       buildFullName(),
                            //       submitEmployeeButton(),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildFloorNoField()),
                            Expanded(child: buildRoomSizeField()),
                            Expanded(child: buildRateInLkrField()),
                            // Expanded(
                            //   child: Column(
                            //     children: [
                            //       buildFullName(),
                            //       submitEmployeeButton(),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildDescriptionField()),
                            if (_isUpdateMode)
                              resetFormButton(),
                            submitAccommodationButton(),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 10.0),
          child: Text(
            'Accommodations of ELEMENT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        Container(color: AppColors.indigoMaroon,height: 2.0,),
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
                children: snapshot.data!.docs.map((data) => accommodationItemBuilder(context, data)).toList(),
              );
              // return Text("Error: ${snapshot.error}");
            }
            return const Text("No rooms available");
          },
        ),
        // FutureBuilder(
        //   future: _employeeService.getEmployeesList(),
        //     builder: (BuildContext context, AsyncSnapshot<List<EmployeeModel>> snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(
        //           child: Padding(
        //               padding: EdgeInsets.all(8.0),
        //               child: SizedBox(
        //                 width: 40,
        //                 height: 40,
        //                 child: CircularProgressIndicator(
        //                   strokeWidth: 1,
        //                   color: AppColors.indigoMaroon,
        //                 ),
        //               )),
        //         );
        //       } else if (snapshot.hasError) {
        //         return Text("Error: ${snapshot.error}");
        //       } else if (snapshot.hasData) {
        //
        //         employeeList = snapshot.data ?? <EmployeeModel>[];
        //
        //         return ListView.builder(
        //           shrinkWrap: true,
        //           itemCount: employeeList.length,
        //           itemBuilder: employeeItemBuilder,
        //         );
        //
        //       }
        //       return const Text("No employees available");
        //     },
        //     // child: ListView.builder(itemBuilder: itemBuilder)
        // )
      ],
    );
  }

  Widget buildHotelNameField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Room name (Category):"
          ),
          SizedBox(
            // width: 100.0,
            height: 35.0,
            child: TextFormField(
              controller: _roomNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Room name cannot be empty';
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
                hintText: "Room Name",
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

  Widget buildHotelField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Hotel:"
          ),
          SizedBox(
            // width: 100.0,
            height: 35.0,
            child: TextFormField(
              controller: _refBranchController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Hotel cannot be empty';
                }
                // if (!value.isDouble) {
                //   return 'Enter numeric';
                // }
                return null;
              },
              autofocus: true,
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
                hintText: "Hotel name",
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

  Widget buildRoomCountField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Total room count:"
          ),
          SizedBox(
            // width: 100.0,
            height: 35.0,
            child: TextFormField(
              controller: _noOfRoomsController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Room count cannot be empty';
                }
                if (!value.isInteger) {
                  return 'Enter integer value';
                }
                return null;
              },
              autofocus: true,
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
                hintText: "Room count",
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

  Widget buildRoomSizeField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Size of the room (m²):"
          ),
          SizedBox(
            // width: 100.0,
            height: 35.0,
            child: TextFormField(
              controller: _sizeController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Room size cannot be empty';
                }
                if (!value.isInteger) {
                  return 'Enter integer value';
                }
                return null;
              },
              autofocus: true,
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
                hintText: "Room size",
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

  Widget buildRateInLkrField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Rate of room in LKR:"
          ),
          SizedBox(
            // width: 100.0,
            height: 35.0,
            child: TextFormField(
              controller: _rateController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Rate cannot be empty';
                }
                if (!value.isDouble) {
                  return 'Enter numeric value';
                }
                return null;
              },
              autofocus: true,
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
                hintText: "LKR",
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

  Widget buildFloorNoField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Floor no of the room:"
          ),
          SizedBox(
            // width: 100.0,
            height: 35.0,
            child: TextFormField(
              controller: _floorNoController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Floor no cannot be empty';
                }
                if (!value.isInteger) {
                  return 'Enter integer value';
                }
                return null;
              },
              autofocus: true,
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
                hintText: "Floor no",
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

  Widget buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Description of room:"
          ),
          SizedBox(
            // width: 100.0,
            height: 50.0,
            child: TextFormField(
              maxLines: null,
              controller: _descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description cannot be empty';
                }
                return null;
              },
              autofocus: true,
              onChanged: (String emailAddress) {
                // _emailAddressBloc.onChangeEmail(emailAddress);
              },
              style: const TextStyle(fontSize: 12.0),
              keyboardType: TextInputType.multiline,
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
                hintText: "Add description here...",
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

  Widget submitAccommodationButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            )
        ),
        onPressed: _isUpdateMode ? editAccommodation : registerAccommodation,
        child: Text(
          _isUpdateMode ? "Edit Room" : "Submit Room",
          style: const TextStyle(color: AppColors.goldYellow, fontSize: 14.0),
        ),
      ),
    );
  }

  Widget resetFormButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          // backgroundColor: Colors.blue,
        ),
        onPressed: () {
          setState(() {
            _isUpdateMode = false;
            _elementToBeEdited = null;
            _roomNameController.clear();
            _refBranchController.clear();
            _noOfRoomsController.clear();
            _floorNoController.clear();
            _sizeController.clear();
            _descriptionController.clear();
            _rateController.clear();
          });
        },
        child: const Text(
          "Reset",
          style: TextStyle(color: AppColors.goldYellow, fontSize: 14.0),
        ),
      ),
    );
  }

  void registerAccommodation() async {
    if (_formStateKey.currentState!.validate()){
      _formStateKey.currentState!.save();
      Accommodation accommodation = Accommodation(
        roomName: _roomNameController.text,
        refBranch: _refBranchController.text,
        noOfRooms: int.tryParse(_noOfRoomsController.text) ?? 0,
        floorNo: int.tryParse(_floorNoController.text) ?? 0,
        size: int.tryParse(_sizeController.text) ?? 0,
        description: _descriptionController.text,
        rateInLkr: double.tryParse(_rateController.text),
      );
      final bool result = await _accommodationService.registerAccommodation(accommodation);
      if (result) {
        _roomNameController.clear();
        _refBranchController.clear();
        _noOfRoomsController.clear();
        _floorNoController.clear();
        _sizeController.clear();
        _descriptionController.clear();
        _rateController.clear();
        showCreateMessage(true);
      } else {
        showCreateMessage(false);
      }
      setState(() {

      });
    }
  }

  void editAccommodation() async {
    if (_formStateKey.currentState!.validate()){
      _formStateKey.currentState!.save();

      Accommodation accommodation = Accommodation(
        roomName: _roomNameController.text,
        refBranch: _refBranchController.text,
        noOfRooms: int.tryParse(_noOfRoomsController.text) ?? 0,
        floorNo: int.tryParse(_floorNoController.text) ?? 0,
        size: int.tryParse(_sizeController.text) ?? 0,
        description: _descriptionController.text,
        rateInLkr: double.tryParse(_rateController.text),
        reference: _elementToBeEdited?.reference,
      );
      if (_elementToBeEdited == null) return;

      final bool result = await _accommodationService.updateAccommodation(accommodation);
      if (result) {
        setState(() {
          _isUpdateMode = false;
          _elementToBeEdited = null;
          _roomNameController.clear();
          _refBranchController.clear();
          _noOfRoomsController.clear();
          _floorNoController.clear();
          _sizeController.clear();
          _descriptionController.clear();
          _rateController.clear();
        });
        showUpdateMessage(true);
      } else {
        showUpdateMessage(false);
      }
    }
  }

  void showCreateMessage(bool statusOfRequest) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, "Accommodation saved successfully.", appearFromTop: false, duration: 4)
        : MessageUtils.showErrorInFlushBar(context, "Save failed.", appearFromTop: false, duration: 4);
  }

  void showUpdateMessage(bool statusOfRequest) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, "Accommodation updated successfully.", appearFromTop: false, duration: 4)
        : MessageUtils.showErrorInFlushBar(context, "Update failed.", appearFromTop: false, duration: 4);
  }

  void showDeleteMessage(bool statusOfRequest) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, "Accommodation deleted successfully.", appearFromTop: false, duration: 4)
        : MessageUtils.showErrorInFlushBar(context, "Delete failed.", appearFromTop: false, duration: 4);
  }

  void switchToUpdateMode(Accommodation accommodationModel) {
    setState(() {
      _isUpdateMode = true;
      _elementToBeEdited = accommodationModel;
      _roomNameController.text = accommodationModel.roomName ?? "";
      _refBranchController.text = accommodationModel.refBranch ?? "";
      _noOfRoomsController.text = accommodationModel.noOfRooms.toString();
      _floorNoController.text = accommodationModel.floorNo.toString();
      _sizeController.text = accommodationModel.size.toString();
      _descriptionController.text = accommodationModel.description ?? "";
      _rateController.text = accommodationModel.rateInLkr.toString();
    });

  }

  Color getCardColor(DocumentReference? ref) {
    if (_isUpdateMode == true && _elementToBeEdited?.reference == ref) {
      return AppColors.ashGreen;
    } else {
      return AppColors.lightGray;
    }
  }

  Widget accommodationItemBuilder(BuildContext context, DocumentSnapshot data) {
    final accommodation = Accommodation.fromSnapshot(data);
    int totalRooms = accommodation.noOfRooms ?? 0;
    int reservedRoomCount = accommodation.reservedRoomCount ?? 0;
    int availableRoomCount = totalRooms - reservedRoomCount;

    return Card(
      elevation: 5,
      color: getCardColor(accommodation.reference),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Container(
                    //   width: 50.0,
                    //   height: 50.0,
                    //   decoration: const BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: AppColors.indigoMaroon,
                    //   ),
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: const Center(
                    //     child: Text(
                    //       "A",
                    //       style: TextStyle(
                    //           color: AppColors.goldYellow,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 20.0
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              accommodation.roomName ?? "-",
                              style: const TextStyle(
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(width: 10.0),
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
                        Row(
                          children: [
                            const Text(
                              "Hotel: ",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              accommodation.refBranch ?? "-",
                              style: const TextStyle(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Description: ",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: RichText(
                                    text: TextSpan(
                                      text: accommodation.description,
                                      style: const TextStyle(
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                              "${accommodation.floorNo ?? "NA"}",
                              style: const TextStyle(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Size: ",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              accommodation.size == null ? "NA" : "${accommodation.size} m²",
                              style: const TextStyle(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: AppColors.black,
                              ),
                              child: Text(
                                "$totalRooms total rooms",
                                style: const TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: AppColors.black,
                              ),
                              child: Text(
                                "$reservedRoomCount rooms reserved",
                                style: const TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(15.0),
                        shape: BoxShape.circle,
                        color: AppColors.shiftGray,
                      ),
                      child: IconButton(
                        onPressed: () => switchToUpdateMode(accommodation),
                        icon: const Icon(
                          Icons.edit_rounded,
                          color: AppColors.black,
                          size: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(15.0),
                        shape: BoxShape.circle,
                        color: AppColors.ashRed,
                      ),
                      child: IconButton(
                          onPressed: () => deleteAccommodation(accommodation),
                          icon: const Icon(
                            Icons.delete_outline_sharp,
                            color: AppColors.lightGray,
                            size: 20.0,
                          )
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void deleteAccommodation(Accommodation accommodation) async {
    final bool result = await _accommodationService.deleteAccommodation(accommodation);
    if (result) {
      _isUpdateMode = false;
      _elementToBeEdited = null;
      _roomNameController.clear();
      _refBranchController.clear();
      _noOfRoomsController.clear();
      _floorNoController.clear();
      _sizeController.clear();
      _descriptionController.clear();
      _rateController.clear();
      showDeleteMessage(true);
    } else {
      showDeleteMessage(false);
    }
    setState(() {});
  }
}
