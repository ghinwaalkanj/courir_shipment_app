import 'package:courir_shipment_app/features/Qr_code/screen/widgets/or_divider_widget.dart';
import 'package:courir_shipment_app/features/Qr_code/screen/widgets/qr_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../utils/constants/colors.dart';
import '../controller/barcode_scan_controller.dart';

class BarcodeScanScreen extends StatelessWidget {
  const BarcodeScanScreen({Key? key, this.onPressed}) : super(key: key);
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    QRViewController? controller;
    final BarcodeScanController barcodeController = Get.put(BarcodeScanController());
    void _onQRViewCreated(QRViewController qrController) {
      controller = qrController;
      qrController.scannedDataStream.listen((scanData) {
        barcodeController.updateBarcode(scanData.code ?? "");
        qrController.pauseCamera();
      });
    }

    return Scaffold(
      backgroundColor: TColors.bg,
      body: Padding(
        padding: EdgeInsets.only(top:2.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              GestureDetector(
                onTap: () {
                  controller?.resumeCamera();
                },
                child: Center(
                  child: Container(
                    height: 25.h,
                    width: 60.w,
                    decoration: const BoxDecoration(),
                    child: Center(
                      child: QrViewWidget(
                        qrKey: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Center(
                child: Text(
                  'امسح الرمز لاسترجاع الشحنة!',
                  textDirection: TextDirection.rtl,
                  style: CustomTextStyle.headlineTextStyle
                      .apply(color: TColors.primary, fontSizeFactor: 1.1),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  'يرجى مسح الرمز لاسترجاع الشحنة من المندوب، وذلك لاستكمال عملية الاسترجاع.',
                  textDirection: TextDirection.rtl,
                  style: CustomTextStyle.greyTextStyle.apply(fontSizeFactor: 0.8),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                height: 40.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 3.h, left: 5.w,right:5.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'قم بتوجيه الكاميرا إلى الباركود',
                            style: CustomTextStyle.headlineTextStyle
                                .apply(color: TColors.black, fontSizeFactor: 1.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        CustomSizedBox.textSpacingVertical(),
                        const OrDividerWidget(),
                        SizedBox(height: 2.h),
                        Obx(
                              () => Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              initialValue: barcodeController.barcode.value,
                              decoration: InputDecoration(
                                hintText: 'رقم الشحنة',
                                hintStyle: CustomTextStyle.greyTextStyle,
                                prefixIcon: const Icon(
                                  Icons.qr_code,
                                  color: TColors.primary,
                                ),
                                filled: true,
                                fillColor: TColors.bg,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 14.h),
                        SizedBox(
                          width: double.infinity,
                          height: 7.h,
                          child: ElevatedButton(
                            onPressed:onPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'التالي',
                              style: CustomTextStyle.headlineTextStyle
                                  .apply(color: TColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
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



