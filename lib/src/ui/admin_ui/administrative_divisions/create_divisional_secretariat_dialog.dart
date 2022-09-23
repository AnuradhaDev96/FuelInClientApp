import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/models/administrative_units/divisional_secretariats.dart';

import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../services/administrative_units_service.dart';
import '../../../utils/message_utils.dart';

class CreateDivisionalSecretariatDialog extends StatelessWidget {
  CreateDivisionalSecretariatDialog({Key? key}) : super(key: key);
  // final DivisionalSecretariats
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _divisionSinhalaNameController = TextEditingController();
  final TextEditingController _divisionEnglishNameController = TextEditingController();
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
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 8.0, bottom: 8.0),
                child: ValueListenableBuilder<String>(
                  valueListenable: _divisionCodeNotifier,
                  builder: (context, snapshot, child) {
                    return RichText(
                      text: TextSpan(
                        style: const TextStyle(color: AppColors.black),
                        children: [
                          const TextSpan(
                            text: "fla;h( ", //කේතය:
                            style: TextStyle(
                              fontFamily: SettingsSinhala.legacySinhalaFontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          TextSpan(
                            text: snapshot,
                            style: const TextStyle(fontFamily: SettingsSinhala.engFontFamily),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              _buildEnglishValueField(),
              _buildSinhalaValueField(),
              Row(
                children: [
                  Expanded(child: _buildSaveDivisionButton(context)),
                  Expanded(child: _buildCancelButton(context)),
                ],
              )
            ],
          ),
        ),
      ],
    );
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
                  text: "m%dfoaYsh f,alï ld¾hd,fha ku bx.%Sisfhka", //ප්‍රාදේශිය ලේකම් කාර්යාලයේ නම ඉංග්‍රීසියෙන්:
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
                    controller: _divisionEnglishNameController,
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
                        borderSide: const BorderSide(width: 1, color: AppColors.nppPurple),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: AppColors.nppPurple),
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
                  text: "m%dfoaYsh f,alï ld¾hd,fha ku isxyf,ka", //ප්‍රාදේශිය ලේකම් කාර්යාලයේ නම සිංහලෙන්:
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
                    controller: _divisionSinhalaNameController,
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
                        borderSide: const BorderSide(width: 1, color: AppColors.nppPurple),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: AppColors.nppPurple),
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

  Widget _buildSaveDivisionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _saveDivisionalSecretariat(context),
        child: const Text(
          "Save",
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
          style: TextStyle(color: AppColors.nppPurple, fontSize: 14.0, fontFamily: SettingsSinhala.engFontFamily),
        ),
      ),
    );
  }

  void _saveDivisionalSecretariat(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
        DivisionalSecretariats newDivisionalSecretariat = DivisionalSecretariats(id: _divisionCodeNotifier.value,
            name: _divisionEnglishNameController.text,
            sinhalaValue: _divisionSinhalaNameController.text);
        _administrativeUnitsService.createDivisionalSecretariatRecord(newDivisionalSecretariat).then(
          (value) {
            if (value) {
              clearInputFields();
              //ප්‍රාදේශිය ලේකම් කාර්යාලය එකතු කිරීම සාර්ථකයි.
              showSaveResultMessage(context, true, "m%dfoaYsh f,alï ld¾hd,h tl;= lsÍu id¾:lhs'");
            } else {
              //මෙම කේතයෙන් ප්‍රාදේශිය ලේකම් කාර්යාලයක් ඇත.
              showSaveResultMessage(context, false, "fuu fla;fhka m%dfoaYsh f,alï ld¾hd,hla we;'");
            }
          },
          onError: (e) {
            //තාක්ශනික දෝශයක්. නැවත උත්සහ කරන්න.
            showSaveResultMessage(context, false, ";dlaYksl fodaYhla' kej; W;aiy lrkak'");
          },
        );

    }
  }

  void showSaveResultMessage(BuildContext context, bool statusOfRequest, String message) {
    statusOfRequest
        ? MessageUtils.showSuccessInFlushBar(context, message, appearFromTop: false,
        duration: 4)
        : MessageUtils.showErrorInFlushBar(context, message, appearFromTop: false, duration: 4);
  }

  void clearInputFields() {
    _divisionSinhalaNameController.clear();
    _divisionEnglishNameController.clear();
    _divisionCodeNotifier.value = _defaultNotifierValue;
  }
}
