import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_colors.dart';
import '../../config/assets.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final GlobalKey<ScaffoldState> _signUpScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  //text editing controllers
  final TextEditingController _authEmailAddressController = TextEditingController();
  final TextEditingController _authPasswordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();

  final ValueNotifier<bool> _isPasswordTextHidden = ValueNotifier<bool>(true);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _signUpScaffoldKey,
      resizeToAvoidBottomInset: true,
      // appBar: PreferredSize(
      //   preferredSize: Size(MediaQuery.of(context).size.width, 80),
      //   child: AppBar(
      //       backgroundColor: AppColors.appBarColor,
      //       leading: Padding(
      //         padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
      //         child: ClipOval(
      //           // height: 25.0,
      //           // width: 25.0,
      //           child: Image.asset(Assets.nppGroupCircle, fit: BoxFit.fill),
      //         ),
      //       ),
      //       elevation: 8.0,
      //       title: Padding(
      //         padding: const EdgeInsets.only(top: 8.0),
      //         child: RichText(
      //           text: const TextSpan(
      //               style: TextStyle(
      //                 color: AppColors.white,
      //               ),
      //               children: [
      //                 TextSpan(
      //                   text: 'NPP  ',
      //                   style: TextStyle(
      //                     fontFamily: 'Oswald',
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 16.0,
      //                   ),
      //                 ),
      //                 TextSpan(
      //                   text: SettingsSinhala.webTitle,
      //                   style: TextStyle(
      //                     fontFamily: 'DL-Paras',
      //                     fontWeight: FontWeight.w500,
      //                     fontSize: 20.0,
      //                   ),
      //                 )
      //               ]),
      //         ),
      //       ),
      //       // bottom: PreferredSize(
      //       //   preferredSize: Size(MediaQuery.of(context).size.width, 100), child: Container(
      //       //   child: Flex(
      //       //     direction: Axis.vertical,
      //       //     children: [
      //       //       Image.asset(Assets.triLanguageLogo,),
      //       //     ]
      //       //   ),
      //       // ),
      //       // ),
      //     ),
      // ),
      // body: (CommonUtils.isMobileUI(context))
      //     ? _buildMobileContent()
      //     : Row(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Column(
      //             children: [
      //               Expanded(
      //                 child: Container(
      //                   width: MediaQuery.of(context).size.width * 0.28,
      //                   // height: double.infinity,
      //                   color: AppColors.darkPurple,
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: _signInSection(),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Expanded(
      //             child: RequestAccessForm(),
      //           )
      //         ],
      //       ),
      body: _buildStack(),
    );
  }

  Widget _buildStack() {
    return Stack(
      // fit: StackFit.,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              color: AppColors.darkPurple,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              color: AppColors.themeGrey,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 56.5, horizontal: 51.0),
          child: Material(
            elevation: 2.0,
            shadowColor: Colors.black45,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              side: BorderSide(
                color: AppColors.themeGrey.withOpacity(0.2),
                width: 12.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 120.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                Assets.fuelInLogoSvg,
                                width: 245 * 0.75,
                                height: 36 * 0.75,
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          Assets.lockIconSvg,
                          width: 397 * 0.5,
                          height: 397 * 0.5,
                        ),
                        const SizedBox(height: 35.0),
                        const Text(
                          "We protect your home,\nfamily and company.",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(width: 60.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Create your FuelIn Account",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Form(
                          key: _signUpFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFullNameField(),
                              Row(
                                children: [
                                  _buildAuthEmailField(),
                                  // _buildDesignationField(),
                                ],
                              ),
                              Row(
                                children: [
                                  _buildAuthPasswordField(),
                                  // _buildPhoneNumberField(),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     _buildNICField(),
                              //     _buildGenderField(),
                              //   ],
                              // ),
                              // const SizedBox(height: 5.0),
                              _buildSignUpButton(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAuthEmailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "LockHood email address",
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
              controller: _authEmailAddressController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email cannot be empty';
                }
                if (!EmailValidator.validate(value)) {
                  return "Enter valid email";
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
                  hintText: "Email Address (ex:- emmployeeid@lockhood.com)",
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

  Widget _buildFullNameField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "FULL NAME",
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4.0),
          SizedBox(
            width: 500.0,
            height: 35.0,
            child: TextFormField(
              controller: _fullNameController,
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
                  hintText: "Full Name (ex: Anuradha Sampath Dasanayake)",
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

  Widget _buildPhoneNumberField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PHONE NUMBER",
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
              controller: _authEmailAddressController,
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
                  hintText: "Phone Number (ex:- 0491 570 156)",
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

  Widget _buildDesignationField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "DESIGNATION",
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
              controller: _designationController,
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
                  hintText: "LockHood Employee",
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

  Widget _buildNICField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "NIC",
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
              controller: _nicController,
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
                  hintText: "XXXXXXXXX",
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

  Widget _buildGenderField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "GENDER",
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
              controller: _nicController,
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
                  hintText: "Male",
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

  Widget _buildAuthPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PASSWORD",
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4.0),
          SizedBox(
            width: 240.0,
            height: 35.0,
            child: ValueListenableBuilder(
                valueListenable: _isPasswordTextHidden,
                builder: (context, snapshot, child) {
                  return TextFormField(
                    controller: _authPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                    // autofocus: true,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: AppColors.black,
                    ),
                    obscureText: _isPasswordTextHidden.value,
                    keyboardType: TextInputType.text,
                    // textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      // prefixIcon: const Icon(Icons.key, size: 20.0,),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            _isPasswordTextHidden.value = !_isPasswordTextHidden.value;
                          },
                          child: const Icon(
                            Icons.visibility,
                            size: 20.0,
                          ),
                        ),
                      ),
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
                      ),
                      hintText: "Password",
                      hintStyle: const TextStyle(
                        color: AppColors.hintTextBlue,
                        fontSize: 14.0,
                      ),
                    ),
                    // onFieldSubmitted: (String value) => _signInAction(),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 500,
        height: 35,
        child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStateProperty.all(
                AppColors.darkPurple
            ),
            // textStyle: MaterialStateProperty.all(const TextStyle(
            //       fontFamily: 'DL-Paras',
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.0,
            //     )),
          ),
          onPressed: () {},
          child: const Text(
            "REGISTER",
            // style: const TextStyle(color: AppColors.nppPurple, fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}
