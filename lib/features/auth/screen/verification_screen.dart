import 'package:courir_shipment_app/features/auth/screen/widgets/verification_widgets/pinput_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/verification_widgets/resend_code_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/verification_widgets/submit_button_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/verification_widgets/verification_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/animation_controller.dart';
import '../controller/verify_controller.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({Key? key}) : super(key: key);

  final VerifyController verifyController = Get.put(VerifyController());
  final AnimationShakeController animationShakeController =
      Get.put(AnimationShakeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              right: 6.w,
              left: 6.w,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10.h,
                        left: 10.w,
                        child: Image(
                          image: AssetImage(
                              "assets/images/sammy-line-man-receives-a-mail 1.png"),
                          height: 38.h,
                        ),
                      ),
                      Positioned(
                        top: 51.h,
                        left: 6.w,
                        child: const VerificationHeaderWidget(),
                      ),
                      Positioned(
                        top: 67.h,
                        left: 6.w,
                        right: 6.w,
                        child: const PinputWidget(),
                      ),
                      Positioned(
                        bottom: 10.h,
                        left: 2.w,
                        child: const SubmitButtonWidget(),
                      ),
                      Positioned(
                        bottom: 6.h,
                        right: 3.w,
                        child: const ResendCodeWidget(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
