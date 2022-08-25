import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../config/assets.dart';
import '../../../models/change_notifiers/side_drawer_notifier.dart';
import '../../../widgets/side_drawer.dart';

class ReaderHome extends StatefulWidget {
  const ReaderHome({Key? key}) : super(key: key);

  @override
  State<ReaderHome> createState() => _ReaderHomeState();
}

class _ReaderHomeState extends State<ReaderHome> {
  late final SideDrawerNotifier _sideDrawerNotifier;

  @override
  void initState() {
    _sideDrawerNotifier = GetIt.I<SideDrawerNotifier>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sideDrawerNotifier.mainScaffoldKey,
      drawer: const SideDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO: Check for desktop and remove side menu for mobile
          const Expanded(
            flex: 1,
            child: SideDrawer()
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        Assets.homeCoverPhotoA,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
                  //   child: Material(
                  //     borderRadius: BorderRadius.circular(15.0),
                  //     color: Colors.white,
                  //     elevation: 5.0,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(5.0),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             ''
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   height: 10.0,
                  //   color: Colors.blue,
                  // )
                ],
              ),
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 250.0,
              color: Colors.yellow,
            ),
          )
        ],
      ),
    );
  }
}
