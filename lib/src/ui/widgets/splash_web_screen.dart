import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/assets.dart';

class SplashWebScreen extends StatelessWidget {
  const SplashWebScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.silverPurple,
      child: Center(
        child: SizedBox(
          width: 150,
          height: 70,
          child: Image.asset(Assets.lockHoodLogo, fit: BoxFit.fill,),
        ),
      ),
    );
  }
}
