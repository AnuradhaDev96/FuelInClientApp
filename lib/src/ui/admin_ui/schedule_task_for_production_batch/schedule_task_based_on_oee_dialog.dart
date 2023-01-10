import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/models/administrative_units/divisional_secretariats.dart';

import '../../../api_providers/main_api_provider.dart';
import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../models/lock_hood_models/production_batch.dart';
import '../../../services/administrative_units_service.dart';
import '../../../utils/message_utils.dart';

class ScheduleTaskBasedOnOEEDialog extends StatelessWidget {
  ScheduleTaskBasedOnOEEDialog({Key? key, required this.batchId})
      : super(key: key);
  final int batchId;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOEExplainedWidget(),
              const SizedBox(height: 40.0),
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

  Widget _buildOEExplainedWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "You are going to schedule a new deadline for the Production Batch $batchId",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: AppColors.darkPurple,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Center(
            child: Text(
              "New deadline is calculated based on the Overall Equipment Effectivenes",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          const Text(
            "OEE = Availability x Performance x Quality",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
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
        onPressed: () => _scheduleTask(context),
        child: const Text(
          "Calculate OEE and Schedule Production Batch",
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

  void _scheduleTask(BuildContext context) async {
    bool success = await GetIt.I<MainApiProvider>().scheduleNewDateBasedOnOEEForProductionBatch(batchId);

    if (success) {
      showSaveResultMessage(context, true, "Estimated deadline saved successfully");
    } else {
      showSaveResultMessage(context, false, "Something went wrong");
    }

  }

  void showSaveResultMessage(BuildContext context, bool statusOfRequest, String message) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, message, appearFromTop: false,
        duration: 4)
        : MessageUtils.showErrorInFlushBar(context, message, appearFromTop: false, duration: 4);
  }
}
