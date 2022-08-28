import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class MessageUtils {
  static void showErrorInFlushBar(BuildContext context, String? message, {int? duration, bool appearFromTop = true}) {
    Flushbar(
      message: message,
      flushbarPosition: appearFromTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      margin: const EdgeInsets.all(8),
      backgroundColor: AppColors.darkGrey,
      icon: const Icon(
        Icons.close_outlined,
        size: 28.0,
        color: Colors.red,
      ),
      duration: Duration(seconds: duration ?? 3),
      leftBarIndicatorColor: Colors.red,
    ).show(context);
  }

  static void showSuccessInFlushBar(BuildContext context, String? message, {int? duration, bool appearFromTop = true}) {
    Flushbar(
      message: message,
      flushbarPosition: appearFromTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      margin: const EdgeInsets.all(8),
      backgroundColor: AppColors.darkGrey,
      icon: const Icon(
        Icons.check_circle,
        size: 28.0,
        color: Colors.green,
      ),
      duration: Duration(seconds: duration ?? 3),
      leftBarIndicatorColor: Colors.green,
    ).show(context);
  }
}