import 'package:courir_shipment_app/common/widgets/button.dart';
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
  const BarcodeScanScreen({Key? key, required this.onBarcodeScanned}) : super(key: key);
  final void Function(String barcode) onBarcodeScanned;

  @override
  Widget build(BuildContext context) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    QRViewController? controller;
    final BarcodeScanController barcodeController = Get.put(BarcodeScanController());

    void _onQRViewCreated(QRViewController qrController) {
      controller = qrController;
      qrController.scannedDataStream.listen((scanData) {
        final barcode = scanData.code ?? "";
        barcodeController.updateBarcode(barcode);
        qrController.pauseCamera();
        onBarcodeScanned(barcode); // استدعاء الدالة عند مسح الباركود
      });
    }

    return Scaffold(
      backgroundColor: TColors.bg,
      body: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  controller?.resumeCamera();
                },
                child: Center(
                  child: Container(
                    height: 30.h,
                    width: 70.w,
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
              SizedBox(height: 7.h),
              Container(
                height: 40.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 3.h, left: 5.w, right: 5.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            '! امسح الرمز لاستلام الشحنة',
                            style: CustomTextStyle.headlineTextStyle
                                .apply(color: TColors.primary, fontSizeFactor: 1.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        CustomSizedBox.textSpacingVertical(),
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
