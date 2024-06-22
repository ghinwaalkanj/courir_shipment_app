import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/widgets/text_field.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controller/login_controller.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();
    final TextEditingController phoneController = TextEditingController();

    return Positioned(
      top: 47.h,
      child: TTextField(
        hintText: '--- ---- 7 962+',
        prefixIcon: Icon(Icons.phone_android_outlined, color: TColors.primary, size: 19.sp),
        controller: phoneController,
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          controller.updatePhoneNumber(value);
          phoneController.text = controller.phoneNumber.value;
          phoneController.selection = TextSelection.fromPosition(
            TextPosition(offset: phoneController.text.length),
          );
        },
        showPrefix: true,
        isPhone: true,
      ),
    );
  }
}
