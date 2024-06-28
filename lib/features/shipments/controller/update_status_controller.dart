import 'dart:convert';
import 'package:courir_shipment_app/features/shipments/screens/active_shipments_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/storage_service.dart';
import '../models/update_status_model.dart';
import '../screens/widgets/active_shipmetn_widgets/shipment_to_merchant_sub_screen.dart';

class UpdateShipmentStatusController extends GetxController {
  var isLoading = false.obs;
  var shipmentDetails = Rxn<ShipmentDetails>();

  Future<bool> updateShipmentStatus({
    required String shipmentNumber,
    required int newStatus,
  }) async {
    isLoading.value = true;

    var url = 'https://api.wasenahon.com/Kwickly/delivery/shipments/update_shipment_status.php';
    int? deliveryId = await SharedPreferencesHelper.getInt('user_id');

    var body = {
      'delivery_id': deliveryId.toString(),
      'shipment_number': shipmentNumber,
      'new_status': newStatus.toString(),
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var updateResponse = UpdateShipmentStatusResponse.fromJson(jsonResponse);

        if (updateResponse.status) {
          shipmentDetails.value = updateResponse.shipmentDetails;
          Get.snackbar('Success', updateResponse.message,
              backgroundColor: Colors.green, colorText: Colors.white);
          return true;
        } else {
          Get.snackbar('Error', updateResponse.message,
              backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }
      } else {
        Get.snackbar('Error', 'Failed to update shipment status',
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void _navigateBasedOnStatus(int status) {
    switch (status) {
      case 1:
        Get.to(ActiveShipmentsScreen());
        break;
      case 2:
      // Get.to(SecondScreen());
        break;
      default:
      // Get.to(DefaultScreen());
    }
  }
}
