import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../api_providers/main_api_provider.dart';
import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../models/administrative_units/grama_niladari_divisions.dart';
import '../../../models/lock_hood_models/inventory_items.dart';
import '../../../models/lock_hood_models/task_allocated_resource.dart';
import '../../../services/administrative_units_service.dart';
import '../../../utils/message_utils.dart';

class KanBanTaskAllocateResourcesDialog extends StatefulWidget {
  const KanBanTaskAllocateResourcesDialog({Key? key, required this.productionBatchId, required this.kanbantaskId})
      : super(key: key);
  final int productionBatchId;
  final int kanbantaskId;

  @override
  State<KanBanTaskAllocateResourcesDialog> createState() => _KanBanTaskAllocateResourcesDialogState();
}

class _KanBanTaskAllocateResourcesDialogState extends State<KanBanTaskAllocateResourcesDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _allocatingAmountController = TextEditingController();

  final TextEditingController _gNDivisionEnglishNameController = TextEditingController();

  final AdministrativeUnitsService _administrativeUnitsService = GetIt.I<AdministrativeUnitsService>();

  final _defaultNotifierValue = "";

  final ValueNotifier<String> _divisionCodeNotifier = ValueNotifier<String>("");
  final ValueNotifier<int> selectedInventoryItem = ValueNotifier<int>(-1);
  final ValueNotifier<List<TaskAllocatedResource>> _taskList = ValueNotifier<List<TaskAllocatedResource>>(<TaskAllocatedResource>[]);

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  // int? selectedInventoryItemId;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 10.0, left: 8.0, bottom: 8.0),
              //   child: ValueListenableBuilder<String>(
              //     valueListenable: _divisionCodeNotifier,
              //     builder: (context, snapshot, child) {
              //       return RichText(
              //         text: TextSpan(
              //           style: const TextStyle(color: AppColors.black),
              //           children: [
              //             const TextSpan(
              //               text: "fla;h( ", //කේතය:
              //               style: TextStyle(
              //                 fontFamily: SettingsSinhala.legacySinhalaFontFamily,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 20.0,
              //               ),
              //             ),
              //             TextSpan(
              //               text: snapshot,
              //               style: const TextStyle(fontFamily: SettingsSinhala.engFontFamily),
              //             )
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // _buildEnglishValueField(),
              // _buildSinhalaValueField(),
              _distributorDropdownButton(context),
              _buildAllocatingAmountField(),
              Row(
                children: [
                  Expanded(child: _buildSaveResourceButton(context)),
                  Expanded(child: _buildCancelButton(context)),
                ],
              ),
              const SizedBox(height: 10.0),
              const Center(child: Text("Allocated Resources for this task", style: TextStyle(fontWeight: FontWeight.w600),),),
              Center(child:_allocatedResourceOfTaskList()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllocatingAmountField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "ALLOCATING AMOUNT",
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4.0),
          SizedBox(
            width: 240.0,
            height: 35.0,
            child: TextFormField(
              controller: _allocatingAmountController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field cannot be empty';
                }
                return null;
              },
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColors.black,
              ),
              keyboardType: TextInputType.emailAddress,
              // textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Amount",
                  hintStyle: const TextStyle(
                    color: AppColors.hintTextBlue,
                    fontSize: 14.0,
                  ),
                  // prefixIcon: const Icon(Icons.mail, size: 20.0,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(width: 1, color: AppColors.lightGray)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.silverPurple),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.silverPurple),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.hintTextBlue),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  errorStyle: const TextStyle(
                    color: AppColors.hintTextBlue,
                  )
              ),
              // textInputAction: TextInputAction.next,
              onFieldSubmitted: (String value) {
                // _authPasswordFieldFocusNode.requestFocus();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _distributorDropdownButton(BuildContext context) {
    return FutureBuilder(
        future: GetIt.I<MainApiProvider>().getInventoryItemsByProductBatchId(widget.productionBatchId),
        builder: (context, AsyncSnapshot<List<InventoryItems>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Please wait. Retrieving inventory items of inventory"),);
          }

          if (snapshot.hasData) {
            var inventoryItems = List<InventoryItems>.from(snapshot.data ?? <InventoryItems>[])
                .where((element) => element.availableQuantity! > 0);

            if (inventoryItems == null || inventoryItems.isEmpty) {
              return const Center(child: Text("No Inventory items in this inventory"),);
            }

            selectedInventoryItem.value = inventoryItems.elementAt(0).id ?? -1;

            List<DropdownMenuItem<int>>? itemList;

            itemList = inventoryItems.map((x) =>
                DropdownMenuItem(
                  value: x.id,
                  child: Text(
                    "Item Name: ${x.name ?? "-"} | Available amount: ${x.availableQuantity ?? "-"}"
                  ),)).toList();
            // itemList.add(
            //     const DropdownMenuItem(
            //       value: -1,
            //       child: Text(
            //         "I don’t know my distributor",
            //       ),
            //     )
            // );

            return SizedBox(
              height: 50.0,
              child: ValueListenableBuilder<int>(
                valueListenable: selectedInventoryItem,
                builder: (context, snapshot, child) {
                  return DropdownButtonFormField<int>(
                    value: snapshot,
                    isExpanded: false,
                    items: itemList,
                    onChanged: (value) {
                      // setState(() {
                      //   // selectedInventoryItemId = value;
                      //   selectedInventoryItem.value = value ?? -1;
                      // });
                      selectedInventoryItem.value = value ?? -1;
                      print("###less sellId: ${selectedInventoryItem.value}");
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.black,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    borderRadius: BorderRadius.circular(12.0),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Select Resource",
                        hintStyle: const TextStyle(
                          color: AppColors.hintTextBlue,
                          fontSize: 14.0,
                        ),
                        // prefixIcon: const Icon(Icons.mail, size: 20.0,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(width: 1, color: AppColors.lightGray)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: AppColors.silverPurple),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: AppColors.silverPurple),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: AppColors.hintTextBlue),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        errorStyle: const TextStyle(
                          color: AppColors.hintTextBlue,
                        )
                    ),
                  );
                }
              ),
            );
          }

          return const Center(child: Text("No Inventory items in this inventory"),);
        }
    );
  }

  Widget _allocatedResourceOfTaskList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: FutureBuilder(
        future: GetIt.I<MainApiProvider>().getAllocatedResourcesByTaskId(widget.kanbantaskId),
        builder: (BuildContext context, AsyncSnapshot<List<TaskAllocatedResource>?> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: AppColors.darkPurple,
                    ),
                  )),
            );
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No data found"));
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text("No data found"));
            }
            _taskList.value = List<TaskAllocatedResource>.from(snapshot.data ?? <TaskAllocatedResource>[]);
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
                    child: ValueListenableBuilder<List<TaskAllocatedResource>>(
                        valueListenable: _taskList,
                        builder: (context, snapshot, child) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: DataTable(
                              headingTextStyle: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black),
                              dataTextStyle: const TextStyle(
                                  fontSize: 12.0, color: AppColors.black),
                              // headingRowColor: MaterialStateProperty.all(AppColors.silverPurple),
                              // border: const TableBorder(
                              //   bottom: BorderSide(color: AppColors.silverPurple),
                              // ),
                              columns: const [
                                DataColumn(label: Text('Resource Id')),
                                DataColumn(label: Text('Inventory Item Id')),
                                DataColumn(label: Text('Allocated Amount')),
                              ],
                              rows: snapshot.map((data) => _inventoryObjectItemBuilder(context, data)).toList(),
                            ),
                          );
                        }
                    ),
                  ),
                ),
              ),
            );
          }
          return const Text(";k;=re b,a,Sï lsisjla fkdue;"); //තනතුරු ඉල්ලීම් කිසිවක් නොමැත

        },),
      );
  }

  DataRow _inventoryObjectItemBuilder(BuildContext context, TaskAllocatedResource data) {
    // final systemUser = SystemUser.fromSnapshot(data);

    return DataRow(cells: [

      // DataCell(
      //   Row(
      //     children: [
      //       // ElevatedButton(
      //       //   onPressed: () => _selectAccessRequestToCreateUser(context, systemUser),
      //       //   child: const Text(
      //       //     "n|jd.kak",//බඳවාගන්න
      //       //     style: TextStyle(color: AppColors.white, fontSize: 14.0),
      //       //   ),
      //       // ),
      //       // const SizedBox(width: 5.0),
      //       ElevatedButton(
      //         style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
      //           backgroundColor: MaterialStateProperty.all(AppColors.silverPurple),
      //         ),
      //         onPressed: () {},
      //         // onPressed: () => _openAllocateResourceDialog(context, data.batchId ?? -1, data.id ?? -1),
      //         child: const Text(
      //           "Allocate/View Resource",
      //           style: TextStyle(color: AppColors.darkPurple, fontSize: 12.0),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      DataCell(Text(data.id == null ? "-" : "${data.id}")),
      DataCell(Text(data.inventoryItemId == null ? "-" : "${data.id}" )),
      // DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkIn!))),
      // DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.checkOut!))),
      DataCell(Text(data.allocatedAmount == null ? "-" : "${data.allocatedAmount}")),
      // DataCell(
      //   Row(
      //     children: [
      //       ElevatedButton(
      //         style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
      //           backgroundColor: MaterialStateProperty.all(AppColors.darkPurple),
      //         ),
      //         // onPressed: () => _selectReservationToAssignRooms(context, reservation),
      //         onPressed: () => _navigateToPermissionsPage(context, systemUser),
      //         child: const Text(
      //           "f;darkak",//තෝරන්න
      //           style: TextStyle(color: AppColors.white, fontSize: 14.0),
      //         ),
      //       ),
      //     ],
      //   ),
      // )
      // DataCell(
      //   RichText(
      //     text: TextSpan(
      //       style: const TextStyle(fontFamily: SettingsSinhala.engFontFamily),
      //       children: [
      //         TextSpan(text: DateFormat.yMd().format(systemUser.requestedDate!)),
      //         const TextSpan(text: "  "),
      //         TextSpan(
      //           text: DateFormat.jms().format(systemUser.requestedDate!),
      //           style: const TextStyle(color: AppColors.createdDateColor),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // DataCell(
      //   RichText(
      //     text: TextSpan(
      //       style: const TextStyle(fontFamily: SettingsSinhala.engFontFamily),
      //       children: [
      //         TextSpan(
      //           text: DateFormat.yMd().format(systemUser.lastUpdatedDate!),
      //         ),
      //         const TextSpan(text: "  "),
      //         TextSpan(
      //           text: DateFormat.jms().format(systemUser.lastUpdatedDate!),
      //           style: const TextStyle(color: AppColors.updatedDateColor),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      // DataCell(Text("${reservation.noOfNightsReserved ?? 0}")),
      // DataCell(Text("${reservation.totalCostOfReservation ?? 0}")),
    ]);
  }

  Widget _buildEnglishValueField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: ".%du ks,Odß jifï ku bx.%Sisfhka", //ග්‍රාම නිලදාරි වසමේ නම ඉංග්‍රීසියෙන්:
                  style: TextStyle(
                    fontFamily: SettingsSinhala.legacySinhalaFontFamily,
                  ),
                ),
                TextSpan(
                  text: (" (English):"),
                  style: TextStyle(fontFamily: SettingsSinhala.engFontFamily, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  // width: 170.0,
                  height: 80.0,
                  child: TextFormField(
                    controller: _gNDivisionEnglishNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ms<s;=r wksjd¾hhs';//පිළිතුර අනිවාර්යයි!
                      }
                      return null;
                    },
                    // onEditingComplete: () {
                    //   _personalEmailFieldFocusNode.requestFocus();
                    // },
                    onChanged: (String value) {
                      _divisionCodeNotifier.value = value.toUpperCase().replaceAll(" ", "_");
                      // snapshot.toUpperCase().replaceAll(" ", "_")
                    },
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: SettingsSinhala.engFontFamily,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.text,
                    // textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(width: 1, color: AppColors.lightGray)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: AppColors.darkPurple),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: AppColors.darkPurple),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSinhalaValueField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: ".%du ks,Odß jifï ku isxyf,ka", //ග්‍රාම නිලදාරි වසමේ නම සිංහලෙන්:
                  style: TextStyle(
                    fontFamily: SettingsSinhala.legacySinhalaFontFamily,
                  ),
                ),
                TextSpan(
                  text: (" (Unicode Sinhala):"),
                  style: TextStyle(fontFamily: SettingsSinhala.engFontFamily, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  // width: 170.0,
                  height: 80.0,
                  child: TextFormField(
                    controller: _allocatingAmountController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ms<s;=r wksjd¾hhs';//පිළිතුර අනිවාර්යයි!
                      }
                      return null;
                    },
                    // onEditingComplete: () {
                    //   _personalEmailFieldFocusNode.requestFocus();
                    // },
                    // onChanged: (String value) {
                    //   _divisionCodeNotifier.value = value.toUpperCase().replaceAll(" ", "_");
                    //   // snapshot.toUpperCase().replaceAll(" ", "_")
                    // },
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.text,
                    // textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(width: 1, color: AppColors.lightGray)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: AppColors.darkPurple),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: AppColors.darkPurple),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaveResourceButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _saveResource(context),
        child: const Text(
          "Allocate",
          style: TextStyle(color: AppColors.white, fontSize: 14.0),
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          backgroundColor: MaterialStateProperty.all(AppColors.silverPurple),
        ),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        child: const Text(
          "Cancel",
          style: TextStyle(color: AppColors.darkPurple, fontSize: 14.0, fontFamily: SettingsSinhala.engFontFamily),
        ),
      ),
    );
  }

  void _saveResource(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      TaskAllocatedResource newTaskAllocatedResource = TaskAllocatedResource(
        allocatedAmount: double.tryParse(_allocatingAmountController.text),
        kanBanTaskId: widget.kanbantaskId,
        inventoryItemId: selectedInventoryItem.value
      );

      var response = await GetIt.I<MainApiProvider>().createAllocatedResourceForTask(newTaskAllocatedResource);

      if (response.statusCode == 200) {
        if (response.isAutomatedInventoryRequestCreated == true) {
          showSaveResultMessage(context, true, "Resource allocated to task and inventory order request created for resource");
        } else {
          showSaveResultMessage(context, true, "Resource allocated to task");
        }
      } else if (response.statusCode == 422){
        showSaveResultMessage(context, false, "This resource already exists in the task");
      } else {
        showSaveResultMessage(context, false, "Something went wrong");
      }
    }
  }

  void showSaveResultMessage(BuildContext context, bool statusOfRequest, String message) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, message, appearFromTop: false,
        duration: 4)
        : MessageUtils.showErrorInFlushBar(context, message, appearFromTop: false, duration: 4);
  }

  void clearInputFields() {
    _allocatingAmountController.clear();
    _gNDivisionEnglishNameController.clear();
    _divisionCodeNotifier.value = _defaultNotifierValue;
  }
}

