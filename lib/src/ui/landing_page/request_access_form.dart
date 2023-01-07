import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/models/authentication/request_access_model.dart';
import 'package:matara_division_system/src/services/auth_service.dart';

import '../../config/app_colors.dart';
import '../../config/app_settings.dart';
import '../../config/language_settings.dart';
import '../../models/enums/user_types.dart';
import '../../utils/common_utils.dart';
import '../../utils/message_utils.dart';
import '../../utils/validator_utils.dart';

class RequestAccessForm extends StatelessWidget {
  RequestAccessForm({Key? key}) : super(key: key);

  static final GlobalKey<FormState> _requestAccessFormKey = GlobalKey<FormState>();

  static final TextEditingController _personalEmailController = TextEditingController();
  // final FocusNode _personalEmailFieldFocusNode = FocusNode();
  static final TextEditingController _fullNameController = TextEditingController();
  // final FocusNode _fullNameFieldFocusNode = FocusNode(canRequestFocus: false);
  static final TextEditingController _waPhoneNoController = TextEditingController();
  // final FocusNode _waPhoneNoFieldFocusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();
  final ScrollController _formScrollController = ScrollController();

  final UserTypes _defaultUserType = UserTypes.topLevel;
  static final ValueNotifier<UserTypes> _selectedUserType = ValueNotifier<UserTypes>(UserTypes.topLevel);
  final AuthService _authService = GetIt.I<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      scrollbarOrientation: ScrollbarOrientation.right,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                SettingsSinhala.requestAccessTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
              ),
            ),
            const Text("Request Access to System",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.darkPurple,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: SettingsSinhala.engFontFamily),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: (CommonUtils.isMobileUI(context))
                  ? MediaQuery.of(context).size.width * 0.95
                  : MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.91,
              child: Card(
                elevation: 5.0,
                color: AppColors.lightGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Form(
                    key: _requestAccessFormKey,
                    child: ListView(
                      controller: _formScrollController,
                      children: [
                        _buildFullNameField(),
                        _buildPersonalEmailField(),
                        _buildWAPhoneField(),
                        _buildUserTypeDropdown(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: _buildRequestAccessButton(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _buildFullNameField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "iïmQ¾K ku(", //සම්පූර්ණ නම:
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            // width: 100.0,
            height: 80.0,
            child: TextFormField(
              controller: _fullNameController,
              // focusNode: _fullNameFieldFocusNode,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'ms<s;=r wksjd¾hhs';//පිළිතුර අනිවාර්යයි!
                }
                return null;
              },
              // onEditingComplete: () {
              //   // if (_fullNameFieldFocusNode.hasFocus)
              //   _fullNameFieldFocusNode.unfocus();
              //   _personalEmailFieldFocusNode.requestFocus();
              // },
              style: const TextStyle(
                fontSize: 14.0,
                fontFamily: SettingsSinhala.engFontFamily,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
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
        ],
      ),
    );
  }

  Widget _buildWAPhoneField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: AppColors.white,
              ),
              children: [
                TextSpan(
                  text: 'Whatsapp  ',
                  style: TextStyle(
                    fontFamily: SettingsSinhala.engFontFamily,
                    fontSize: 12.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: "ÿrl:k wxlh(", //දුරකථන අංකය:,
                  style: TextStyle(
                    fontFamily: 'DL-Paras',
                    fontSize: 14.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            // width: 100.0,
            height: 80.0,
            child: TextFormField(
              controller: _waPhoneNoController,
              // focusNode: _waPhoneNoFieldFocusNode,
              maxLength: 10,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'ms<s;=r wksjd¾hhs';//පිළිතුර අනිවාර්යයි!
                }
                if (!isLKPhoneNumber(value)) {
                  return "wxl 10lska hq;a ksjerÈ ÿl wxlhla wjYHhhs"; //අංක 10කින් යුත් නිවැරදි දුක අංකයක් අවශ්‍යයයි
                }
                return null;
              },
              // onEditingComplete: () {
              //   if (_waPhoneNoFieldFocusNode.hasFocus) _waPhoneNoFieldFocusNode.unfocus();
              // },
              style: const TextStyle(
                fontSize: 14.0,
                fontFamily: SettingsSinhala.engFontFamily,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              keyboardType: TextInputType.phone,
              // textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.whatsapp_outlined, size: 20.0),
                counterStyle: const TextStyle(fontFamily: SettingsSinhala.engFontFamily),
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
        ],
      ),
    );
  }

  Widget _buildPersonalEmailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ",shdmÈxÑh i|yd Bfï,a ,smskh(",//ලියාපදිංචිය සඳහා ඊමේල් ලිපිනය:
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            // width: 100.0,
            height: 80.0,
            child: TextFormField(
              controller: _personalEmailController,
              // focusNode: _personalEmailFieldFocusNode,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'ms<s;=r wksjd¾hhs';//පිළිතුර අනිවාර්යයි!
                }
                if (!EmailValidator.validate(value)) {
                  return "ksjerÈ Bfï,a ,smskhla wjYHhhs"; //නිවැරදි ඊමේල් ලිපිනයක් අවශ්‍යයයි
                }
                return null;
              },
              style: const TextStyle(
                fontSize: 14.0,
                fontFamily: SettingsSinhala.engFontFamily,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              // onEditingComplete: () {
              //   if (_personalEmailFieldFocusNode.hasFocus) _personalEmailFieldFocusNode.unfocus();
              //   _waPhoneNoFieldFocusNode.requestFocus();
              // },
              keyboardType: TextInputType.emailAddress,
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
        ],
      ),
    );
  }

  Widget _buildUserTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ";k;=r\$j.lSu(",//තනතුර/වගකීම:
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6.0),
          ValueListenableBuilder(
            valueListenable: _selectedUserType,
            builder: (context, snapshot, child) {
              return DropdownButtonFormField(
                // underline: const SizedBox(width: 0, height: 0),
                value: _selectedUserType.value.toDisplaySinhalaString(),
                isExpanded: false,
                elevation: 3,
                borderRadius: BorderRadius.circular(12.0),
                dropdownColor: AppColors.darkPurple,
                hint: const Text(
                  'Select User Type',
                ),

                items: AppSettings.getSinhalaValuesOfUserTypes().map((userType) => DropdownMenuItem(
                  value: userType,
                  child: Text(
                    userType,
                    style: const TextStyle(
                      color: AppColors.grayForPrimary,
                    ),
                  ),
                )).toList(),
                onChanged: (String? selectedValue) {
                  _selectedUserType.value =
                      selectedValue == null ? _defaultUserType : AppSettings.getEnumValueFromSinhalaValue(selectedValue);
                },
                decoration: InputDecoration(
                  // prefixIcon: const Icon(Icons.whatsapp_outlined, size: 20.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(width: 1, color: AppColors.lightGray)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.darkPurple),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  // focusedErrorBorder: OutlineInputBorder(
                  //   borderSide: const BorderSide(width: 1, color: AppColors.nppPurple),
                  //   borderRadius: BorderRadius.circular(12.0),
                  // ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  Widget _buildRequestAccessButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _requestAccessAction(context),
        child: const Text(
          "whÿï lrkak",//අයදුම් කරන්න
          // style: const TextStyle(color: AppColors.nppPurple, fontSize: 14.0),
        ),
      ),
    );
  }

  void _requestAccessAction(BuildContext context) async {
    if (_requestAccessFormKey.currentState!.validate()) {
      _requestAccessFormKey.currentState!.save();
      RequestAccessModel requestAccessModel = RequestAccessModel(
          fullName: _fullNameController.text,
          email: _personalEmailController.text,
          designation: "",
          phoneNumber: int.tryParse(_waPhoneNoController.text) ?? 0,
          userType: _selectedUserType.value,
      );

      await _authService.saveAccessRequestByAnonymous(requestAccessModel).then((result) {
        if (result) {
          clearInputFields();
          MessageUtils.showSuccessInFlushBar(context, "ia;+;shs' m%fõYh ikd: lsÍfï Bfï,h ,efnk f;la isákak'", appearFromTop: false, duration: 4);
          //ස්තූතියි. ප්‍රවේශය සනාථ කිරීමේ ඊමේලය ලැබෙන තෙක් සිටින්න.
        } else {
          MessageUtils.showErrorInFlushBar(context, "fuu Bfï,a ,smskfhka b,a,Sula lr we;' m%;spdrhla ,efnk ;=re isákak'", appearFromTop: false, duration: 4);
          //මෙම ඊමේල් ලිපිනයෙන් ඉල්ලීමක් කර ඇත. ප්‍රතිචාරයක් ලැබෙන තුරු සිටින්න.
        }
      });
    }
  }

  void clearInputFields() {
    _fullNameController.clear();
    _personalEmailController.clear();
    _waPhoneNoController.clear();
    _selectedUserType.value = _defaultUserType;
  }
}
