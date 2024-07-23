import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controller/page_controller.dart';
import 'draggable_button.dart';

class ReturnShipmentDialog extends StatelessWidget {
  final int tabIndex;
  final TPageController pageController;
  final void Function() onDragEnd;

  ReturnShipmentDialog({required this.tabIndex, required this.onDragEnd})
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
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'هل أنت متأكد أنك تريد إرجاع الشحنة؟',
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
                ],
              ),
            ),
            DraggableConfirmButton(
              dragThreshold: 0.5,
              text: 'قم بالسحب للتأكيد',
              onDragEnd: onDragEnd,
            ),
          ],
        ),
      ),
    );
  }
}

void showShipmentReturnDialog(BuildContext context, int tabIndex, void Function() onDragEnd) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return ReturnShipmentDialog(
        tabIndex: tabIndex,
        onDragEnd: onDragEnd,
      );
    },
  );
}
