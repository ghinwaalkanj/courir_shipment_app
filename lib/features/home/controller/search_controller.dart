import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/integration/crud.dart';
import '../../../utils/constants/colors.dart';
import '../model/search_model.dart';

class TSearchController extends GetxController {
  var isLoading = false.obs;
  var shipments = <ShipmentResponse>[].obs;

  final Crud crud = Get.find<Crud>();

  void searchShipment(String shipmentNumber) async {
    isLoading.value = true;
    shipments.clear(); // Clear previous shipments

    var response = await crud.postData(
      'https://api.wasenahon.com/Kwickly/delivery/shipments/search_shipment.php',
      {
        'shipment_number': shipmentNumber,
      },
      {},
    );

    isLoading.value = false;

    response.fold(
      (failure) {
        Get.snackbar(
          'خطأ',
          'فشل في البحث عن الشحنة',
          backgroundColor: TColors.error,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: Colors.white),
          duration: Duration(seconds: 5),
        );
      },
      (data) {
        if (data['status']) {
          var shipmentResponse = ShipmentResponse.fromJson(data);
          shipments.add(shipmentResponse);
        } else {
          Get.snackbar(
            'خطأ',
            'لا توجد شحنات مطابقة للرقم المدخل',
            backgroundColor: TColors.error,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.error_outline, color: Colors.white),
            duration: Duration(seconds: 5),
          );
        }
      },
    );
  }
}
