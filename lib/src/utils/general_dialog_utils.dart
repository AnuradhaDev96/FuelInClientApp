import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../config/app_colors.dart';

class GeneralDialogUtils {

  showCustomGeneralDialog({required BuildContext context, required Widget child, required String title,}) async {
    return await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: AppColors.silverPurple.withOpacity(0.5),
      pageBuilder: (context, _, __) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 30.0),
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            decoration: const BoxDecoration(
                              color: AppColors.nppPurple,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(40.0),
                              ),
                            ),
                            child: CustomScrollView(
                              slivers: [
                                SliverPinnedHeader(
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    margin: const EdgeInsets.only(left: 18.0),
                                    // width: 50.0,
                                    height: 80.0,
                                    color: AppColors.nppPurple,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          icon: const Icon(
                                              Icons.close_rounded
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SliverFillRemaining(
                                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: child,),
                                ),
                              ],
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }


}