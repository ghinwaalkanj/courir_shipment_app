import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';

class SuccessSnackbar {
  static void show(String message) {
    Get.snackbar(
      'نجاح',
      message,
      backgroundColor: TColors.primary,
      colorText: TColors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      icon: Icon(Icons.check_circle_outline, color: TColors.white),
      duration: Duration(seconds: 5),
    );
  }
}
