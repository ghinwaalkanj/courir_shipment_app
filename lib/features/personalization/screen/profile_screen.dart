import 'package:courir_shipment_app/features/personalization/screen/widgets/profile_widgets/profile_buttons.dart';
import 'package:courir_shipment_app/features/personalization/screen/widgets/profile_widgets/profile_text_field.dart';
import 'package:courir_shipment_app/features/personalization/screen/widgets/profile_widgets/trader_ranking_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../common/widgets/custom_shapes/containers/common_container.dart';
import '../../../utils/constants/colors.dart';
import '../../auth/screen/widgets/dropdown_field_widget.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const TAppBar(
        title: 'المعلومات الشخصية',
        showBackArrow: true,
      ),
      backgroundColor: TColors.bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator(color: TColors.primary))
              : SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomSizedBox.itemSpacingVertical(),
                      TraderRankingWidget(
                        rankingPercentage: 50.0,
                        totalShipments: controller.totalShipments.value, rating: 3.5,
                      ),
                      CustomSizedBox.itemSpacingVertical(),
                      CommonContainer(
                        height: 70.h,
                        width: 100.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 5.w),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ProfileTextField(
                                  labelText: 'الاسم بالكامل',
                                  controller: controller.nameController,
                                ),
                                CustomSizedBox.itemSpacingVertical(
                                    height: 0.5.h),
                                ProfileTextField(
                                  labelText: 'رقم الهاتف',
                                  controller: controller.phoneController,
                                ),
                                CustomSizedBox.itemSpacingVertical(
                                    height: 0.5.h),
                                DropdownFieldWidget(
                                  value: controller.gender.value.isEmpty
                                      ? null
                                      : controller.gender.value,
                                  onChanged: (value) {
                                    controller.gender.value = value!;
                                  },
                                  item1: 'ذكر',
                                  item2: 'أنثى',
                                  hintText: 'النوع',
                                ),
                                CustomSizedBox.itemSpacingVertical(
                                    height: 0.5.h),
                                ProfileButtons(
                                  controller: controller,
                                  onPressed: () {
                                    controller.editProfile(
                                        controller.nameController.text,
                                        controller.phoneController.text,
                                      controller.gender.value
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
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
