import 'package:flutter/material.dart';

import '../../../config/assets.dart';
import '../../../models/hotel_branch/hotel_branch.dart';

class HomeContent extends StatelessWidget {
  HomeContent({Key? key}) : super(key: key);
  final List<HotelBranch> branchesList = [
    HotelBranch(
      description:
          "Overlooking the mass blue of the Indian Ocean, Element Unawatuna embodies the true essence of luxury for your Sri Lankan beach vacation. Sun-soaked tranquility and breathtaking views, outstanding cuisine and luxury accommodation.",
      img: Assets.branchOneBed,
      city: "Unawatuna",
    ),
    HotelBranch(
      description:
      "Discover the eclectic paradise of Bentota, and explore the surrounding beaches amd countryside and the vibrant nightlife as you bask in idyllic bliss amidst the sun kissed beaches of southern Sri Lanka.",
      img: Assets.branchTwoBed,
      city: "Bentota",
    ),
    HotelBranch(
      description:
      "Discover the glamour of Browns beach and spend your memorable days with us in our Negombo hotel. The lovely beach and the colorful environment will be you way to happiness.",
      img: Assets.branchThreeBed,
      city: "Negombo",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: branchesList.length,
        itemBuilder: hotelBranchesBuilder,
      ),
    );
  }

  Widget hotelBranchesBuilder(BuildContext context, int index) {
    final branch = branchesList[index];
    return Container(
      // elevation: 3,
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 180.0,
            child: Image.asset(branch.img, fit: BoxFit.fill,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  branch.city,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: branch.description
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


}
