import 'package:courir_shipment_app/features/auth/screen/widgets/action_buttons_widget.dart';
import 'package:courir_shipment_app/features/auth/screen/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/delivery_cities_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../model/cities_model.dart';

class AddDeliveryAreasScreen extends StatelessWidget {
  const AddDeliveryAreasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeliveryCitiesController());
    final selectedCities = Get.arguments['cities'] as List<City>;
    controller.setSelectedCities(selectedCities);

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
              title: 'مناطق التوصيل',
              subTitle: '',
              desc: 'أضف اسم المحافظة ثم اسم المدينة ليتم اختيارها لك في الشحنات المتاحة.',
              currentStep: 4,
            ),
            SizedBox(height: 9.h),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                return Wrap(
                  spacing: 4.w,
                  runSpacing: 4.w,
                  children: controller.cities.map((city) {
                    final isSelected = controller.selectedGovernorates.contains(city.name);
                    return SizedBox(
                      width: 25.w,
                      child: TweenAnimationBuilder(
                        duration: Duration(milliseconds: 300),
                        tween: Tween<double>(begin: 1.0, end: isSelected ? 1.1 : 1.0),
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: ChoiceChip(
                              label: Center(
                                child: Text(
                                  city.name,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (selected) {
                                controller.toggleSelection(city.name);
                              },
                              selectedColor: TColors.secondary,
                              backgroundColor: Colors.grey[200],
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 5,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              padding: EdgeInsets.symmetric(
                                vertical: 1.5.h,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              }),
            ),
            SizedBox(height: 5.h),
            ActionButtonsWidget(
              isLoading: controller.isLoading,
              onPressed: () async {
                 controller.addDeliveryCities();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isAuth', true);
              },
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
