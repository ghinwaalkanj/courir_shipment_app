import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/return_to_merchant_dialog.dart';
import 'package:courir_shipment_app/navigation_menu.dart';
import 'package:flutter/cupertino.dart';
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
  final void Function() onDragEnd;
  final void Function() onDragEndReturn;

  CustomerShipmentDialog(
      {required this.total,
      required this.tabIndex,
      required this.onDragEnd,
      required this.onDragEndReturn})
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          showShipmentReturnDialog(
                              context, tabIndex, onDragEndReturn);
                        },
                        child: Text(
                          'إرجاع',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: TColors.error,
                          ),
                        ),
                      ),
                      Text(
                        'المبلغ المقبوض من الزبون',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: TColors.primary,
                        ),
                      ),
                    ],
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
                onDragEnd: onDragEnd),
          ],
        ),
      ),
    );
  }
}

void showShipmentCustomerDialog(BuildContext context, double total,
    int tabIndex, void Function() onDragEnd,void Function() onDragEndReturn) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return CustomerShipmentDialog(
        total: total,
        tabIndex: tabIndex,
        onDragEnd: onDragEnd, onDragEndReturn:onDragEndReturn,
      );
    },
  );
}
