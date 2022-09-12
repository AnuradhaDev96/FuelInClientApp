import 'dart:html';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/assets.dart';
import '../../config/language_settings.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _authEmailAddressController = TextEditingController();
  final TextEditingController _authPasswordAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Row(
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
          )
        ],
      ),
    );
  }

  Widget _signInSection() {
    return Form(
      key: _signInFormKey,
      child: ListView(
        // shrinkWrap: true,
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
            child: TextFormField(
              controller: _authEmailAddressController,
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
              obscureText: true,
              keyboardType: TextInputType.text,
              // textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.key, size: 20.0,),
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
        onPressed: _signInAction,
        child: const Text(
          "msúfikak",
          // style: const TextStyle(color: AppColors.nppPurple, fontSize: 14.0),
        ),
      ),
    );
  }

  void _signInAction() {
    if (_signInFormKey.currentState!.validate()) {
      _signInFormKey.currentState!.save();
      print("Validated");
    }
  }
}
