import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class SEarchController extends GetxController {
  var isLoading = false.obs;
  var barcode = ''.obs;
  var isFlashOn = false.obs;
  QRViewController? qrController;


  void updateBarcode(String code) {
    barcode.value = code;
  }

  void toggleFlashlight() {
    if (qrController != null) {
      qrController!.toggleFlash();
      isFlashOn.value = !isFlashOn.value;
    }
  }
}
