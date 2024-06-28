import 'package:courir_shipment_app/common/widgets/app_bar.dart';
import 'package:courir_shipment_app/common/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../../auth/controller/delivery_cities_controller.dart';

class AddDeliveryCitiesScreen extends StatelessWidget {
  AddDeliveryCitiesScreen({super.key});

  final controller = Get.put(DeliveryCitiesController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TAppBar(
        title: 'إضافة مناطق توصيل',
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(3.w, 0.h, 3.w, 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              height: 35.h,
              image: AssetImage('assets/images/photo.jpg'),
            ),
            Obx(() => Center(
              child: Wrap(
                spacing: 4.w,
                runSpacing: 4.w,
                children: controller.cities.map((city) {
                  final isSelected =
                  controller.selectedGovernorates.contains(city.name);
                  return SizedBox(
                    width: 25.w,
                    child: TweenAnimationBuilder(
                      duration: Duration(milliseconds: 300),
                      tween: Tween<double>(
                          begin: 1.0, end: isSelected ? 1.1 : 1.0),
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
                                    fontFamily: 'Cairo'),
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              controller.toggleSelection(city.name);
                            },
                            selectedColor: TColors.secondary,
                            backgroundColor: Colors.grey[200],
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black,
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
              ),
            )),
            SizedBox(height: 7.h,),
            TButton(
              text: 'حفظ',
              onPressed: () {
                controller.validateForm();
              },
            ),
          ],
        ),
      ),
    );
  }
}
