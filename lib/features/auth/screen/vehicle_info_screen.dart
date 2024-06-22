import 'package:courir_shipment_app/common/widgets/text_field.dart';
import 'package:courir_shipment_app/features/auth/controller/vehicle_info_controller.dart';
import 'package:courir_shipment_app/features/auth/screen/dellivery_cities_screen.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/action_buttons_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

class VehicleInfoScreen extends StatelessWidget {
  const VehicleInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VehicleInfoController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(
          top: 6.5.h,
          left: 6.w,
          right: 6.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8.h),
              HeaderWidget(
                title: 'معلومات المركبة',
                subTitle: 'التالي: مناطق التوصيل',
                desc: 'الرجاء إدخال تفاصيل المركبة المستخدمة لتوصيل الشحنات، لضمان سرعة ودقة التسليم.',
                currentStep: 3,
              ),
              SizedBox(height: 7.h),
              Obx(() => Column(
                children: [
                  TTextField(
                    hintText: "نوع المركبة",
                    prefixIcon: Icon(Iconsax.car),
                    controller: controller.vehicleTypeController,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      controller.vehicleTypeError.value = '';
                    },
                    errorText: controller.vehicleTypeError.value.isEmpty ? null : controller.vehicleTypeError.value,
                  ),
                  SizedBox(height: 2.h),
                  TTextField(
                    hintText: "لوحة المركبة",
                    prefixIcon: Icon(Iconsax.card),
                    controller: controller.vehiclePlateController,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      controller.vehiclePlateError.value = '';
                    },
                    errorText: controller.vehiclePlateError.value.isEmpty ? null : controller.vehiclePlateError.value,
                  ),
                  SizedBox(height: 2.h),
                  TTextField(
                    hintText: "موديل المركبة",
                    prefixIcon: Icon(Iconsax.car),
                    controller: controller.vehicleModelController,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      controller.vehicleModelError.value = '';
                    },
                    errorText: controller.vehicleModelError.value.isEmpty ? null : controller.vehicleModelError.value,
                  ),
                  SizedBox(height: 2.h),
                  TTextField(
                    hintText: "لون المركبة",
                    prefixIcon: Icon(Iconsax.paintbucket),
                    controller: controller.vehicleColorController,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      controller.vehicleColorError.value = '';
                    },
                    errorText: controller.vehicleColorError.value.isEmpty ? null : controller.vehicleColorError.value,
                  ),
                ],
              )),
              SizedBox(height: 5.h),
               ActionButtonsWidget(
                onPressed: () {
                  controller.validateForm();
                },
                isLoading: controller.isLoading,
              )
            ],
          ),
        ),
      ),
    );
  }
}
