import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../resourses/app_colors/app_colors.dart';

class Utils {
  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.black,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void toastMessageCenter(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.black,
      gravity: ToastGravity.CENTER,
    );
  }

  static void snackBar(BuildContext context, String title, String message) {
    final snackBar = SnackBar(
      content: Text(
        "$title\n$message",
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.primaryColor,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
