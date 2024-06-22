import 'package:courir_shipment_app/features/auth/screen/widgets/action_buttons_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/dropdown_field_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/header_widget.dart';
import 'package:courir_shipment_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/delivery_cities_controller.dart';

class DelieveryCitiesScreen extends StatelessWidget {
  const DelieveryCitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeliveryCitiesController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 6.5.h,
          left: 6.w,
          right: 6.w,
        ),
        child: Column(
          children: [
            SizedBox(height: 8.h),
            HeaderWidget(
                title: 'مناطق التوصيل ',
                subTitle: '',
                desc:
                    'أضف اسم المحافظة ثم اسم المدينة ليتم اختيارها لك في الشحنات المتاحة .',
                currentStep: 4),
            SizedBox(
              height: 8.h,
            ),
            DropdownFieldWidget(
                value: controller.selectedGovernorate.value.isEmpty
                    ? null
                    : controller.selectedGovernorate.value,
                onChanged: (value) {
                  controller.selectedGovernorate.value = value!;
                  controller.validateForm();
                },
                item1: 'عمان',
                item2: 'إربد',
                hintText: "المحافظة"),
            SizedBox(
              height: 30.h,
            ),
            ActionButtonsWidget(
                isLoading: controller.isLoading,
                onPressed: () {
                  Get.to(NavigationMenu());
                }),
          ],
        ),
      ),
    );
  }
}
