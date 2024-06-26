import 'package:courir_shipment_app/features/onboarding/screen/widgets/onboarding_back_button_widget.dart';
import 'package:courir_shipment_app/features/onboarding/screen/widgets/onboarding_dot_navigation_widget..dart';
import 'package:courir_shipment_app/features/onboarding/screen/widgets/onboarding_next_button_widget..dart';
import 'package:courir_shipment_app/features/onboarding/screen/widgets/onboarding_page_widget..dart';
import 'package:courir_shipment_app/features/onboarding/screen/widgets/onboarding_skip_widget..dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/text_strings.dart';
import '../controller/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subtitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subtitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subtitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingBackButton(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
