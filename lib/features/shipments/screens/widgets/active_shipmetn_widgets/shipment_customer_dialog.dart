import 'package:courir_shipment_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../controller/page_controller.dart';
import 'draggable_button.dart';

class CustomerShipmentDialog extends StatelessWidget {
  final double total;
  final int tabIndex;
  final TPageController pageController;

  CustomerShipmentDialog({required this.total, required this.tabIndex})
      : pageController = Get.find<TPageController>(tag: 'tab$tabIndex');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Container(
        height: 30.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  Text(
                    'المبلغ المقبوض من الزبون',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                    ),
                  ),
                  SizedBox(height: 7.h),
                  Text('إجمالي قيمة الشحنة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: TColors.primary,
                      )),
                  SizedBox(height: 1.h),
                  Text(
                    '${total.toStringAsFixed(2)} JD ',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            DraggableConfirmButton(
              dragThreshold: 0.5,
              text: 'قم بالسحب للتأكيد',
              onDragEnd: () {
                Navigator.of(context).pop();
                Get.to(NavigationMenu());
                Get.snackbar(
                  'نجاح',
                  'لقد قمت بتسليم الشحنة بنجاح',
                  backgroundColor: TColors.primary,
                  colorText: TColors.white,
                  snackPosition: SnackPosition.TOP,
                  margin: EdgeInsets.all(10),
                  borderRadius: 10,
                  icon: Icon(Icons.check_circle_outline, color: TColors.white),
                  duration: Duration(seconds: 5),
                );

              },
            ),
          ],
        ),
      ),
    );
  }
}

void showShipmentCustomerDialog(BuildContext context, double total, int tabIndex) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomerShipmentDialog(
        total: total,
        tabIndex: tabIndex,
      );
    },
  );
}
