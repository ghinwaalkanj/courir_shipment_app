import 'package:courir_shipment_app/common/widgets/button.dart';
import 'package:courir_shipment_app/features/Qr_code/screen/widgets/Qr_code_display.dart';
import 'package:courir_shipment_app/features/Qr_code/screen/widgets/delivery_code_input.dart';
import 'package:courir_shipment_app/features/Qr_code/screen/widgets/scan_instructions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../common/widgets/divider_with_text.dart';
import '../../../utils/constants/colors.dart';

class QrCodeDisplayScreen extends StatelessWidget {
  final String shipmentNumber;
  final void Function() onPressed;

  const QrCodeDisplayScreen({Key? key, required this.shipmentNumber, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.only(left:10.w,right: 10.w,top: 2.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                QRCodeDisplay(shipmentNumber: shipmentNumber),
                CustomSizedBox.itemSpacingVertical(),
                const ScanInstructions(),
                CustomSizedBox.itemSpacingVertical(height: 0.7.h),
                const DividerWithText(text: "أو"),
                CustomSizedBox.textSpacingVertical(),
                DeliveryCodeInput(shipmentNumber: shipmentNumber),
                CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                SizedBox(
                  width: 85.w,
                  height: 7.h,
                  child: MaterialButton(
                    onPressed:onPressed,
                    color: TColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0.sp),
                    ),
                    child: Text(
                      'تأكيد',
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



