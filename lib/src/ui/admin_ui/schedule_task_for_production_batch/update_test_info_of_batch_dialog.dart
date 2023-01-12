import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/models/administrative_units/divisional_secretariats.dart';

import '../../../api_providers/main_api_provider.dart';
import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../models/lock_hood_models/production_batch.dart';
import '../../../services/administrative_units_service.dart';
import '../../../utils/message_utils.dart';

class UpdateTestInfoOfBatchDialog extends StatelessWidget {
  UpdateTestInfoOfBatchDialog({Key? key, required this.batchId, required this.testedAmount, required this.passedAmount})
      : super(key: key);
  final int batchId, testedAmount, passedAmount;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _testedAmountController = TextEditingController();
  final TextEditingController _passedAmountController = TextEditingController();
  final AdministrativeUnitsService _administrativeUnitsService = GetIt.I<AdministrativeUnitsService>();

  final _defaultNotifierValue = "";
  final ValueNotifier<String> _divisionCodeNotifier = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTestedAmountField(),
              _buildPassedAmountField(),
              Row(
                children: [
                  Expanded(child: _buildSaveTestInfoButton(context)),
                  Expanded(child: _buildCancelButton(context)),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTestedAmountField() {
    _testedAmountController.text = "$testedAmount";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "TESTED AMOUNT",
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
              controller: _testedAmountController,
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
              keyboardType: TextInputType.number,
              // textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Tested Amount",
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

  Widget _buildPassedAmountField() {
    _passedAmountController.text = "$passedAmount";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PASSED AMOUNT",
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
              controller: _passedAmountController,
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
              keyboardType: TextInputType.number,
              // textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Passed Amount",
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

  Widget _buildSaveTestInfoButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _saveTestInformation(context),
        child: const Text(
          "Save Test Information",
          style: TextStyle(color: AppColors.white, fontSize: 14.0, fontFamily: SettingsSinhala.engFontFamily),
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

  void _saveTestInformation(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ProductionBatch updateRecord = ProductionBatch(
        id: batchId,
        testedAmount: int.tryParse(_testedAmountController.text),
        passedAmount: int.tryParse(_passedAmountController.text),
      );

      bool success = await GetIt.I<MainApiProvider>().updateTestInformationOfProductionBatch(updateRecord);

      if (success) {
        showSaveResultMessage(context, true, "Test information updated successfully");
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
    _testedAmountController.clear();
    _passedAmountController.clear();
    _divisionCodeNotifier.value = _defaultNotifierValue;
  }
}
