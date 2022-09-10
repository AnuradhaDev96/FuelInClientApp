import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../models/change_notifiers/checkin_customer_page_view_notifier.dart';

class SecondAssignRoomsPageItem extends StatelessWidget {
  const SecondAssignRoomsPageItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.4,
      color: AppColors.ashMaroon,
      child: ElevatedButton(
        onPressed: () {
          Provider.of<CheckInCustomerPageViewNotifier>(context, listen: false).jumpToPreviousPage();
        },
        child: const Text(
          "jump to first",
          style: TextStyle(color: AppColors.goldYellow, fontSize: 14.0),
        ),
      ),
    );
  }
}
