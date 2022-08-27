import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../models/accommodation/accommodation.dart';
import '../../models/enums/branch_name.dart';

class AccommodationList extends StatelessWidget {
  AccommodationList({Key? key, this.branchName}) : super(key: key);
  final BranchNames? branchName;

  final List<Accommodation> accommodationList = [
    Accommodation(
      floorNo: 3,
      size: 360,
      noOfRooms: 120,
      id: "R0001",
      description:
      "As the name implies, our presidential suite is the ultimate in luxury and our Bentota hotel’s most lavish room. Choose this suite for the perfect mix of luxury and residential-style features, such as a kitchenette, bar counter, dining room and lounge area, replete with all the amenities one could need for a truly pampered stay.",
      refBranch: "Unawatuna",
      roomName: "Presidential Suite",
    ),
    Accommodation(
      floorNo: 1,
      size: 42,
      noOfRooms: 5,
      id: "R0002",
      description:
      "Our standard Citrus rooms are far from ‘basic’. The superior rooms offer a king sized bed and private balcony with an incredible sea view and many amenities to make your stay a delightful one. Each room provides stylish, contemporary accommodation with the Citrus flare, making it the ideal place for a fun vacation when looking for hotels near Bentota beaches.",
      refBranch: "Bentota",
      roomName: "Superior Room",
    ),
    Accommodation(
      floorNo: 2,
      size: 67,
      noOfRooms: 5,
      id: "R0003",
      description:
      "Experience the next level of luxury at one of the best Kalutara beach hotels with our deluxe rooms. Including all the amenities featured in our superior room, deluxe rooms also come with a Jacuzzi bathtub for a truly indulgent vacation.",
      refBranch: "Bentota",
      roomName: "Deluxe Suite",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: ListView.builder(
          itemCount: accommodationList.length,
          itemBuilder: accommodationItemBuilder,
        ),
      ),
    );
  }

  Widget accommodationItemBuilder(BuildContext context, int index) {
    final accommodation = accommodationList[index];

    return Card(

      elevation: 5,
      color: AppColors.lightGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.indigoMaroon,
              width: 200.0,
              height: 25.0,
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                accommodation.roomName,
                style: const TextStyle(
                    color: AppColors.goldYellow
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                const Text(
                  "No of rooms:",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "${accommodation.noOfRooms}",
                  style: const TextStyle(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Floor Number: ",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "${accommodation.floorNo}",
                  style: const TextStyle(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Size of room: ",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "${accommodation.size}",
                  style: const TextStyle(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
