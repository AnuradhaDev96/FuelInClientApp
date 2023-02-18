import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_colors.dart';
import '../../config/assets.dart';

class SplashWebScreen extends StatelessWidget {
  const SplashWebScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.silverPurple,
      child: Center(
        child: SvgPicture.asset(
          Assets.fuelInLogoSvg,
          width: 245 * 0.75,
          height: 36 * 0.75,
        ),
      ),
    );
  }
}
