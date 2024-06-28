import 'package:courir_shipment_app/features/auth/screen/vehicle_info_screen.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/action_buttons_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/header_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/id_upload_widgets/image_picker_back_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/id_upload_widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../../../utils/constants/colors.dart';
import '../controller/id_upload_controller.dart';

class IDUploadScreen extends StatelessWidget {
  final IDUploadController controller = Get.put(IDUploadController());

  IDUploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      controller.setInitialImages(
        arguments['id_front_image'],
        arguments['id_back_image'],
      );
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 6.5.h,
          left: 6.w,
          right: 6.w,
        ),
        child: Column(
          children: [
            SizedBox(height: 8.h),
            HeaderWidget(
                title: ' صور البطاقة الشخصية',
                subTitle: 'التالي :  معلومات المركبة',
                desc:
                    'تأكد من ظهور صورة الوجه الأمامي والخلفي للبطاقة بشكل واضح وصحيح .',
                currentStep: 2),
            SizedBox(height: 3.h),
            GestureDetector(
              onTap: () => controller.showImagePicker(context, true),
              child: const ImagePickerWidget(),
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () => controller.showImagePicker(context, false),
              child: const ImagePickerBackWidget(),
            ),
            SizedBox(
              height: 4.h,
            ),
            ActionButtonsWidget(
              isLoading: controller.isLoading,
              onPressed: controller.uploadIDImages
            ),
          ],
        ),
      ),
    );
  }
}
