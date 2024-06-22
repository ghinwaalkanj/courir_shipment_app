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

  const QrCodeDisplayScreen({Key? key, required this.shipmentNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: const TAppBar(
        title: 'تسليم الشحنة',
        showBackArrow: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(10.w),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}



