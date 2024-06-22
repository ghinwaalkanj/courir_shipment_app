import 'package:courir_shipment_app/features/auth/screen/widgets/action_buttons_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/login_widgets/app_name_logo.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/login_widgets/error_text-widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/login_widgets/slogan_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
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
                onPressed: controller.login,
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



