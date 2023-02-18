import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/ui/landing_page/request_access_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_colors.dart';
import '../../config/assets.dart';
import '../../config/language_settings.dart';
import '../../models/authentication/authenticated_user.dart';
import '../../models/change_notifiers/application_auth_notifier.dart';
import '../../models/enums/user_types.dart';
import '../../services/auth_service.dart';
import '../../utils/common_utils.dart';
import '../../utils/message_utils.dart';
import '../../utils/navigation_utils.dart';
import '../../utils/web_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final GlobalKey<ScaffoldState> _landingScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _authEmailAddressController = TextEditingController();
  final TextEditingController _authPasswordController = TextEditingController();
  final FocusNode _authEmailFieldFocusNode = FocusNode();
  final FocusNode _authPasswordFieldFocusNode = FocusNode();
  final ValueNotifier<bool> _isPasswordTextHidden = ValueNotifier<bool>(true);
  final List<bool> _mobileLoginPanelExpandStatus = <bool>[false];

  @override
  void dispose() {
    _authEmailFieldFocusNode.dispose();
    _authPasswordFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _landingScaffoldKey,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 18.0),
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
                  const SizedBox(height: 35.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 120.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Assets.lockIconSvg,
                              width: 397 * 0.5,
                              height: 397 * 0.5,
                            ),
                            const SizedBox(height: 35.0),
                            const Text(
                              "Waiting in queues,\nis now over.",
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
                              "Login to your FuelIn Account",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Form(
                              key: _signInFormKey,
                              child: Column(
                                // shrinkWrap: true,
                                // padding: const EdgeInsets.all(2.0),
                                children: [

                                  // const SizedBox(height: 5.0),
                                  _buildAuthEmailField(),
                                  _buildAuthPasswordField(),
                                  // const SizedBox(height: 5.0),
                                  _buildSignInButton(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 1.0,
                                    width: 220.0,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    "or",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Container(
                                    height: 1.0,
                                    width: 220.0,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                _buildCreateAccountButton(),
                                _registerAsStationOwner(),
                                _registerAsDriver(),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }



  // Widget _buildMobileContent() {
  //   return ListView(
  //     children: [
  //       Container(
  //         width: MediaQuery.of(context).size.width,
  //         // height: double.infinity,
  //         color: AppColors.darkPurple,
  //         padding: const EdgeInsets.all(8.0),
  //         child: _signInSectionMobile(),
  //       ),
  //       RequestAccessForm(),
  //     ],
  //   );
  // }

  // Widget _signInSectionMobile() {
  //   return ExpansionPanelList(
  //     elevation: 0,
  //     expansionCallback: (int panelIndex, bool isExpanded) {
  //       setState(() {
  //         _mobileLoginPanelExpandStatus[panelIndex] = !_mobileLoginPanelExpandStatus[panelIndex];
  //       });
  //     },
  //     children: [
  //       ExpansionPanel(
  //         backgroundColor: AppColors.darkPurple,
  //         canTapOnHeader: true,
  //         isExpanded: _mobileLoginPanelExpandStatus[0],
  //         headerBuilder: (BuildContext context, bool isExpanded) {
  //           return Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: const [
  //               Text(
  //                 'Log In',
  //                 style: TextStyle(
  //                   fontFamily: SettingsSinhala.engFontFamily,
  //                   fontSize: 25.0,
  //                   color: AppColors.silverPurple,
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //         body: Form(
  //           key: _signInFormKey,
  //           child: ListView(
  //             shrinkWrap: (CommonUtils.isMobileUI(context)) ? true : false,
  //             padding: const EdgeInsets.all(2.0),
  //             children: [
  //
  //               // const SizedBox(height: 5.0),
  //               _buildAuthEmailField(),
  //               _buildAuthPasswordField(),
  //               // const SizedBox(height: 5.0),
  //               _buildSignInButton(),
  //             ],
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget _signInSection() {
  //   return Form(
  //     key: _signInFormKey,
  //     child: ListView(
  //       shrinkWrap: (CommonUtils.isMobileUI(context)) ? true : false,
  //       padding: const EdgeInsets.all(2.0),
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: const [
  //             Text(
  //               'Log In',
  //               style: TextStyle(
  //                 fontFamily: SettingsSinhala.engFontFamily,
  //                 fontSize: 25.0,
  //                 color: AppColors.silverPurple,
  //               ),
  //             ),
  //           ],
  //         ),
  //         // const SizedBox(height: 5.0),
  //         _buildAuthEmailField(),
  //         _buildAuthPasswordField(),
  //         // const SizedBox(height: 5.0),
  //         _buildSignInButton(),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildAuthEmailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "USER NAME",
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            width: 500.0,
            height: 40.0,
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
                hintText: "User Name",
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
          const SizedBox(height: 6.0),
          SizedBox(
            width: 500.0,
            height: 40.0,
            child: ValueListenableBuilder(
              valueListenable: _isPasswordTextHidden,
              builder: (context, snapshot, child) {
                return TextFormField(
                  controller: _authPasswordController,
                  focusNode: _authPasswordFieldFocusNode,
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
                  onFieldSubmitted: (String value) => _signInAction(),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
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
          onPressed: _signInAction,
          child: const Text(
            "LOG IN",
            // style: const TextStyle(color: AppColors.nppPurple, fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 130,
        height: 30,
        child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStateProperty.all(
                AppColors.darkPurple
            ),
            shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))
                )
            ),
            // textStyle: MaterialStateProperty.all(const TextStyle(
            //       fontFamily: 'DL-Paras',
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.0,
            //     )),
          ),
          onPressed: _onTapCreateAccount,
          child: const Text(
            "Create Account",
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      ),
    );
  }

  Widget _registerAsStationOwner() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        height: 35,
        child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStateProperty.all(
                AppColors.darkPurple
            ),
            shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                )
            ),
            // textStyle: MaterialStateProperty.all(const TextStyle(
            //       fontFamily: 'DL-Paras',
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.0,
            //     )),
          ),
          onPressed: _onTapCreateAccount,
          child: const Text(
            "Register as Fuel Station Owner",
            style: TextStyle(fontSize: 12.0,),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _registerAsDriver() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 150,
        height: 35,
        child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStateProperty.all(
                AppColors.darkPurple
            ),
            shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                )
            ),
            // textStyle: MaterialStateProperty.all(const TextStyle(
            //       fontFamily: 'DL-Paras',
            //       fontWeight: FontWeight.w500,
            //       fontSize: 18.0,
            //     )),
          ),
          onPressed: _onTapCreateAccount,
          child: const Text(
            "Register as Vehicle Owner",
            style: TextStyle(fontSize: 12.0,),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void notifyAppIsAuthenticated(AuthenticatedUser authenticatedUser) {
    Provider.of<ApplicationAuthNotifier>(context, listen: false).setAppAuthenticated(authenticatedUser);
  }

  void _onTapCreateAccount() {
    GetIt.I<NavigationUtils>().pushNamed(
      WebRouter.createAccountPage,
    );
  }

  void _signInAction() async {
    if (_signInFormKey.currentState!.validate()) {
      _signInFormKey.currentState!.save();
      print("Validated");
      try {
        AuthenticatedUser? authenticatedUser = await GetIt.I<AuthService>().passwordLogin(_authEmailAddressController.text, _authPasswordController.text);
        if (authenticatedUser != null) {
          if (authenticatedUser.userType == UserTypes.systemAdmin) {
            notifyAppIsAuthenticated(authenticatedUser);
          } else if (authenticatedUser.userType == UserTypes.fuelStationManager) {
            notifyAppIsAuthenticated(authenticatedUser);
          } else {
            return;
          }
        }
      } catch (e) {
        if (mounted) MessageUtils.showErrorInFlushBar(context, "Email or password is incorrect", appearFromTop: false, duration: 4);
      }
    }
    if (_authEmailFieldFocusNode.hasFocus) _authEmailFieldFocusNode.unfocus();
    if (_authPasswordFieldFocusNode.hasFocus) _authPasswordFieldFocusNode.unfocus();
  }
}
