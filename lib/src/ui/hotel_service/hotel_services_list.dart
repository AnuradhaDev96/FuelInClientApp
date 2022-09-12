import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../models/hotel_service/hotel_service.dart';

class HotelServicesList extends StatelessWidget {
  HotelServicesList({Key? key}) : super(key: key);
  final List<HotelService> servicesList = [
    HotelService(
      serviceName: "SPA",
      description: "Ignite your senses at The Citron Senses Spa at Element Bentota. A veritable spa in Kalutara, Citron Senses offers the finest rejuvenation and restoration treatments that will transport you to the seventh heaven of bliss.",
    ),
    HotelService(
      serviceName: "Ballroom Weddings",
      description: "If you want to feel like a princess on your special day, host your nuptials at our wedding halls in Kalutara: grand ballrooms that will make for a fairy-tale beginning, perfect for wedded life. Chandeliers, tasteful interiors and a regal ambiance combine to bring your dream wedding to life.",
    ),
    HotelService(
      serviceName: "Beach Weddings",
      description: "Whether a beach wedding, garden wedding or a grand wedding in our elegantly designed ballrooms, or even if you want a combination of all three, there is nothing more that you desire than a perfect destination wedding in Sri Lanka. But for us, everything should be more than just perfect; it should be spectacular.",
    ),
    HotelService(
      serviceName: "Meetings n Events",
      description: "While maintaining the hotel’s chic style and sophisticated setting, our venues are diverse and adaptable with plenty of natural daylight. The beautiful gardens provide the perfect setting for outdoor events and activities.",
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
              color: AppColors.ashGreen,
              width: 150.0,
              height: 100.0,
              padding: const EdgeInsets.only(left: 8.0, top: 5.0, right: 8.0),
              child: RichText(
                maxLines: 2,
                text: TextSpan(
                  text: hotelService.serviceName,
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
