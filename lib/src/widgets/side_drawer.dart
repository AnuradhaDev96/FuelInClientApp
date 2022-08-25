import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../config/language_settings.dart' as lang_settings;

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(25.0), bottomRight: Radius.circular(25.0)),
        boxShadow: [
          BoxShadow(
            color: AppColors.grayForPrimaryDark,
            blurRadius: 12.0,
          ),
        ]
      ),
      child: Drawer(
      backgroundColor: AppColors.goldYellow,
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                lang_settings.SettingsSinhala.ruhunuHandaText,
                style: TextStyle(
                  fontSize: 20.0
                )
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
              ),
              hoverColor: Colors.red,
              title: Text(
                lang_settings.SettingsSinhala.unusumPuwathText,
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
              ),
              title: Text(
                lang_settings.SettingsSinhala.wyaparikaPuwathText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
