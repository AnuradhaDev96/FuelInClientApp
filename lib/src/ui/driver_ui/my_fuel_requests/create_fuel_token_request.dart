import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../../api_providers/main_api_provider.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_settings.dart';
import '../../../config/language_settings.dart';
import '../../../models/administrative_units/grama_niladari_divisions.dart';
import '../../../models/enums/purchase_fuel_type.dart';
import '../../../models/fuel_in_models/fuel_order.dart';
import '../../../models/fuel_in_models/fuel_station.dart';
import '../../../models/fuel_in_models/fuel_token_request.dart';
import '../../../models/lock_hood_models/inventory_items.dart';
import '../../../models/lock_hood_models/task_allocated_resource.dart';
import '../../../services/administrative_units_service.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/local_storage_utils.dart';
import '../../../utils/message_utils.dart';
import '../../widgets/custom_input_field.dart';

class CreateFuelRequestToken extends StatefulWidget {
  const CreateFuelRequestToken({Key? key})
      : super(key: key);

  @override
  State<CreateFuelRequestToken> createState() => _CreateFuelRequestTokenState();
}

class _CreateFuelRequestTokenState extends State<CreateFuelRequestToken> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _amountInLitresController = TextEditingController();
  final TextEditingController _expectedDeliveryDateController = TextEditingController();
  final TextEditingController _gNDivisionEnglishNameController = TextEditingController();
  late String _generatedFuelToken;
  final ValueNotifier<int> selectedFuelStation = ValueNotifier<int>(-1);

  final _defaultNotifierValue = "";

  // final ValueNotifier<String> _divisionCodeNotifier = ValueNotifier<String>("");
  final ValueNotifier<PurchaseFuelType> selectedFuelType = ValueNotifier<PurchaseFuelType>(PurchaseFuelType.petrol92);
  DateTime _defaultDate = DateTime.now();
  DateTime _expectedDeliveryDate = DateTime.now();
  // final ValueNotifier<List<TaskAllocatedResource>> _taskList = ValueNotifier<List<TaskAllocatedResource>>(<TaskAllocatedResource>[]);


  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  // int? selectedInventoryItemId;

  @override
  void initState() {
    _generatedFuelToken = CommonUtils.generateFuelToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 8.0, bottom: 8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: AppColors.black),
                    children: [
                      const TextSpan(
                        text: "Your new token:", //කේතය:
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      TextSpan(
                        text: _generatedFuelToken,
                      )
                    ],
                  ),
                ),
              ),
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
              _fuelTypeDropdownButton(context),
              _distributorDropdownButton(context),
              _buildAmountInLitresField(),
              _buildExpectedDeliveryDate(),
              Row(
                children: [
                  Expanded(child: _buildSaveResourceButton(context)),
                  Expanded(child: _buildCancelButton(context)),
                ],
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInLitresField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Amount in Litres",
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
              controller: _amountInLitresController,
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
        future: GetIt.I<MainApiProvider>().getAllFuelStations(),
        builder: (context, AsyncSnapshot<List<FuelStation>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Please wait. Retrieving fuel stations"),);
          }

          if (snapshot.hasData) {
            var fuelStationsList = List<FuelStation>.from(snapshot.data ?? <FuelStation>[]);
                // .where((element) => element.availableQuantity! > 0);

            if (fuelStationsList == null || fuelStationsList.isEmpty) {
              return const Center(child: Text("No fuel stations"),);
            }

            selectedFuelStation.value = fuelStationsList.elementAt(0).id ?? -1;

            List<DropdownMenuItem<int>>? itemList;

            itemList = fuelStationsList.map((x) =>
                DropdownMenuItem(
                  value: x.id,
                  child: Text(
                      "District: ${x.district ?? "-"} | Local authority: ${x.localAuthority ?? "-"}"
                  ),)).toList();
            // itemList.add(
            //     const DropdownMenuItem(
            //       value: -1,
            //       child: Text(
            //         "I don’t know my distributor",
            //       ),
            //     )
            // );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Fuel Station",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: ValueListenableBuilder<int>(
                      valueListenable: selectedFuelStation,
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
                            selectedFuelStation.value = value ?? -1;
                            print("###less sellId: ${selectedFuelStation.value}");
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
                              hintText: "Select Fuel Station",
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
                ),
              ],
            );
          }

          return const Center(child: Text("No fuel stations"),);
        }
    );
  }

  Widget _buildExpectedDeliveryDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Expected Filling Date",
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
        Material(
          child: CustomInputField(
            borderRadius: 14.0,
            borderColor: AppColors.white,
            width: 0.14,
            height: 0.07,
            icon: Icons.calendar_month,
            iconColor: AppColors.silverPurple,
            hintText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            hintColor: AppColors.silverPurple,
            fontSize: 12,
            obsecureText: false,
            textEditingController: _expectedDeliveryDateController,
            onPressedAction: onTapExpectedDeliveryDateField,
          ),
        ),
      ],
    );
  }

  Widget _fuelTypeDropdownButton(BuildContext context) {
    // selectedInventoryItem.value = inventoryItems.elementAt(0).id ?? -1;

    List<DropdownMenuItem<PurchaseFuelType>>? itemList;

    itemList = PurchaseFuelType.values.map((x) =>
        DropdownMenuItem(
          value: x,
          child: Text(
              x.toDisplayString()
          ),)).toList();
    // itemList.add(
    //     const DropdownMenuItem(
    //       value: -1,
    //       child: Text(
    //         "I don’t know my distributor",
    //       ),
    //     )
    // );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Fuel Type",
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
        SizedBox(
          height: 50.0,
          child: ValueListenableBuilder<PurchaseFuelType>(
              valueListenable: selectedFuelType,
              builder: (context, snapshot, child) {
                return DropdownButtonFormField<PurchaseFuelType>(
                  value: snapshot,
                  isExpanded: false,
                  items: itemList,
                  onChanged: (value) {
                    // setState(() {
                    //   // selectedInventoryItemId = value;
                    //   selectedInventoryItem.value = value ?? -1;
                    // });
                    selectedFuelType.value = value ?? PurchaseFuelType.petrol92;
                    print("###less sellId: ${selectedFuelType.value}");
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
                      hintText: "Select Fuel Type",
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
        ),
      ],
    );
  }

  Widget _buildSaveResourceButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _saveResource(context),
        child: const Text(
          "Order Now",
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

  void onTapExpectedDeliveryDateField() async {
    DateTime? expectedDeliveryDate = await showDatePicker(
      context: context,
      initialDate: _defaultDate,
      firstDate: _defaultDate,
      lastDate: DateTime(2030),
      // selectableDayPredicate: (DateTime val) =>
      // val.compareTo(DateTime.now()) > 0 ? true : false
    );

    if (expectedDeliveryDate != null) {
      setState(() {
        _expectedDeliveryDateController.text = DateFormat('yyyy-MM-dd').format(expectedDeliveryDate);
        _expectedDeliveryDate = expectedDeliveryDate;
      });
    }
  }

  void _saveResource(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var newTokenRequest = FuelTokenRequest(
          requestedQuotaInLitres: int.tryParse(_amountInLitresController.text),
          requestedFuelType: selectedFuelType.value,
          scheduledFillingDate: _expectedDeliveryDate,
          token: _generatedFuelToken,
          fuelStationId: selectedFuelStation.value,
      );

      // var loggedUser = await GetIt.I<LocalStorageUtils>().hiveDbBox?.get(AppSettings.hiveKeyAuthenticatedUser, defaultValue: null);
      var result = await GetIt.I<MainApiProvider>().createFuelTokenRequest(newTokenRequest);
      if (result.statusCode == 200){
        showSaveResultMessage(context, true, result.responseMessage ?? "Successfully created");
      } else {
        showSaveResultMessage(context, false, result.responseMessage ?? "Something went worng");
      }
    }
  }

  void showSaveResultMessage(BuildContext context, bool statusOfRequest, String message) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, message, appearFromTop: false,
        duration: 4)
        : MessageUtils.showErrorInFlushBar(context, message, appearFromTop: false, duration: 4);
  }

// void clearInputFields() {
//   _amountInLitresController.clear();
//   _gNDivisionEnglishNameController.clear();
//   _divisionCodeNotifier.value = _defaultNotifierValue;
// }
}

