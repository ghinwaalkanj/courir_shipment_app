import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';

class ErrorSnackbar {
  static void show(String message) {
    Get.snackbar(
      'خطأ',
      message,
      backgroundColor: TColors.error,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      icon: Icon(Icons.error_outline, color: Colors.white),
      duration: Duration(seconds: 5),
    );
  }
}
