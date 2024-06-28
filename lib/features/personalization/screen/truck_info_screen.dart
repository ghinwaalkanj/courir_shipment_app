import 'package:courir_shipment_app/common/widgets/app_bar.dart';
import 'package:courir_shipment_app/common/widgets/button.dart';
import 'package:courir_shipment_app/common/widgets/custom_shapes/containers/common_container.dart';
import 'package:courir_shipment_app/common/widgets/text_field.dart';
import 'package:courir_shipment_app/features/personalization/controller/profile_controller.dart';
import 'package:courir_shipment_app/features/personalization/controller/truck_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';

class TruckInfoScreen extends StatelessWidget {
  const TruckInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    final TruckController controller1 = Get.put(TruckController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'معلومات المركبة',
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                height: 20.h,
                image: AssetImage(
                    'assets/gifs/sammy-line-scooter-with-boxes (1).gif'),
              ),
              SizedBox(height: 4.h,),
              Container(
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.sp),
                  ),
                ),
                height: 55.h,
                width: 100.w,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h,bottom: 4.h),
                    child: Obx(() => controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                                color: TColors.primary))
                        : Column(
                            children: [
                              TTextField(
                                hintText: "نوع المركبة",
                                prefixIcon: Icon(Iconsax.car),
                                controller: controller.vehicleTypeController,
                                keyboardType: TextInputType.name,
                              ),
                              SizedBox(height: 2.h),
                              TTextField(
                                hintText: "لوحة المركبة",
                                prefixIcon: Icon(Iconsax.card),
                                controller: controller.vehiclePlateController,
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(height: 2.h),
                              TTextField(
                                hintText: "موديل المركبة",
                                prefixIcon: Icon(Iconsax.car),
                                controller: controller.vehicleModelController,
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(height: 2.h),
                              TTextField(
                                hintText: "لون المركبة",
                                prefixIcon: Icon(Iconsax.paintbucket),
                                controller: controller.vehicleColorController,
                                keyboardType: TextInputType.name,
                              ),
                              Spacer(),
                              TButton(
                                text: 'حفظ',
                                onPressed: () {
                                  controller1.addVehicle(
                                    controller.vehicleTypeController.text,
                                    controller.vehiclePlateController.text,
                                    controller.vehicleModelController.text,
                                    controller.vehicleColorController.text,
                                  );
                                },
                              )
                            ],
                          )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
