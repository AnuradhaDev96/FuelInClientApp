import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../models/accommodation/accommodation.dart';
import '../../models/enums/branch_name.dart';

class AccommodationList extends StatelessWidget {
  AccommodationList({Key? key, this.branchName}) : super(key: key);
  final BranchNames? branchName;

  final List<Accommodation> accommodationList = Accommodation.systemRoomList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: ListView.builder(
        itemCount: accommodationList.length,
        itemBuilder: accommodationItemBuilder,
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
              color: AppColors.silverPurple,
              width: 200.0,
              height: 25.0,
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                accommodation.roomName ?? "-",
                style: const TextStyle(
                    color: AppColors.darkPurple
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
