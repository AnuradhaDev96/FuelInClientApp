import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:matara_division_system/src/config/language_settings.dart';
import 'package:matara_division_system/src/models/change_notifiers/access_requests_page_view_notifier.dart';
import 'package:matara_division_system/src/models/enums/access_request_status.dart';
import 'package:matara_division_system/src/models/enums/user_types.dart';
import 'package:matara_division_system/src/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../../../models/authentication/request_access_model.dart';
import '../../../models/employee/employee_model.dart';
import '../../../services/employee_service.dart';

import '../../../config/app_colors.dart';
import '../../../utils/message_utils.dart';
import '../../../utils/string_extention.dart';

class AnonymousAccessRequestsPage extends StatefulWidget {
  const AnonymousAccessRequestsPage({Key? key}) : super(key: key);

  @override
  State<AnonymousAccessRequestsPage> createState() => _AnonymousAccessRequestsPageState();
}

class _AnonymousAccessRequestsPageState extends State<AnonymousAccessRequestsPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  // final TextEditingController _assigned = TextEditingController();
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  late final EmployeeService _employeeService;
  late final AuthService _authService;
  List<EmployeeModel> employeeList = [];
  bool _isUpdateMode = false;
  EmployeeModel? _elementToBeEdited;
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();


  @override
  void initState() {
    _employeeService = GetIt.I<EmployeeService>();
    _authService = GetIt.I<AuthService>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Material(
        //   elevation: 3,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(15),
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        //     child: Container(
        //       color: AppColors.grayForPrimaryLight,
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           const Text(
        //             'Register Employee',
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 16.0,
        //             ),
        //           ),
        //           // Container(color: AppColors.black,height: 2.0),
        //           Form(
        //             key: _formStateKey,
        //             child: Column(
        //               children: [
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     Expanded(child: buildFullName()),
        //                     Expanded(child: buildSalaryField()),
        //                     Expanded(child: buildDesignationField()),
        //                     // Expanded(
        //                     //   child: Column(
        //                     //     children: [
        //                     //       buildFullName(),
        //                     //       submitEmployeeButton(),
        //                     //     ],
        //                     //   ),
        //                     // )
        //                   ],
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   children: [
        //                     if (_isUpdateMode)
        //                       resetFormButton(),
        //                     submitEmployeeButton(),
        //                   ],
        //                 )
        //               ],
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 15.0),
              child: Text(
                'm%fõY b,a,Sï l<uKdlrKh',//ප්‍රවේශ ඉල්ලීම් කළමණාකරණය
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        Container(color: AppColors.nppPurple,height: 2.0,),
        const SizedBox(height: 8.0),
        StreamBuilder(
          stream: _authService.getRequestAccessForAdminStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: AppColors.nppPurple,
                      ),
                    )),
              );
            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
              return const Text("m%fõY b,a,Sï lsisjla fkdue;"); //ප්‍රවේශ ඉල්ලීම් කිසිවක් නොමැත
            }
            else if (snapshot.hasData) {
              // employeeList = snapshot.data ?? <EmployeeModel>[];
              // return ListView(
              //   shrinkWrap: true,
              //   children: snapshot.data!.docs.map((data) => accessItemBuilder(context, data)).toList(),
              // );
              // return Text("Error: ${snapshot.error}");
              return Scrollbar(
                controller: _verticalScrollController,
                scrollbarOrientation: ScrollbarOrientation.right,
                thumbVisibility: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: _verticalScrollController,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  child: Scrollbar(
                    controller: _horizontalScrollController,
                    scrollbarOrientation: ScrollbarOrientation.top,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _horizontalScrollController,
                      child: DataTable(
                        headingTextStyle: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: SettingsSinhala.legacySinhalaFontFamily,
                            color: AppColors.black),
                        dataTextStyle: const TextStyle(
                            fontSize: 12.0, fontFamily: SettingsSinhala.engFontFamily, color: AppColors.black),
                        headingRowColor: MaterialStateProperty.all(AppColors.silverPurple),
                        columns: const [
                          DataColumn(label: Text(';SrKh')),//තීරණය
                          DataColumn(label: Text('iïmQ¾K ku')),//සම්පූර්ණ නම
                          DataColumn(label: Text('Bfï,a ,smskh')),//ඊමේල් ලිපිනය
                          DataColumn(label: Text('ÿ\'l\' wxlh')),//දු.ක. අංකය
                          DataColumn(label: Text('b,a,Sï lrk ;k;=r')),//ඉල්ලීම් කරන තනතුර
                          DataColumn(
                            label: Text(
                              "Status",
                              style: TextStyle(
                                fontFamily: SettingsSinhala.engFontFamily
                              ),
                            ),
                          ),
                          DataColumn(label: Text('b,a¨ï l< Èkh')),//ඉල්ලුම් කළ දිනය
                          DataColumn(label: Text('wjidk jrg\nfjkia l< Èkh')),//අවසාන වරට වෙනස් කළ දිනය
                          // DataColumn(label: Text('Check In')),
                          // DataColumn(label: Text('Check Out')),
                          // DataColumn(label: Text('Room Count')),
                          // DataColumn(label: Text('No of Nights')),
                          // DataColumn(label: Text('Total Cost')),
                        ],
                        rows: snapshot.data!.docs.map((data) => accessItemBuilder(context, data)).toList(),
                      ),
                    ),
                  ),
                ),
              );
            }
            return const Text("m%fõY b,a,Sï lsisjla fkdue;"); //ප්‍රවේශ ඉල්ලීම් කිසිවක් නොමැත
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

  Widget buildFullName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Employee's full name:"
          ),
          SizedBox(
            // width: 100.0,
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

  Widget buildSalaryField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Employee's salary:"
          ),
          SizedBox(
            // width: 100.0,
            height: 35.0,
            child: TextFormField(
              controller: _salaryController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Salary cannot be empty';
                }
                if (!value.isDouble) {
                  return 'Enter numeric';
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
                hintText: "Salary",
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

  Widget buildDesignationField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Designation:"
          ),
          SizedBox(
            // width: 100.0,
            height: 35.0,
            child: TextFormField(
              controller: _designationController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Designation name cannot be empty';
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
                hintText: "Designation",
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

  Widget submitEmployeeButton() {
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
        onPressed: _isUpdateMode ? editEmployee : registerEmployee,
        child: Text(
          _isUpdateMode ? "Edit Employee" : "Submit Employee",
          style: const TextStyle(color: AppColors.nppPurple, fontSize: 14.0),
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
            _fullNameController.clear();
            _salaryController.clear();
            _designationController.clear();
          });
        },
        child: const Text(
          "Reset",
          style: TextStyle(color: AppColors.nppPurple, fontSize: 14.0),
        ),
      ),
    );
  }

  void registerEmployee() async {
    if (_formStateKey.currentState!.validate()){
      _formStateKey.currentState!.save();
      EmployeeModel employeeModel = EmployeeModel(
        fullName: _fullNameController.text,
        salary: _salaryController.text,
        designation: _designationController.text,
      );
      final bool result = await _employeeService.registerEmployee(employeeModel);
      if (result) {
        _fullNameController.clear();
        _salaryController.clear();
        _designationController.clear();
        showCreateMessage(true);
      } else {
        showCreateMessage(false);
      }
      setState(() {

      });
    }
  }

  void editEmployee() async {
    if (_formStateKey.currentState!.validate()){
      _formStateKey.currentState!.save();

      EmployeeModel employeeModel = EmployeeModel(
        fullName: _fullNameController.text,
        salary: _salaryController.text,
        designation: _designationController.text,
        reference: _elementToBeEdited?.reference,
      );
      if (_elementToBeEdited == null) return;

      final bool result = await _employeeService.updateEmployee(employeeModel);
      if (result) {
        setState(() {
          _isUpdateMode = false;
          _elementToBeEdited = null;
          _fullNameController.clear();
          _salaryController.clear();
          _designationController.clear();
        });
        showUpdateMessage(true);
      } else {
        showUpdateMessage(false);
      }
    }
  }

  void showCreateMessage(bool statusOfRequest) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, "Employee saved successfully.", appearFromTop: false, duration: 4)
        : MessageUtils.showErrorInFlushBar(context, "Save failed.", appearFromTop: false, duration: 4);
  }

  void showUpdateMessage(bool statusOfRequest) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, "Employee updated successfully.", appearFromTop: false, duration: 4)
        : MessageUtils.showErrorInFlushBar(context, "Update failed.", appearFromTop: false, duration: 4);
  }

  void showDeleteMessage(bool statusOfRequest) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, "Employee deleted successfully.", appearFromTop: false, duration: 4)
        : MessageUtils.showErrorInFlushBar(context, "Delete failed.", appearFromTop: false, duration: 4);
  }

  void switchToUpdateMode(EmployeeModel employeeModel) {
    setState(() {
      _isUpdateMode = true;
      _elementToBeEdited = employeeModel;
      _fullNameController.text = employeeModel.fullName ?? "";
      _salaryController.text = employeeModel.salary ?? "";
      _designationController.text = employeeModel.designation ?? "";
    });

  }

  Color getCardColor(DocumentReference? ref) {
    if (_isUpdateMode == true && _elementToBeEdited?.reference == ref) {
      return AppColors.ashGreen;
    } else {
      return AppColors.lightGray;
    }
  }

  DataRow accessItemBuilder(BuildContext context, DocumentSnapshot data) {
    final accessRequest = RequestAccessModel.fromSnapshot(data);

    return DataRow(cells: [

      DataCell(
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _selectAccessRequestToCreateUser(context, accessRequest),
              child: const Text(
                "n|jd.kak",//බඳවාගන්න
                style: TextStyle(color: AppColors.white, fontSize: 14.0),
              ),
            ),
            const SizedBox(width: 5.0),
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateProperty.all(AppColors.silverPurple),
              ),
              // onPressed: () => _selectReservationToAssignRooms(context, reservation),
              onPressed: () {},
              child: const Text(
                "bj;alrkak",//ඉවත්කරන්න
                style: TextStyle(color: AppColors.nppPurple, fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(accessRequest.fullName)),
      DataCell(Text(accessRequest.email)),
      DataCell(Text("${accessRequest.waPhoneNumber}")),
      // DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkIn!))),
      // DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkOut!))),
      DataCell(Text(
        "${accessRequest.userType?.toDisplaySinhalaString()}",
        style: const TextStyle(fontFamily: 'DL-Paras'),
      )),
      DataCell(Text("${accessRequest.accessRequestStatus?.toDbValue()}")),
      DataCell(
        RichText(
          text: TextSpan(
            style: const TextStyle(fontFamily: SettingsSinhala.engFontFamily),
            children: [
              TextSpan(text: DateFormat.yMd().format(accessRequest.requestedDate!)),
              const TextSpan(text: "  "),
              TextSpan(
                text: DateFormat.jms().format(accessRequest.requestedDate!),
                style: const TextStyle(color: AppColors.createdDateColor),
              ),
            ],
          ),
        ),
      ),
      DataCell(
        RichText(
          text: TextSpan(
            style: const TextStyle(fontFamily: SettingsSinhala.engFontFamily),
            children: [
              TextSpan(
                text: DateFormat.yMd().format(accessRequest.lastUpdatedDate!),
              ),
              const TextSpan(text: "  "),
              TextSpan(
                text: DateFormat.jms().format(accessRequest.lastUpdatedDate!),
                style: const TextStyle(color: AppColors.updatedDateColor),
              )
            ],
          ),
        ),
      ),
      // DataCell(Text("${reservation.noOfNightsReserved ?? 0}")),
      // DataCell(Text("${reservation.totalCostOfReservation ?? 0}")),
    ]);
  }

  void deleteEmployee(EmployeeModel employeeModel) async {
    final bool result = await _employeeService.deleteEmployee(employeeModel);
    if (result) {
      _isUpdateMode = false;
      _elementToBeEdited = null;
      _fullNameController.clear();
      _salaryController.clear();
      _designationController.clear();
      showDeleteMessage(true);
    } else {
      showDeleteMessage(false);
    }
    setState(() {});
  }

  void _selectAccessRequestToCreateUser(BuildContext context, RequestAccessModel requestAccessModel) {
    Provider.of<AccessRequestsPageViewNotifier>(context, listen: false).setSelectedRequestAccess(requestAccessModel);
    Provider.of<AccessRequestsPageViewNotifier>(context, listen: false).jumpToNextPage();
  }
}
