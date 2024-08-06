import 'package:courir_shipment_app/features/auth/screen/widgets/action_buttons_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/login_widgets/app_name_logo.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/login_widgets/error_text-widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/login_widgets/slogan_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../controller/login_controller.dart';
import 'widgets/login_widgets/label_text_field_widget.dart';
import 'widgets/login_widgets/logo_image_widget.dart';
import 'widgets/login_widgets/privacy_policy_widget.dart';
import 'widgets/login_widgets/phone_text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const LogoImage(),
            SloganText(),
            AppNameLogo(),
            const LabelTextField(),
            const PhoneTextField(),
            const PrivacyPolicy(),
            Positioned(
              bottom: 10.h,
              left: 2.w,
              child: ActionButtonsWidget(
                isLoading: controller.isLoading,
                onPressed: () {
                  if (!controller.isLoading.value &&
                      controller.phoneNumber.value.isNotEmpty &&
                      controller.errorMessage.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '+9627${controller.phoneNumber.value}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: TColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'هل هذا هو رقمك الصحيح؟',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: TColors.textPrimary,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'تعديل',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: TColors.primary,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      controller.login();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: TColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'تأكيد',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'Cairo',
                                        color: TColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
                continueButtonText: 'تسجيل الدخول',
                showBackButton: false,
              ),
            ),
            ErrorText(controller: controller),
          ],
        ),
      ),
    );
  }
}



