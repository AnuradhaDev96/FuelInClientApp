import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../models/membership/membership_model.dart';
import '../../../services/membership_service.dart';
import '../../../utils/message_utils.dart';
import '../../../utils/validator_utils.dart';

class CreateNewMemberDialog extends StatelessWidget {
  CreateNewMemberDialog({
    Key? key,
    required this.divisionalSecretariatId,
    required this.gramaNiladariDivisionId,
  }) : super(key: key);
  final String divisionalSecretariatId;
  final String gramaNiladariDivisionId;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _defaultIsSecondPhoneNumberExist = false;
  final ValueNotifier<bool> _secondPhoneAvailabilityNotifier = ValueNotifier<bool>(false);

  //required text editing controllers
  final TextEditingController _nicNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _electoralSeatController = TextEditingController();
  final TextEditingController _firstTelephoneNoController = TextEditingController();
  final TextEditingController _kottashayaNoController = TextEditingController();

  // NOT required text editing controllers
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _secondTelephoneNoController = TextEditingController();
  final TextEditingController _fbUserNameController = TextEditingController();
  final TextEditingController _preferredFieldToJoinController = TextEditingController();
  final TextEditingController _preferredRegionToOperateController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();

  final DateTime _defaultDateInTheForm = DateTime.now();
  final ValueNotifier<DateTime> _dateInTheFormNotifier = ValueNotifier<DateTime>(DateTime.now());

  final String _defaultFbUserName = "";
  final ValueNotifier<String> _fbUserNameValueNotifier = ValueNotifier<String>("");


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNicNumberField(),
              _buildFullNameField(),
              _buildAddressField(),
              _buildElectoralSeatField(),
              _buildKottashayaField(),
              _buildFirstTelephoneNumberField(),
              _buildSecondTelephoneNumberField(),
              _buildJobField(),
              _buildFbUserNameField(),
              _buildPreferredFieldToJoinField(),
              _buildPreferredRegionToOperateField(),
              _buildHouseNumberField(),
              _buildDateInFormField(),
              Row(
                children: [
                  Expanded(child: _buildSaveDivisionButton(context)),
                  Expanded(child: _buildCancelButton(context)),
                ],
              )
            ],
          )
        )
      ],
    );
  }

  //# region required text fields
  Widget _buildNicNumberField() {
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
                  text: "ජාතික හැඳුනුම්පත් අංකය: ", //ග්‍රාම නිලදාරි වසමේ නම ඉංග්‍රීසියෙන්:
                  style: TextStyle(
                    fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                  ),
                ),
                TextSpan(
                  text: ("*"),
                  style: TextStyle(fontFamily: SettingsSinhala.engFontFamily, color: AppColors.nppPurple),
                ),
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
                    controller: _nicNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'පිළිතුර අනිවාර්යයි';
                      }
                      if (!isLKNicNumber(value)) {
                        return "අංක 12ක් හෝ අංක 9ක් සමඟ V තිබිය යුතුයි";
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
                      fontFamily: SettingsSinhala.engFontFamily,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.text,
                    // textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
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

  Widget _buildFullNameField() {
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
                  text: "සම්පූර්ණ නම: ",
                  style: TextStyle(
                    fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                  ),
                ),
                TextSpan(
                  text: ("*"),
                  style: TextStyle(fontFamily: SettingsSinhala.engFontFamily, color: AppColors.nppPurple),
                ),
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
                    controller: _fullNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'පිළිතුර අනිවාර්යයි';
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
                      errorStyle: const TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
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

  Widget _buildAddressField() {
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
                  text: "ලිපිනය: ",
                  style: TextStyle(
                    fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                  ),
                ),
                TextSpan(
                  text: ("*"),
                  style: TextStyle(fontFamily: SettingsSinhala.engFontFamily, color: AppColors.nppPurple),
                ),
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
                    controller: _addressController,
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'පිළිතුර අනිවාර්යයි';
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
                    keyboardType: TextInputType.multiline,
                    // textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
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

  Widget _buildElectoralSeatField() {
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
                  text: "මැතිවරණ ආසනය: ",
                  style: TextStyle(
                    fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                  ),
                ),
                TextSpan(
                  text: ("*"),
                  style: TextStyle(fontFamily: SettingsSinhala.engFontFamily, color: AppColors.nppPurple),
                ),
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
                    controller: _electoralSeatController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'පිළිතුර අනිවාර්යයි';
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
                      errorStyle: const TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
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

  Widget _buildKottashayaField() {
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
                  text: "කොට්ඨාශය: ",
                  style: TextStyle(
                    fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                  ),
                ),
                TextSpan(
                  text: ("*"),
                  style: TextStyle(fontFamily: SettingsSinhala.engFontFamily, color: AppColors.nppPurple),
                ),
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
                    controller: _kottashayaNoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'පිළිතුර අනිවාර්යයි';
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
                      errorStyle: const TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
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

  Widget _buildFirstTelephoneNumberField() {
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
                  text: "දුරකතන අංකය 01: ",
                  style: TextStyle(
                    fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                  ),
                ),
                TextSpan(
                  text: ("*"),
                  style: TextStyle(fontFamily: SettingsSinhala.engFontFamily, color: AppColors.nppPurple),
                ),
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
                    controller: _firstTelephoneNoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'පිළිතුර අනිවාර්යයි';
                      }
                      if (!isLKPhoneNumber(value)) {
                        return "අංක 10කින් යුත් නිවැරදි දුක අංකයක් අවශ්‍යයයි";
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
                    keyboardType: TextInputType.phone,
                    // textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: _secondPhoneAvailabilityNotifier,
                builder: (context, snapshot, child) {
                  return Checkbox(
                    value: snapshot,
                    onChanged: (value) {
                      _secondPhoneAvailabilityNotifier.value = value!;
                    },
                    activeColor: AppColors.nppPurple,
                  );
                },
              ),
              const SizedBox(width: 5.0),
              const Text("දෙවන දුරකතන අංකයක් ඇත.",
                style: TextStyle(
                  fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDateInFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<DateTime>(
              valueListenable: _dateInTheFormNotifier,
              builder: (context, snapshot, child) {
                return RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(
                        text: "බඳවාගත් දිනය:  ",
                        style: TextStyle(
                          fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                        ),
                      ),
                      // if (snapshot.isNotEmpty)
                      TextSpan(
                          children: [
                            TextSpan(
                              text: DateFormat('yyyy-MM-dd').format(snapshot),
                              style: const TextStyle(
                                fontFamily: SettingsSinhala.engFontFamily,
                              ),
                            ),
                            WidgetSpan(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.date_range_outlined,
                                    size: 20.0,
                                    color: AppColors.nppPurple,
                                  ),
                                  onPressed: () => _pickDateInForm(context),
                                  tooltip: "Èkh f;darkak",//දිනය තෝරන්න
                                ),
                                alignment: PlaceholderAlignment.middle,
                                baseline: TextBaseline.alphabetic
                            ),
                          ]
                      ),
                    ],
                  ),
                );
              }
          ),
        ],
      ),
    );
  }
  //#end region required text fields

  //#region optional text fields
  Widget _buildSecondTelephoneNumberField() {
    return ValueListenableBuilder<bool>(
      valueListenable: _secondPhoneAvailabilityNotifier,
      builder: (context, snapshot, child) {
        if (!snapshot) {
          return const SizedBox(width: 0, height: 0);
        }
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
                      text: "දුරකතන අංකය 02: ",
                      style: TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
                    ),
                    // TextSpan(
                    //   text: ("*"),
                    //   style: TextStyle(fontFamily: SettingsSinhala.engFontFamily, color: AppColors.nppPurple),
                    // ),
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
                        controller: _secondTelephoneNoController,
                        validator: (value) {
                          if (snapshot) {
                            if (value == null || value.isEmpty) {
                              return 'පිළිතුර අනිවාර්යයි';
                            }
                            if (!isLKPhoneNumber(value)) {
                              return "අංක 10කින් යුත් නිවැරදි දුක අංකයක් අවශ්‍යයයි";
                            }
                            return null;
                          } else {
                            return null;
                          }

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
                        keyboardType: TextInputType.phone,
                        // textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                          ),
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
    );
  }

  Widget _buildJobField() {
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
                  text: "රැකියාව: ",
                  style: TextStyle(
                    fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                  ),
                ),
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
                    controller: _jobController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'පිළිතුර අනිවාර්යයි';
                    //   }
                    //   return null;
                    // },
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
                      errorStyle: const TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
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

  Widget _buildFbUserNameField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<String>(
            valueListenable: _fbUserNameValueNotifier,
            builder: (context, snapshot, child) {
              return RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    const TextSpan(
                      text: "FB Username: ",
                      style: TextStyle(
                        fontFamily: SettingsSinhala.engFontFamily,
                      ),
                    ),
                    if (snapshot.isNotEmpty)
                      TextSpan(
                        children: [
                          TextSpan(
                            text: snapshot,
                            style: const TextStyle(
                              fontFamily: SettingsSinhala.engFontFamily,
                            ),
                          ),
                          WidgetSpan(
                            child: IconButton(
                              icon: const Icon(
                                Icons.launch_outlined,
                                size: 14.0,
                              ),
                              onPressed: _launchFbUrlOfUser,
                              tooltip: ".sKqu mßlaYd lrkak",//ගිණුම පරික්ශා කරන්න
                            ),
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic
                          ),
                        ]
                      ),
                  ],
                ),
              );
            }
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
                    controller: _fbUserNameController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'පිළිතුර අනිවාර්යයි';
                    //   }
                    //   return null;
                    // },
                    // onEditingComplete: () {
                    //   _personalEmailFieldFocusNode.requestFocus();
                    // },
                    onChanged: (String value) {
                      // if(value.isEmpty) {
                      //   _fbUserNameValueNotifier.value = "";
                      // } else {
                      //
                      // }
                      _fbUserNameValueNotifier.value = value;
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
                      errorStyle: const TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
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

  Widget _buildPreferredFieldToJoinField() {
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
                  text: "සම්බන්ද වීමට කැමති ක්ෂේත්‍රය: ",
                  style: TextStyle(
                    fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                  ),
                ),
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
                    controller: _preferredFieldToJoinController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'පිළිතුර අනිවාර්යයි';
                    //   }
                    //   return null;
                    // },
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
                      errorStyle: const TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
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

  Widget _buildPreferredRegionToOperateField() {
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
                  text: "ක්‍රියාත්මක වීමට කැමති ප්‍රදේශය: ",
                  style: TextStyle(
                    fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                  ),
                ),
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
                    controller: _preferredRegionToOperateController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'පිළිතුර අනිවාර්යයි';
                    //   }
                    //   return null;
                    // },
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
                      errorStyle: const TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
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

  Widget _buildHouseNumberField() {
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
                  text: "ගෘහ මූලික අංකය: ",
                  style: TextStyle(
                    fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                  ),
                ),
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
                    controller: _houseNumberController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'පිළිතුර අනිවාර්යයි';
                    //   }
                    //   return null;
                    // },
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
                      errorStyle: const TextStyle(
                        fontFamily: SettingsSinhala.unicodeSinhalaFontFamily,
                      ),
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
  //#end region optional text fields


  //# region buttons
  Widget _buildSaveDivisionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _saveMembership(context),
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
  //# region buttons

  //#region functions
  void _launchFbUrlOfUser() async {
    String url = "https://fb.com/${_fbUserNameValueNotifier.value}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print("URL is not available");
    }
  }

  void _pickDateInForm(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _defaultDateInTheForm,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.nppPurple,
              onPrimary: AppColors.lightGray,
              surface: AppColors.silverPurple,
              onSurface: AppColors.black,
            ),
            textTheme: const TextTheme(
              headline4: TextStyle(fontFamily: SettingsSinhala.engFontFamily),
              headline5: TextStyle(fontFamily: SettingsSinhala.engFontFamily),
              overline: TextStyle(fontFamily: SettingsSinhala.engFontFamily),
              subtitle2: TextStyle(fontFamily: SettingsSinhala.engFontFamily),
              bodyText2: TextStyle(fontFamily: SettingsSinhala.engFontFamily),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.black,
                textStyle: const TextStyle(
                  fontFamily: SettingsSinhala.engFontFamily,
                )
              ),
            )
          ),
          child: child!,
        );
      }
    );

    if (pickedDate != null) {
      _dateInTheFormNotifier.value = pickedDate;
    }
    // else {
    //   _dateInTheFormNotifier.value = _defaultDateInTheForm;
    // }
  }

  void _saveMembership(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      MembershipModel newMember = MembershipModel(
        divisionalSecretariatId: divisionalSecretariatId,
        gramaNiladariDivisionId: gramaNiladariDivisionId,
        nicNumber: _nicNumberController.text,
        fullName: _fullNameController.text,
        address: _addressController.text,
        electoralSeat: _electoralSeatController.text,
        kottashaya: _kottashayaNoController.text,
        firstTelephoneNo: _firstTelephoneNoController.text,
        secondTelephoneNo: _secondTelephoneNoController.text,
        job: _jobController.text,
        fbUserName: _fbUserNameValueNotifier.value,
        preferredFieldToJoin: _preferredFieldToJoinController.text,
        preferredRegionToOperate: _preferredRegionToOperateController.text,
        houseNumber: _houseNumberController.text,
        dateInTheForm: _dateInTheFormNotifier.value,
      );
      //TODO: set created date in service

      GetIt.I<MembershipService>()
          .createMembershipRecord(newMember)
          .then(
            (value) {
          if (value) {
            // clearInputFields();
            //සාමාජිකයා එකතු කිරීම සාර්ථකයි.
            showSaveResultMessage(context, true, "idudðlhd tl;= lsÍu id¾:lhs'");
          } else {
            //මෙම ජා.හැ. අංකයෙන් සාමාජිකයෙක් ඇත.
            showSaveResultMessage(context, false, "fuu cd'ye' wxlfhka idudðlfhla we;'");
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
  //#end region functions

}
