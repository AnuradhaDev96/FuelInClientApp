import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/ui/landing_page/request_access_form.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/assets.dart';
import '../../config/language_settings.dart';
import '../../models/authentication/authenticated_user.dart';
import '../../models/change_notifiers/application_auth_notifier.dart';
import '../../models/enums/user_types.dart';
import '../../services/auth_service.dart';
import '../../utils/common_utils.dart';
import '../../utils/message_utils.dart';

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
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 80),
        child: AppBar(
            backgroundColor: AppColors.appBarColor,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
              child: ClipOval(
                // height: 25.0,
                // width: 25.0,
                child: Image.asset(Assets.nppGroupCircle, fit: BoxFit.fill),
              ),
            ),
            elevation: 8.0,
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'NPP  ',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      TextSpan(
                        text: SettingsSinhala.webTitle,
                        style: TextStyle(
                          fontFamily: 'DL-Paras',
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      )
                    ]),
              ),
            ),
            // bottom: PreferredSize(
            //   preferredSize: Size(MediaQuery.of(context).size.width, 100), child: Container(
            //   child: Flex(
            //     direction: Axis.vertical,
            //     children: [
            //       Image.asset(Assets.triLanguageLogo,),
            //     ]
            //   ),
            // ),
            // ),
          ),
      ),
      body: (CommonUtils.isMobileUI(context))
          ? _buildMobileContent()
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.28,
                        // height: double.infinity,
                        color: AppColors.nppPurple,
                        padding: const EdgeInsets.all(8.0),
                        child: _signInSection(),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: RequestAccessForm(),
                )
              ],
            ),
    );
  }

  Widget _buildMobileContent() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          // height: double.infinity,
          color: AppColors.nppPurple,
          padding: const EdgeInsets.all(8.0),
          child: _signInSectionMobile(),
        ),
        RequestAccessForm(),
      ],
    );
  }

  Widget _signInSectionMobile() {
    return ExpansionPanelList(
      elevation: 0,
      expansionCallback: (int panelIndex, bool isExpanded) {
        setState(() {
          _mobileLoginPanelExpandStatus[panelIndex] = !_mobileLoginPanelExpandStatus[panelIndex];
        });
      },
      children: [
        ExpansionPanel(
          backgroundColor: AppColors.nppPurple,
          canTapOnHeader: true,
          isExpanded: _mobileLoginPanelExpandStatus[0],
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Log In',
                  style: TextStyle(
                    fontFamily: SettingsSinhala.engFontFamily,
                    fontSize: 25.0,
                    color: AppColors.silverPurple,
                  ),
                ),
              ],
            );
          },
          body: Form(
            key: _signInFormKey,
            child: ListView(
              shrinkWrap: (CommonUtils.isMobileUI(context)) ? true : false,
              padding: const EdgeInsets.all(2.0),
              children: [

                // const SizedBox(height: 5.0),
                _buildAuthEmailField(),
                _buildAuthPasswordField(),
                // const SizedBox(height: 5.0),
                _buildSignInButton(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _signInSection() {
    return Form(
      key: _signInFormKey,
      child: ListView(
        shrinkWrap: (CommonUtils.isMobileUI(context)) ? true : false,
        padding: const EdgeInsets.all(2.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Log In',
                style: TextStyle(
                  fontFamily: SettingsSinhala.engFontFamily,
                  fontSize: 25.0,
                  color: AppColors.silverPurple,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 5.0),
          _buildAuthEmailField(),
          _buildAuthPasswordField(),
          // const SizedBox(height: 5.0),
          _buildSignInButton(),
        ],
      ),
    );
  }

  Widget _buildAuthEmailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bfï,a ,smskh(",
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            // width: 100.0,
            height: 80.0,
            child: RawKeyboardListener(
              focusNode: _authEmailFieldFocusNode,
              onKey: (event) {
                if (event.logicalKey == LogicalKeyboardKey.tab) {
                  _authEmailFieldFocusNode.nextFocus();
                }
              },
              child: TextFormField(
                controller: _authEmailAddressController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bfï,a ,smskh we;=,;a lrkak';
                  }
                  if (!EmailValidator.validate(value)) {
                    return "ksjerÈ Bfï,a ,smskh we;=,;a lrkak";
                  }
                  return null;
                },
                style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: SettingsSinhala.engFontFamily,
                  color: AppColors.white,
                ),
                keyboardType: TextInputType.emailAddress,
                // textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.mail, size: 20.0,),
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
                    borderSide: const BorderSide(width: 1, color: Colors.amber),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  errorStyle: const TextStyle(
                    color: Colors.amber,
                  )
                ),
                // textInputAction: TextInputAction.next,
                onFieldSubmitted: (String value) {
                  _authPasswordFieldFocusNode.requestFocus();
                },
              ),
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
            "uqrmoh(",
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            // width: 100.0,
            height: 80.0,
            child: ValueListenableBuilder(
              valueListenable: _isPasswordTextHidden,
              builder: (context, snapshot, child) {
                return TextFormField(
                  controller: _authPasswordController,
                  focusNode: _authPasswordFieldFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'uqrmoh we;=,;a lrkak';
                    }
                    return null;
                  },
                  // autofocus: true,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontFamily: SettingsSinhala.engFontFamily,
                    color: AppColors.white,
                  ),
                  obscureText: _isPasswordTextHidden.value,
                  keyboardType: TextInputType.text,
                  // textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.key, size: 20.0,),
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
                      borderSide: const BorderSide(width: 1, color: Colors.amber),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.amber,
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
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          backgroundColor: MaterialStateProperty.all(
              AppColors.appBarColor
          ),
          textStyle: MaterialStateProperty.all(const TextStyle(
                fontFamily: 'DL-Paras',
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              )),
            ),
        onPressed: _signInAction,
        child: const Text(
          "msúfikak",
          // style: const TextStyle(color: AppColors.nppPurple, fontSize: 14.0),
        ),
      ),
    );
  }

  void notifyAppIsAuthenticated(AuthenticatedUser authenticatedUser) {
    Provider.of<ApplicationAuthNotifier>(context, listen: false).setAppAuthenticated(authenticatedUser);
  }

  void _signInAction() async {
    if (_signInFormKey.currentState!.validate()) {
      _signInFormKey.currentState!.save();
      print("Validated");
      try {
        AuthenticatedUser? authenticatedUser = await GetIt.I<AuthService>().passwordLogin(_authEmailAddressController.text, _authPasswordController.text);
        if (authenticatedUser != null) {
          print("####${authenticatedUser.userType}");
          if (authenticatedUser.userType == UserTypes.systemAdmin) {
            print("Logged inSuzzessfully as admin");
            notifyAppIsAuthenticated(authenticatedUser);
          } else if (authenticatedUser.userType == UserTypes.seatOrganizer) {
            notifyAppIsAuthenticated(authenticatedUser);
          } else {
            return;
          }
        }
      } catch (e) {
        if (mounted) MessageUtils.showErrorInFlushBar(context, "Bfï,a ,smskh fyda uqrmoh jerÈ neúka msúiSug fkdyel'", appearFromTop: false, duration: 4);
        //ඊමේල් ලිපිනය හෝ මුරපදය වැරදි බැවින් පිවිසීමට නොහැක.
      }
    }
    if (_authEmailFieldFocusNode.hasFocus) _authEmailFieldFocusNode.unfocus();
    if (_authPasswordFieldFocusNode.hasFocus) _authPasswordFieldFocusNode.unfocus();
  }
}
