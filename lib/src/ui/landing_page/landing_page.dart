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
    );
  }
}
