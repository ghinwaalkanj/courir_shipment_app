import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/button.dart';
import '../../../../../common/widgets/custom_sized_box.dart';
import '../../../../../common/widgets/text_button.dart';

class ActionButtonsWidget extends StatelessWidget {
  final RxBool isLoading;
  final VoidCallback onPressed;
  final bool showBackButton;
  final String continueButtonText;

  const ActionButtonsWidget({
    Key? key,
    required this.isLoading,
    required this.onPressed,
    this.showBackButton = true,
    this.continueButtonText = 'متابعة',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
              () => TButton(
            text: isLoading.value ? 'جاري التحميل...' : continueButtonText,
            onPressed: onPressed,
          ),
        ),
        CustomSizedBox.itemSpacingVertical(),
        if (showBackButton)
          TTextButton(
            text: 'رجوع',
            onPressed: () {
              Get.back();
            },
          ),
      ],
    );
  }
}
