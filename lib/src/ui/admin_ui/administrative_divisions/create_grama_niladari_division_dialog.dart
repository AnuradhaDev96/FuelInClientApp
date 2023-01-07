import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../models/administrative_units/grama_niladari_divisions.dart';
import '../../../services/administrative_units_service.dart';
import '../../../utils/message_utils.dart';

class CreateGramaNiladariDivisionDialog extends StatelessWidget {
  CreateGramaNiladariDivisionDialog({Key? key, required this.divisionalSecretariatId}) : super(key: key);
  final String divisionalSecretariatId;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _gNDivisionSinhalaNameController = TextEditingController();
  final TextEditingController _gNDivisionEnglishNameController = TextEditingController();
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
                    controller: _gNDivisionSinhalaNameController,
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

  Widget _buildSaveDivisionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _saveGramaNiladariDivision(context),
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
          style: TextStyle(color: AppColors.darkPurple, fontSize: 14.0, fontFamily: SettingsSinhala.engFontFamily),
        ),
      ),
    );
  }

  void _saveGramaNiladariDivision(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      GramaNiladariDivisions newGramaNiladariDivision = GramaNiladariDivisions(
          id: _divisionCodeNotifier.value,
          name: _gNDivisionEnglishNameController.text,
          sinhalaValue: _gNDivisionSinhalaNameController.text);

      _administrativeUnitsService
          .createGramaNiladariDivisionRecord(divisionalSecretariatId, newGramaNiladariDivision)
          .then(
        (value) {
          if (value) {
            clearInputFields();
            //ග්‍රාම නිලධාරි වසම එකතු කිරීම සාර්ථකයි.
            showSaveResultMessage(context, true, ".%du ks,Odß jiu tl;= lsÍu id¾:lhs'");
          } else {
            //මෙම කේතයෙන් ග්‍රාම නිලධාරි වසමක් ඇත.
            showSaveResultMessage(context, false, "fuu fla;fhka .%du ks,Odß jiula we;'");
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
    _gNDivisionSinhalaNameController.clear();
    _gNDivisionEnglishNameController.clear();
    _divisionCodeNotifier.value = _defaultNotifierValue;
  }
}

