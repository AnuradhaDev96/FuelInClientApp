import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rh_reader/src/models/authentication/password_login_result.dart';
import 'package:rh_reader/src/services/auth_service.dart';
import 'package:rh_reader/src/ui/widgets/admin_home/admin_home.dart';
import 'package:rh_reader/src/utils/message_utils.dart';

import '../../config/app_colors.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_raised_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userNameController.text = "anuradhass@gmail.com";
    passwordController.text = "admin_z";

    var screenSize = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints(maxWidth: 1440),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: AppColors.indigoMaroon,
              width: screenSize.width * 0.7,
              child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.goldYellow,
                              shape: BoxShape.circle,
                            ),
                            height: 40,
                            width: 40,
                          ),
                          const Text(
                            '  E L E M E N T',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.height * 0,
                          ),
                          const Text(
                            'Home',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20.0,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.height * 0,
                          ),
                          const Text(
                            'Join',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20.0,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0,
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                            height: MediaQuery.of(context).size.height * 0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'ELEMENT RESORTS & SPA',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0,
                                height: MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Login to your account',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.goldYellow,
                                      shape: BoxShape.circle,
                                    ),
                                    height: 10,
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0,
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                              Row(
                                children: const [
                                  Text(
                                    'Not A member ?',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    'Not A member ?',
                                    style: TextStyle(
                                      color: AppColors.goldYellow,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0,
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                              Material(
                                child: CustomInputField(
                                  borderRadius: 20,
                                  borderColor: AppColors.lightGray,
                                  width: 0.32,
                                  height: 0.05,
                                  icon: Icons.mail,
                                  iconColor: Colors.grey,
                                  hintText: 'email',
                                  hintColor: Colors.grey,
                                  fontSize: 15,
                                  obsecureText: false,
                                  textEditingController: userNameController,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0,
                                height: MediaQuery.of(context).size.height * 0.02,
                              ),
                              Material(
                                child: CustomInputField(
                                  borderRadius: 20,
                                  borderColor: AppColors.lightGray,
                                  width: 0.32,
                                  height: 0.05,
                                  icon: Icons.lock,
                                  iconColor: Colors.grey,
                                  hintText: 'password',
                                  hintColor: Colors.grey,
                                  fontSize: 15,
                                  obsecureText: true,
                                  textEditingController: passwordController,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0,
                                height: MediaQuery.of(context).size.height * 0.04,
                              ),
                              // isLoggingChecking
                              // ? const Center(
                              //     child: LinearProgressIndicator(
                              //     color: Colors.yellow,
                              //     minHeight: 5,
                              //   ))
                              // :
                              CustomRaisedButton(
                                buttonTitle: 'Login to my account',
                                width: 0.32,
                                height: 0.05,
                                borderColor: AppColors.goldYellow,
                                borderRadius: 25,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontColor: AppColors.indigoMaroon,
                                onPressedAction: loginWithCredentials,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  void loginWithCredentials() async {
    try {
      final PasswordLoginResult? passwordLoginResult = await GetIt.I<AuthService>().passwordLogin(userNameController.text, passwordController.text);
      if (passwordLoginResult != null) {
        switch (passwordLoginResult.type) {
          case "Rider":
            navigateToAdminHomePage();
            break;
          default:
            break;
        }
      }
    } catch (e) {
      MessageUtils.showErrorInFlushBar(context, "Invalid username or password.", appearFromTop: false, duration: 4);
    }
  }

  void navigateToAdminHomePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AdminHome()),
      (_) => false,
    );
  }
}
