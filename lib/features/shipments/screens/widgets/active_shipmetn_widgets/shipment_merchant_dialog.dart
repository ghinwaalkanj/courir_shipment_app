import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../controller/page_controller.dart';
import 'draggable_button.dart';

class MerchantShipmentDialog extends StatelessWidget {
  final double shipmentAmount;
  final double deliveryFee;
  final int tabIndex;
  final TPageController pageController;

  MerchantShipmentDialog(
      {required this.shipmentAmount,
        required this.deliveryFee,
        required this.tabIndex})
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
                    'تفاصيل الشحنة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '  مبلغ الشحنة: JD${shipmentAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'سعر التوصيل: JD${deliveryFee.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            DraggableConfirmButton(
              dragThreshold: 0.5,
              text: 'قم بالسحب للتأكيد',
              onDragEnd: () {
                pageController.changePage(2);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showShipmentMerchantDialog(
    BuildContext context, double shipmentAmount, double deliveryFee, int tabIndex) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return MerchantShipmentDialog(
        shipmentAmount: shipmentAmount,
        deliveryFee: deliveryFee,
        tabIndex: tabIndex,
      );
    },
  );
}
