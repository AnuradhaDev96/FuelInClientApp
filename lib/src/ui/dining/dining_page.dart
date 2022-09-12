import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../models/dining/dining.dart';


class DiningPage extends StatelessWidget {
  DiningPage({Key? key}) : super(key: key);
  final List<Dining> servicesList = [
    Dining(
      name: "Lemon Sun Restaurant",
      description: "Our world class chefs will serve you mouth-watering dishes showcasing incredible variety with extensive menus that feature both local and international cuisine, making it the perfect restaurant near me for dinner.",
    ),
    Dining(
      name: "Pips n’ Sips Coffee Shop",
      description: "Our coffee shop is a quaint Negombo restaurant that serves snacks and all types of beverages throughout the day.",
    ),
    Dining(
      name: "Sky Lime Beach Lounge",
      description: "The venue can accommodate all your requirements catering to group and private functions, meaning that family restaurants near me don’t get better than Sky Lime.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: ListView.builder(
        itemCount: servicesList.length,
        itemBuilder: serviceItemBuilder,
      ),
    );
  }

  Widget serviceItemBuilder(BuildContext context, int index) {
    final hotelService = servicesList[index];

    return Card(
      elevation: 5,
      color: AppColors.lightGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: AppColors.ashYellow,
              width: 150.0,
              height: 100.0,
              padding: const EdgeInsets.only(left: 8.0, top: 5.0, right: 8.0),
              child: RichText(
                maxLines: 2,
                text: TextSpan(
                  text: hotelService.name,
                  style: const TextStyle(
                      color: AppColors.silverPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: RichText(
                maxLines: 2,
                text: TextSpan(
                  text: hotelService.description,
                  style: const TextStyle(
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
