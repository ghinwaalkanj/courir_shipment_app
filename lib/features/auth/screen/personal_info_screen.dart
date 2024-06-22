import 'package:courir_shipment_app/common/styles/custom_textstyle.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/action_buttons_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/header_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/dropdown_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/text_field.dart';
import '../controller/personal_info_controller.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalInfoController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 6.5.h,
            left: 6.w,
            right: 6.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              HeaderWidget(
                  title: 'المعلومات الشخصية',
                  subTitle: 'التالي :  البطاقة الشخصية',
                  desc:
                      'مرحبًا! قبل البدء، يُرجى إدخال معلوماتك الشخصية لتوثيق هويتك والوصول إلى خدماتنا بسهولة.',
                  currentStep: 1),
              SizedBox(height: 7.h),
              TTextField(
                hintText: "الاسم الكامل",
                prefixIcon: Icon(Icons.person_3_outlined),
                controller: controller.fullNameController,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  controller.fullName.value = value;
                  controller.validateForm();
                },
              ),
              SizedBox(height: 2.h),
              TTextField(
                hintText: "الرقم الوطني",
                prefixIcon: Icon(Iconsax.information),
                controller: controller.idController,
                keyboardType: TextInputType.number,
                isNationalID: true,
                onChanged: (value) {
                  controller.nationalId.value = value;
                  controller.validateForm();
                },
              ),
              SizedBox(height: 2.h),
              TTextField(
                hintText: "اسم نشاطك التجاري",
                prefixIcon: Icon(Iconsax.bag_24),
                controller: controller.shopController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  controller.businessName.value = value;
                  controller.validateForm();
                },
              ),
              SizedBox(height: 2.h),
              DropdownFieldWidget(
                value: controller.gender.value.isEmpty
                    ? null
                    : controller.gender.value,
                onChanged: (value) {
                  controller.gender.value = value!;
                  controller.validateForm();
                }, item1: 'ذكر', item2: 'أنثى', hintText: 'النوع',
              ),
              SizedBox(height: 5.h),
              ActionButtonsWidget(
                isLoading: controller.isLoading,
                onPressed: controller.submitPersonalInfo,
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
