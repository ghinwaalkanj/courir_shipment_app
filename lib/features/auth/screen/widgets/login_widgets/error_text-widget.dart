import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/login_controller.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.errorMessage.isNotEmpty
          ? Positioned(
              top: 55.h,
              left: 2.w,
              right: 2.w,
              child: Text(
                controller.errorMessage.value,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.right,
              ),
            )
          : Container(),
    );
  }
}
