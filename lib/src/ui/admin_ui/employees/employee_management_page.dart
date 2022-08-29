import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rh_reader/src/models/employee/employee_model.dart';
import 'package:rh_reader/src/services/employee_service.dart';

import '../../../config/app_colors.dart';
import '../../../utils/message_utils.dart';
import '../../../utils/string_extention.dart';

class EmployeeManagementPage extends StatefulWidget {
  const EmployeeManagementPage({Key? key}) : super(key: key);

  @override
  State<EmployeeManagementPage> createState() => _EmployeeManagementPageState();
}

class _EmployeeManagementPageState extends State<EmployeeManagementPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  // final TextEditingController _assigned = TextEditingController();
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  late final EmployeeService _employeeService;
  List<EmployeeModel> employeeList = [];
  bool _isUpdateMode = false;
  EmployeeModel? _elementToBeEdited;

  @override
  void initState() {
    _employeeService = GetIt.I<EmployeeService>();
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
                    'Register Employee',
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
                            Expanded(child: buildFullName()),
                            Expanded(child: buildAgeField()),
                            Expanded(child: buildDesignationField()),
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (_isUpdateMode)
                              resetFormButton(),
                            submitEmployeeButton(),
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
            'Employees of ELEMENT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        Container(color: AppColors.indigoMaroon,height: 2.0,),
        StreamBuilder(
          stream: _employeeService.getEmployeesStream(),
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
                children: snapshot.data!.docs.map((data) => employeeItemBuilder(context, data)).toList(),
              );
              // return Text("Error: ${snapshot.error}");
            }
            return const Text("No employees available");
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

  Widget buildAgeField() {
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
            _fullNameController.clear();
            _salaryController.clear();
            _designationController.clear();
          });
        },
        child: const Text(
          "Reset",
          style: TextStyle(color: AppColors.goldYellow, fontSize: 14.0),
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

  Widget employeeItemBuilder(BuildContext context, DocumentSnapshot data) {
    final employee = EmployeeModel.fromSnapshot(data);

    return Card(
      elevation: 5,
      color: getCardColor(employee.reference),
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
                              "Name: ",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              employee.fullName ?? "-",
                              style: const TextStyle(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Salary: ",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              employee.salary ?? "-",
                              style: const TextStyle(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Designation: ",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              employee.designation ?? "-",
                              style: const TextStyle(
                                color: AppColors.black,
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
                          onPressed: () => switchToUpdateMode(employee),
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
                        onPressed: () => deleteEmployee(employee),
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
}
